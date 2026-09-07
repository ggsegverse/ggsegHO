# Harvard-Oxford Atlas 2.0 - subcortical
#
# HOA-2 ships on a 0.7 mm grid that shares the FSL-MNI152 world affine, so the
# parcels can be embedded into fsaverage5's aseg through the known MNI152
# registration rather than a searched one. That is what ggseg.extra's
# prepare_subcortical_mni152() does, and it is the same route ho_sub takes in
# make_ho.R - the two subcortical atlases in this package build the same way.
#
# The four cerebellar labels are part of this atlas rather than an atlas of
# their own. HOA-2 divides the cerebellum into grey and white matter only,
# which is a tissue segmentation like the rest of the subcortical volume, not a
# cerebellar parcellation in the sense of SUIT or Buckner.
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

# Deep structures (7-17, 20-23, 25-28) and the cerebellar grey/white matter
# split (29-32). Ventricles, CSF and the optic chiasm are left to the aseg
# context.
keep_ids <- c(7:17, 20:23, 25:32)

# Offset so HOA-2 ids never collide with the aseg context ids they are
# stamped into (HOA-2 11 is Putamen-L, aseg 11 is Caudate-L).
OFFSET <- 200L

lut <- lut_all[lut_all$idx %in% keep_ids, ]
lut$idx <- lut$idx + OFFSET
lut$label <- gsub("_", " ", lut$label)
lut <- lut[, c("idx", "label", "R", "G", "B", "A")]
ids <- lut$idx

# --- Resample HOA-2 onto the 1 mm MNI152 grid -------------------------------
# mni152.register.dat is defined against the 1 mm 182x218x182 template, so the
# 0.7 mm source is resampled onto that grid first. Both share a world affine,
# which makes --regheader exact; nearest-neighbour keeps the labels intact.

remapped <- file.path(work_dir, "ho2_sub_0.7mm.nii.gz")
vol <- RNifti::readNifti(src)
arr <- as.array(vol)
storage.mode(arr) <- "integer"
out <- array(0L, dim = dim(arr))
for (id in keep_ids) {
  out[arr == id] <- id + OFFSET
}
RNifti::writeNifti(RNifti::asNifti(out, reference = vol), remapped)

on_mni1mm <- file.path(work_dir, "ho2_sub_1mm.nii.gz")
status <- system2(
  "mri_vol2vol",
  c(
    "--mov",
    shQuote(remapped),
    "--targ",
    shQuote(mni1mm),
    "--regheader",
    "--interp",
    "nearest",
    "--o",
    shQuote(on_mni1mm)
  )
)
if (status != 0 || !file.exists(on_mni1mm)) {
  cli::cli_abort("mri_vol2vol failed for {.path {remapped}}")
}

# --- Embed in the fsaverage5 aseg -------------------------------------------
# HOA-2 subdivides the lumped aseg structures and additionally covers the
# brain-stem (16), the ventral diencephalon (28 / 60) and the cerebellum
# (7 / 8 / 46 / 47), so those are cleared from the context too rather than
# showing through underneath the parcels.

merged <- prepare_subcortical_mni152(
  input_volume = on_mni1mm,
  labels = ids,
  lut = lut,
  replace_labels = c(
    aseg_subcortical_labels(),
    16L,
    28L,
    60L,
    7L,
    8L,
    46L,
    47L
  ),
  output_file = file.path(work_dir, "ho2_sub_in_aseg.nii.gz")
)

# Four slabs, fixed rather than derived, because the derived set has two
# problems here. It returns seven, which crowds the row; and its single
# sagittal cut spans the whole head (x 75-181, with the midline at 129), so
# both hemispheres flatten onto one panel and every left structure is drawn
# underneath its right twin - the left caudate came out with 8% of it
# visible. Cutting the sagittal on one side of the midline fixes that.
slabs <- rbind(
  data.frame(name = "axial_1", type = "axial", start = 92, end = 120),
  data.frame(name = "axial_2", type = "axial", start = 121, end = 151),
  data.frame(name = "coronal_1", type = "coronal", start = 114, end = 153),
  data.frame(name = "sagittal_1", type = "sagittal", start = 78, end = 128)
)

raw <- create_subcortical_from_volume(
  input_volume = merged,
  atlas_name = "ho2_sub",
  output_dir = work_dir,
  slabs = slabs,
  skip_existing = FALSE,
  cleanup = FALSE
)

# Smoothing, dilation and vertex reduction all happen here rather than in the
# pipeline, so retuning any of them is seconds rather than a rebuild.
#
# The structures are grown a little to survive at plotting size; the grey
# brain is not, since dilating a silhouette closes its sulci.
.ho2_sub <- raw |>
  aseg_context(
    focus = paste(gsub(" ", ".", lut$label), collapse = "|"),
    match_on = "label"
  ) |>
  atlas_view_gather() |>
  atlas_dilate(0.6, exclude = "^cortex") |>
  # atlas_smooth() simplifies to keep = 0.05 unless told otherwise, so the
  # previous three passes left the cortex silhouette on ~1% of its vertices
  # and smoothed at full strength: a blob with no gyri. These are the values
  # the bundled aseg uses, and they land the silhouette at a comparable
  # vertex count (aseg 9k, here 10k).
  atlas_smooth(keep = NULL, smoothness = 0.4, exclude = "^cortex") |>
  atlas_smooth(keep = 0.3, smoothness = 0.4, labels = "^cortex")

# geom_brain() paints the rows in order, so the last one lands on top. Sorting
# by structure with the two sides adjacent keeps a structure at the same depth
# as its contralateral twin; the pipeline's own order had Thalamus_Right last
# and Thalamus_Left twelve rows earlier, which is why the right thalamus sat
# in front of the pink ventral diencephalon and the left one behind it.
drawn <- atlas_geom(.ho2_sub)$label
is_context <- grepl("^cortex|Cerebellum-|Optic-Chiasm", drawn)

by_structure <- function(x) x[order(sub("_(Left|Right)$", "", x), x)]

.ho2_sub <- atlas_structure_reorder(
  .ho2_sub,
  c(by_structure(drawn[is_context]), by_structure(drawn[!is_context]))
)

cli::cli_alert_success(
  "{length(atlas_labels(.ho2_sub))} structures in \\
   {length(atlas_views(.ho2_sub))} views"
)

# --- Save -------------------------------------------------------------------
# Carry over every other object already in sysdata so rebuilding one atlas
# never drops the others.

e <- new.env()
if (file.exists("R/sysdata.rda")) {
  load("R/sysdata.rda", envir = e)
}
e$.ho2_sub <- .ho2_sub
if (".ho2_cereb" %in% ls(e, all.names = TRUE)) {
  rm(".ho2_cereb", envir = e)
}

save(
  list = ls(e, all.names = TRUE),
  envir = e,
  file = "R/sysdata.rda",
  compress = "xz"
)
