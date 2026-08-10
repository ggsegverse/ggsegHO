library(ggseg.extra)
library(ggseg.formats)
# https://neurovault.org/collections/262/
library(RNifti)

# --- Labels ---

subcortical_labels <- c(
  "Left Lateral Ventricle",
  "Left Thalamus",
  "Left Caudate",
  "Left Putamen",
  "Left Pallidum",
  "Brain-Stem",
  "Left Hippocampus",
  "Left Amygdala",
  "Left Accumbens",
  "Right Lateral Ventricle",
  "Right Thalamus",
  "Right Caudate",
  "Right Putamen",
  "Right Pallidum",
  "Right Hippocampus",
  "Right Amygdala",
  "Right Accumbens"
)

cortical_labels <- c(
  "Frontal Pole",
  "Insular Cortex",
  "Superior Frontal Gyrus",
  "Middle Frontal Gyrus",
  "Inferior Frontal Gyrus pars triangularis",
  "Inferior Frontal Gyrus pars opercularis",
  "Precentral Gyrus",
  "Temporal Pole",
  "Superior Temporal Gyrus anterior",
  "Superior Temporal Gyrus posterior",
  "Middle Temporal Gyrus anterior",
  "Middle Temporal Gyrus posterior",
  "Middle Temporal Gyrus temporooccipital",
  "Inferior Temporal Gyrus anterior",
  "Inferior Temporal Gyrus posterior",
  "Inferior Temporal Gyrus temporooccipital",
  "Postcentral Gyrus",
  "Superior Parietal Lobule",
  "Supramarginal Gyrus anterior",
  "Supramarginal Gyrus posterior",
  "Angular Gyrus",
  "Lateral Occipital Cortex superior",
  "Lateral Occipital Cortex inferior",
  "Intracalcarine Cortex",
  "Frontal Medial Cortex",
  "Juxtapositional Lobule Cortex",
  "Subcallosal Cortex",
  "Paracingulate Gyrus",
  "Cingulate Gyrus anterior",
  "Cingulate Gyrus posterior",
  "Precuneous Cortex",
  "Cuneal Cortex",
  "Frontal Orbital Cortex",
  "Parahippocampal Gyrus anterior",
  "Parahippocampal Gyrus posterior",
  "Lingual Gyrus",
  "Temporal Fusiform Cortex anterior",
  "Temporal Fusiform Cortex posterior",
  "Temporal Occipital Fusiform Cortex",
  "Occipital Fusiform Gyrus",
  "Frontal Operculum Cortex",
  "Central Opercular Cortex",
  "Parietal Operculum Cortex",
  "Planum Polare",
  "Heschls Gyrus",
  "Planum Temporale",
  "Supracalcarine Cortex",
  "Occipital Pole"
)

# --- Prepare combined volume ---
# Combined HO atlas label scheme:
#   1, 12     = White matter (excluded from LUT, zeroed by pipeline)
#   3-11      = Left subcortical
#   14-21     = Right subcortical
#   101-148   = Cortical regions
#
# Subcortical label 3 (Left Lateral Ventricle) conflicts with FS cortex
# reference label 3 that wholebrain_prepare_subcortical_volume uses for
# brain outline geometry. Remap subcortical IDs to 200+ to avoid this.

vol <- readNifti("data-raw/HarvardOxford-cort_and_sub-maxprob-thr25-1mm.nii.gz")
arr <- as.array(vol)

subcort_orig_ids <- c(3:11, 14:21)
subcort_remapped_ids <- subcort_orig_ids + 200L

remapped <- array(0L, dim = dim(arr))
for (i in seq_along(subcort_orig_ids)) {
  remapped[arr == subcort_orig_ids[i]] <- subcort_remapped_ids[i]
}
for (idx in 101:148) {
  remapped[arr == idx] <- idx
}

remapped_path <- "data-raw/ho_combined_remapped.nii.gz"
writeNifti(asNifti(remapped, reference = vol), remapped_path)

# --- Build LUT with type column ---

set.seed(42)
n <- length(cortical_labels) + length(subcortical_labels)
palette_r <- sample(50:220, n, replace = TRUE)
palette_g <- sample(50:220, n, replace = TRUE)
palette_b <- sample(50:220, n, replace = TRUE)

lut <- data.frame(
  idx = c(subcort_remapped_ids, 101:148),
  label = c(subcortical_labels, cortical_labels),
  R = palette_r,
  G = palette_g,
  B = palette_b,
  A = rep(255L, n),
  type = c(
    rep("subcortical", length(subcortical_labels)),
    rep("cortical", length(cortical_labels))
  ),
  stringsAsFactors = FALSE
)

# --- Create cortical + subcortical atlas in one pipeline call ---

