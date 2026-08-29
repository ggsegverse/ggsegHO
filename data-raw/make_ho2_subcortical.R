# Harvard-Oxford Atlas 2.0 — subcortical and cerebellar
#
# HOA-2 ships on a 0.7 mm grid that shares the FSL-MNI152 world affine, so the
# parcels can be embedded into fsaverage5's aseg through the known MNI152
# registration rather than a searched one. That is what ggseg.extra's
# prepare_subcortical_mni152() does, and it is the same route hoSub takes in
# make_ho.R — the two subcortical atlases in this package now build the same way.
#
# Run with: source("data-raw/make_ho2_subcortical.R")

library(ggseg.extra)
library(ggseg.formats)

cli::cli_h1("Harvard-Oxford Atlas 2.0 - subcortical")

work_dir <- here::here("data-raw", "ho2")
src <- file.path(work_dir, "ho2_combined.nii.gz")
mni1mm <- here::here(
  "data-raw",
  "HarvardOxford-cort_and_sub-maxprob-thr25-1mm.nii.gz"
)

for (f in c(src, mni1mm)) {
  if (!file.exists(f)) cli::cli_abort("Source not found: {.path {f}}")
}

fs_home <- Sys.getenv("FREESURFER_HOME", "/Applications/freesurfer/7.4.1")
Sys.setenv(FREESURFER_HOME = fs_home)
Sys.setenv(SUBJECTS_DIR = file.path(fs_home, "subjects"))

lut_all <- utils::read.delim(
  here::here("data-raw", "hoa2", "subcortical_lut.txt"),
  header = FALSE,
  col.names = c("idx", "label", "R", "G", "B", "A")
)

# The published HOA-2 colours are kept as-is, including a left/right pair
# sharing one colour: that is how the atlas authors distribute it.
subcortical_ids <- c(7:17, 20:23, 25:28)
cerebellar_ids <- 29:32

# Offset so HOA-2 ids never collide with the aseg context ids they are
# stamped into (HOA-2 11 is Putamen-L, aseg 11 is Caudate-L).
OFFSET <- 200L

build_lut <- function(ids) {
  lut <- lut_all[lut_all$idx %in% ids, ]
  lut$idx <- lut$idx + OFFSET
  lut$label <- gsub("_", " ", lut$label)
  lut[, c("idx", "label", "R", "G", "B", "A")]
}

# --- Resample HOA-2 onto the 1 mm MNI152 grid -------------------------------
# mni152.register.dat is defined against the 1 mm 182x218x182 template, so the
# 0.7 mm source is resampled onto that grid first. Both share a world affine,
# which makes --regheader exact; nearest-neighbour keeps the labels intact.

resample_to_mni1mm <- function(in_file, out_file) {
  if (file.exists(out_file)) {
    return(out_file)
  }
  status <- system2(
    "mri_vol2vol",
    c(
      "--mov",
      shQuote(in_file),
      "--targ",
      shQuote(mni1mm),
      "--regheader",
      "--interp",
      "nearest",
      "--o",
      shQuote(out_file)
    )
  )
  if (status != 0 || !file.exists(out_file)) {
    cli::cli_abort("mri_vol2vol failed for {.path {in_file}}")
  }
  out_file
}

remap <- function(ids, out_file) {
  vol <- RNifti::readNifti(src)
  arr <- as.array(vol)
  storage.mode(arr) <- "integer"
  out <- array(0L, dim = dim(arr))
  for (id in ids) {
    out[arr == id] <- id + OFFSET
  }
  RNifti::writeNifti(RNifti::asNifti(out, reference = vol), out_file)
  out_file
}

# --- Subcortical ------------------------------------------------------------

sub_07 <- remap(subcortical_ids, file.path(work_dir, "ho2_sub_0.7mm.nii.gz"))
sub_10 <- resample_to_mni1mm(sub_07, file.path(work_dir, "ho2_sub_1mm.nii.gz"))

sub_lut <- build_lut(subcortical_ids)
sub_ids <- sub_lut$idx

# HOA-2 subdivides the lumped aseg structures, and additionally covers the
# brain-stem (16) and the ventral diencephalon (28 / 60), so those are cleared
# from the context too rather than showing through underneath the parcels.
merged <- prepare_subcortical_mni152(
  input_volume = sub_10,
  labels = sub_ids,
  lut = sub_lut,
  replace_labels = c(aseg_subcortical_labels(), 16L, 28L, 60L),
  output_file = file.path(work_dir, "ho2_sub_in_aseg.nii.gz")
)

