library(ggseg.extra)
library(ggseg.formats)
library(dplyr)

cli::cli_h1("Harvard-Oxford Atlas 2.0 - cortical")

# The subcortical and cerebellar atlases are built by
# data-raw/make_ho2_subcortical.R.
#
# Run with: source("data-raw/make_ho2_cortical.R")

cort_lh_src <- here::here("data-raw", "ho2", "ho2_cort_maxprob_left.nii.gz")
cort_rh_src <- here::here("data-raw", "ho2", "ho2_cort_maxprob_right.nii.gz")

for (f in c(cort_lh_src, cort_rh_src)) {
  if (!file.exists(f)) {
    cli::cli_abort("Source not found: {.path {f}}")
  }
}

fs_home <- Sys.getenv("FREESURFER_HOME", "/Applications/freesurfer/7.4.1")
Sys.setenv(FREESURFER_HOME = fs_home)
Sys.setenv(SUBJECTS_DIR = file.path(fs_home, "subjects"))

aparc_aseg_src <- file.path(
  fs_home,
  "subjects/cvs_avg35_inMNI152/mri/aparc+aseg.mgz"
)
if (!file.exists(aparc_aseg_src)) {
  cli::cli_abort("aparc+aseg source not found: {.path {aparc_aseg_src}}")
}

cvs_brain_src <- file.path(
  fs_home,
  "subjects/cvs_avg35_inMNI152/mri/brain.mgz"
)

work_dir <- here::here("data-raw", "ho2")
dir.create(file.path(work_dir, "ho2"), showWarnings = FALSE, recursive = TRUE)

aparc_aseg_nii <- file.path(work_dir, "aparc_aseg_1mm.nii.gz")
if (!file.exists(aparc_aseg_nii)) {
  system2(
    "mri_convert",
    c(
      shQuote(aparc_aseg_src),
      shQuote(aparc_aseg_nii)
    )
  )
}

cvs_brain_mask <- file.path(work_dir, "cvs_brain_mask.nii.gz")
if (!file.exists(cvs_brain_mask)) {
  tmp_brain <- tempfile(fileext = ".nii.gz")
  system2("mri_convert", c(shQuote(cvs_brain_src), shQuote(tmp_brain)))
  bvol <- RNifti::readNifti(tmp_brain)
  bmask <- (as.array(bvol) > 0) * 1L
  storage.mode(bmask) <- "integer"
  RNifti::writeNifti(
    RNifti::asNifti(bmask, reference = bvol),
    cvs_brain_mask
  )
}

cli::cli_h2("Cortical: resample LH/RH to cvs grid and combine")

cort_lh_cvs <- file.path(work_dir, "ho2_cort_lh_cvs.nii.gz")
cort_rh_cvs <- file.path(work_dir, "ho2_cort_rh_cvs.nii.gz")

if (!file.exists(cort_lh_cvs)) {
  system2(
    "mri_vol2vol",
    c(
      "--mov",
      shQuote(cort_lh_src),
      "--targ",
      shQuote(aparc_aseg_src),
      "--regheader",
      "--interp",
      "nearest",
      "--o",
      shQuote(cort_lh_cvs)
    )
  )
}
if (!file.exists(cort_rh_cvs)) {
  system2(
    "mri_vol2vol",
    c(
      "--mov",
      shQuote(cort_rh_src),
      "--targ",
      shQuote(aparc_aseg_src),
      "--regheader",
      "--interp",
      "nearest",
      "--o",
      shQuote(cort_rh_cvs)
    )
  )
}

lh_arr <- as.array(RNifti::readNifti(cort_lh_cvs))
rh_arr <- as.array(RNifti::readNifti(cort_rh_cvs))
storage.mode(lh_arr) <- "integer"
storage.mode(rh_arr) <- "integer"

cort_arr <- array(0L, dim = dim(lh_arr))
cort_arr[lh_arr > 0] <- lh_arr[lh_arr > 0]
rh_mask <- rh_arr > 0
cort_arr[rh_mask] <- rh_arr[rh_mask] + 49L

cort_combined <- file.path(work_dir, "ho2_cort_combined.nii.gz")
RNifti::writeNifti(
  RNifti::asNifti(cort_arr, reference = RNifti::readNifti(aparc_aseg_nii)),
  cort_combined
)

cort_lut <- readr::read_tsv(
  here::here("data-raw", "hoa2", "cortical_combined_lut.txt"),
  col_names = c("idx", "label", "R", "G", "B", "A"),
  col_types = "icnnni"
)
cort_lut$type <- "cortical"

sub_full_lut <- readr::read_tsv(
  here::here("data-raw", "hoa2", "subcortical_lut.txt"),
  col_names = c("idx", "label", "R", "G", "B", "A"),
  col_types = "icnnni"
)
keep_sub_orig_ids <- c(7:17, 20:23, 25:32)
keep_sub_ids <- keep_sub_orig_ids + 200L
sub_lut <- sub_full_lut[sub_full_lut$idx %in% keep_sub_orig_ids, ]
sub_lut$idx <- sub_lut$idx + 200L
sub_lut$label <- gsub("_", " ", sub_lut$label)
sub_lut$type <- "subcortical"

combined_lut <- bind_rows(cort_lut, sub_lut)

lut_file <- file.path(work_dir, "ho2_LUT.txt")
readr::write_tsv(combined_lut, lut_file)

cli::cli_h2("Cortical: wholebrain pipeline (cortical step only)")

options(ggseg.extra.snapshot_dim = 1600)

cort_atlases <- create_wholebrain_from_volume(
  input_volume = cort_combined,
  input_lut = combined_lut[combined_lut$type == "cortical", ],
  atlas_name = "ho2_cortical",
  output_dir = work_dir,
  regheader = TRUE,
  cortical_labels = combined_lut$idx[combined_lut$type == "cortical"],
  subcortical_labels = integer(0),
  skip_existing = TRUE,
  cleanup = FALSE,
  verbose = TRUE,
  steps = 1:3
)

.ho2_cort <- cort_atlases$cortical
.ho2_cort$core$region <- gsub("^[lr]h_", "", .ho2_cort$core$label)

cli::cli_alert_success(
  "Cortical: {nrow(.ho2_cort$core)} regions"
)

# --- Save -------------------------------------------------------------------
# Carry over every other object already in sysdata so rebuilding the cortical
# atlas never drops the subcortical and cerebellar ones.

e <- new.env()
if (file.exists("R/sysdata.rda")) {
  load("R/sysdata.rda", envir = e)
}
e$.ho2_cort <- .ho2_cort

save(
  list = ls(e, all.names = TRUE),
  envir = e,
  file = "R/sysdata.rda",
  compress = "xz"
)
