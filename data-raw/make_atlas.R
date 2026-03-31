library(ggseg.extra)
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
  atlas_simplify(tolerance = 0.5)

.hoSub <- ho$subcortical |>
  atlas_smooth(smoothness = 5) |>
  atlas_simplify(tolerance = 0.5)

cat("Cortical regions:", nrow(.hoCort$core), "\n")
cat("Subcortical regions:", nrow(.hoSub$core), "\n")

if (!is.null(ho$cerebellar)) {
  .hoCer <- ho$cerebellar
  cat("Cerebellar regions:", nrow(.hoCer$core), "\n")
}

# --- Save ---

objs <- ls(all.names = TRUE, pattern = "^\\.ho")
cat("Saving:", objs, "\n")
save(list = objs, file = "R/sysdata.rda", compress = "xz")