sub_slabs <- subcortical_slabs(
  merged$volume,
  labels = sub_ids,
  coronal = 3,
  axial = 3,
  pad = 2
)

ho2_sub_raw <- create_subcortical_from_volume(
  input_volume = merged,
  atlas_name = "ho2_sub",
  output_dir = work_dir,
  slabs = sub_slabs,
  dilate = 2L,
  skip_existing = TRUE,
  cleanup = FALSE
)

focus_re <- paste(gsub(" ", ".", sub_lut$label), collapse = "|")

.ho2_sub <- ho2_sub_raw |>
  aseg_context(focus = focus_re, match_on = "label") |>
  atlas_view_gather() |>
  atlas_smooth(smoothness = 0.4, exclude = "^cortex") |>
  atlas_smooth(smoothness = 1, labels = "^cortex") |>
  atlas_smooth(keep = 0.2)

# --- Cerebellar -------------------------------------------------------------
# The cerebellar parcels replace the aseg cerebellum (8 / 47 cortex, 7 / 46
# white matter) and are drawn in the same grey brain, so the four structures
# read as parts of a head rather than as a floating mass.

cereb_07 <- remap(
  cerebellar_ids,
  file.path(work_dir, "ho2_cereb_0.7mm.nii.gz")
)
cereb_10 <- resample_to_mni1mm(
  cereb_07,
  file.path(work_dir, "ho2_cereb_1mm.nii.gz")
)

cereb_lut <- build_lut(cerebellar_ids)
cereb_ids <- cereb_lut$idx

merged_cereb <- prepare_subcortical_mni152(
  input_volume = cereb_10,
  labels = cereb_ids,
  lut = cereb_lut,
  replace_labels = c(7L, 8L, 46L, 47L),
  output_file = file.path(work_dir, "ho2_cereb_in_aseg.nii.gz")
)

cereb_slabs <- subcortical_slabs(
  merged_cereb$volume,
  labels = cereb_ids,
  coronal = 2,
  axial = 2,
  sagittal = 1,
  pad = 2
)

ho2_cereb_raw <- create_subcortical_from_volume(
  input_volume = merged_cereb,
  atlas_name = "ho2_cereb",
  output_dir = work_dir,
  slabs = cereb_slabs,
  dilate = 2L,
  skip_existing = TRUE,
  cleanup = FALSE
)

.ho2_cereb <- ho2_cereb_raw |>
  aseg_context(
    focus = paste(gsub(" ", ".", cereb_lut$label), collapse = "|"),
    match_on = "label"
  ) |>
  atlas_view_gather() |>
  atlas_smooth(smoothness = 0.4, exclude = "^cortex") |>
  atlas_smooth(smoothness = 1, labels = "^cortex") |>
  atlas_smooth(keep = 0.2)

# The pipeline returns a subcortical payload; the atlas is cerebellar, and
# ggseg_atlas() couples type to payload class, so the payload is rebuilt with
# the matching constructor rather than retyped in place. geom and meshes carry
# over unchanged — ggseg_data_cerebellar() holds both.
.ho2_cereb <- ggseg_atlas(
  atlas = "ho2_cereb",
  type = "cerebellar",
  core = .ho2_cereb$core,
  data = ggseg_data_cerebellar(
    geom = atlas_geom(.ho2_cereb),
    meshes = atlas_meshes(.ho2_cereb)
  ),
  palette = atlas_palette(.ho2_cereb)
)

cli::cli_alert_success(
  "Subcortical: {length(atlas_regions(.ho2_sub))} regions in \\
   {length(atlas_views(.ho2_sub))} views; \\
   cerebellar: {length(atlas_regions(.ho2_cereb))} regions in \\
   {length(atlas_views(.ho2_cereb))} views"
)

# --- Save -------------------------------------------------------------------
# Carry over every other object already in sysdata so rebuilding one atlas
# never drops the others.

e <- new.env()
if (file.exists("R/sysdata.rda")) {
  load("R/sysdata.rda", envir = e)
}
e$.ho2_sub <- .ho2_sub
e$.ho2_cereb <- .ho2_cereb

save(
  list = ls(e, all.names = TRUE),
  envir = e,
  file = "R/sysdata.rda",
  compress = "xz"
)