ho <- create_wholebrain_from_volume(
  input_volume = remapped_path,
  input_lut = lut,
  atlas_name = "ho",
  output_dir = "data-raw",
  skip_existing = FALSE,
  cleanup = FALSE
)

# --- Post-processing: smooth and simplify outside the pipeline ---

.hoCort <- ho$cortical
.hoCort$core$region <- gsub("^[lr]h_", "", .hoCort$core$label)
.hoCort <- .hoCort |>
  atlas_smooth(smoothness = 5) |>
  atlas_simplify(keep = 0.3)

# --- Subcortical on grey-brain anatomical context ---
# The HO subcortical structures are aseg-equivalent, so rather than let them
# float alone we embed them into the fsaverage5 aseg with
# ggseg.extra::prepare_subcortical_mni152() and render on grey context (cortex /
# white matter / cerebellum / brain-stem), matching the FreeSurfer subcortical
# atlases. Requires FreeSurfer 7.4.1 + fsaverage5.
#
# HO subcortical id -> aseg-style name (lateral ventricles excluded); remap by
# +300 so ids never collide with aseg or HO cortical labels.
ho_sub_map <- c(
  "4" = "Left-Thalamus",
  "5" = "Left-Caudate",
  "6" = "Left-Putamen",
  "7" = "Left-Pallidum",
  "8" = "Brain-Stem",
  "9" = "Left-Hippocampus",
  "10" = "Left-Amygdala",
  "11" = "Left-Accumbens",
  "15" = "Right-Thalamus",
  "16" = "Right-Caudate",
  "17" = "Right-Putamen",
  "18" = "Right-Pallidum",
  "19" = "Right-Hippocampus",
  "20" = "Right-Amygdala",
  "21" = "Right-Accumbens"
)
ho_sub_ids <- as.integer(names(ho_sub_map))
new_ids <- ho_sub_ids + 300L

sub_mni <- "data-raw/ho_sub_mni.nii.gz"
sub_arr <- array(0L, dim = dim(arr))
for (i in seq_along(ho_sub_ids)) {
  sub_arr[arr == ho_sub_ids[i]] <- new_ids[i]
}
writeNifti(asNifti(sub_arr, reference = vol), sub_mni)

set.seed(7)
foc_cols <- grDevices::hcl.colors(length(new_ids), "Dark 3")
foc_rgb <- grDevices::col2rgb(foc_cols)
foc_lut <- data.frame(
  idx = new_ids,
  label = unname(ho_sub_map),
  R = as.integer(foc_rgb[1, ]),
  G = as.integer(foc_rgb[2, ]),
  B = as.integer(foc_rgb[3, ]),
  A = 0L,
  stringsAsFactors = FALSE
)

# A parcel covers the brain-stem, so aseg 16 is replaced in addition to the
# lumped subcortical structures.
merged <- prepare_subcortical_mni152(
  input_volume = sub_mni,
  labels = new_ids,
  lut = foc_lut,
  replace_labels = c(aseg_subcortical_labels(), 16L)
)

sub_slabs <- subcortical_slabs(
  merged$volume,
  labels = new_ids,
  coronal = 3,
  axial = 3,
  pad = 2
)
ho_sub_raw <- create_subcortical_from_volume(
  input_volume = merged,
  atlas_name = "hoSub",
  output_dir = "data-raw",
  slabs = sub_slabs,
  dilate = 2L,
  skip_existing = TRUE,
  cleanup = FALSE
)
focus_re <- paste0(
  "Thalamus|Caudate|Putamen|Pallidum|Hippocampus|Amygdala|",
  "Accumbens|Brain-Stem"
)
.hoSub <- ho_sub_raw |>
  aseg_context(focus = focus_re, match_on = "label") |>
  atlas_view_gather() |>
  atlas_smooth(smoothness = 2, exclude = "^cortex") |>
  atlas_smooth(smoothness = 5, labels = "^cortex") |>
  atlas_smooth(keep = 0.2)

cat("Cortical regions:", nrow(.hoCort$core), "\n")
cat("Subcortical regions:", nrow(.hoSub$core), "\n")

# --- Save ---
# Pull in the ho2 variants built by make_ho2.R so rebuilding ho does not drop
# them from sysdata; freshly built .hoCort / .hoSub take precedence.
if (file.exists("R/sysdata.rda")) {
  prev <- new.env()
  load("R/sysdata.rda", envir = prev)
  for (o in ls(prev, all.names = TRUE)) {
    if (!exists(o, inherits = FALSE)) {
      assign(o, get(o, envir = prev))
    }
  }
}

objs <- ls(all.names = TRUE, pattern = "^\\.ho")
cat("Saving:", objs, "\n")
save(list = objs, file = "R/sysdata.rda", compress = "xz")
