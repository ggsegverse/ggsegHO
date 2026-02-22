devtools::load_all("../../ggsegExtra/")
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

set.seed(42)
n <- length(cortical_labels) + length(subcortical_labels)
palette_r <- sample(50:220, n, replace = TRUE)
palette_g <- sample(50:220, n, replace = TRUE)
palette_b <- sample(50:220, n, replace = TRUE)

# --- Step 1: Cortical atlas from cortical-only NIfTI ---
# Uses IDs 1-48 (no subcortical contamination on the surface)

cort_lut <- data.frame(
  idx = 1:48,
  label = cortical_labels,
  R = palette_r[seq_along(cortical_labels)],
  G = palette_g[seq_along(cortical_labels)],
  B = palette_b[seq_along(cortical_labels)],
  A = rep(255L, 48),
  stringsAsFactors = FALSE
)

ho_cort <- create_wholebrain_from_volume(
  input_volume = "data-raw/HarvardOxford-cort-maxprob-thr25-1mm.nii.gz",
  input_lut = cort_lut,
  atlas_name = "ho_cort",
  output_dir = "data-raw",
  cortical_labels = cortical_labels,
  skip_existing = TRUE,
  cleanup = FALSE
)

.hoCort <- ho_cort$cortical
.hoCort$core$region <- clean_region_names(.hoCort$core$label)
cat("Cortical class:", paste(class(.hoCort), collapse = ", "), "\n")
cat("Cortical regions:", nrow(.hoCort$core), "\n")

# --- Step 2: Subcortical atlas from subcortical NIfTI ---
# Create volume with cortex reference for brain outline

sub_vol <- readNifti("data-raw/HarvardOxford-sub-maxprob-thr25-1mm.nii.gz")
sub_arr <- as.array(sub_vol)

# Map subcortical IDs: 1=L White Matter, 2=L Cortex, 3=L Ventricle, ...
# Subcortical labels we want (removing white matter IDs 1,12 and cortex IDs 2,13):
# ID 3=L Ventricle, 4=L Thalamus, 5=L Caudate, 6=L Putamen, 7=L Pallidum,
# 8=Brain-Stem, 9=L Hippocampus, 10=L Amygdala, 11=L Accumbens,
# 14=R Ventricle, 15=R Thalamus, 16=R Caudate, 17=R Putamen, 18=R Pallidum,
# 19=R Hippocampus, 20=R Amygdala, 21=R Accumbens

# Remap white matter + cortex labels to FS cortex labels for reference geometry
ref_arr <- sub_arr
ref_arr[sub_arr == 1L] <- 3L
ref_arr[sub_arr == 2L] <- 3L
ref_arr[sub_arr == 12L] <- 42L
ref_arr[sub_arr == 13L] <- 42L

ref_vol_path <- "data-raw/ho_sub_with_ref.nii.gz"
writeNifti(asNifti(ref_arr, reference = sub_vol), ref_vol_path)

subcort_ids <- c(3:11, 14:21)
subcort_lut <- data.frame(
  idx = subcort_ids,
  label = subcortical_labels,
  R = palette_r[length(cortical_labels) + seq_along(subcortical_labels)],
  G = palette_g[length(cortical_labels) + seq_along(subcortical_labels)],
  B = palette_b[length(cortical_labels) + seq_along(subcortical_labels)],
  A = rep(255L, length(subcortical_labels)),
  stringsAsFactors = FALSE
)

subcort_lut_path <- "data-raw/ho_sub_lut.txt"
write_ctab(subcort_lut, subcort_lut_path)

.hoSub <- create_subcortical_from_volume(
  input_volume = ref_vol_path,
  input_lut = subcort_lut_path,
  atlas_name = "ho_sub",
  output_dir = "data-raw",
  cleanup = FALSE
)

cat("Subcortical class:", paste(class(.hoSub), collapse = ", "), "\n")
cat("Subcortical regions:", nrow(.hoSub$core), "\n")

# --- Save ---

objs <- ls(all.names = TRUE, pattern = "^\\.ho")
cat("Saving:", objs, "\n")
save(list = objs, file = "R/sysdata.rda", compress = "xz")
