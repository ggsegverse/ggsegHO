devtools::load_all("../../ggsegExtra/")

subcortical_labels <- c(
  "Left Cerebral White Matter",
  "Left Lateral Ventricle",
  "Left Thalamus",
  "Left Caudate",
  "Left Putamen",
  "Left Pallidum",
  "Brain-Stem",
  "Left Hippocampus",
  "Left Amygdala",
  "Left Accumbens",
  "Right Cerebral White Matter",
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

ho_lut <- data.frame(
  idx = c(
    1, 3:11,
    12, 14:21,
    101:148
  ),
  label = c(subcortical_labels, cortical_labels),
  R = {set.seed(42); sample(50:220, 67, replace = TRUE)},
  G = {set.seed(43); sample(50:220, 67, replace = TRUE)},
  B = {set.seed(44); sample(50:220, 67, replace = TRUE)},
  A = rep(255L, 67),
  stringsAsFactors = FALSE
)

ho <- create_wholebrain_from_volume(
  input_volume = "data-raw/HarvardOxford-cort_and_sub-maxprob-thr25-1mm.nii.gz",
  input_lut = ho_lut,
  atlas_name = "ho",
  output_dir = "data-raw",
  cortical_labels = cortical_labels,
  subcortical_labels = subcortical_labels,
  cleanup = FALSE
)

if (!is.null(ho$cortical)) {
  .hoCort <- ho$cortical
  cat("Cortical class:", paste(class(.hoCort), collapse = ", "), "\n")
  cat("Cortical regions:", nrow(.hoCort$core), "\n")
}
if (!is.null(ho$subcortical)) {
  .hoSub <- ho$subcortical
  cat("Subcortical class:", paste(class(.hoSub), collapse = ", "), "\n")
  cat("Subcortical regions:", nrow(.hoSub$core), "\n")
}

objs <- ls(all.names = TRUE, pattern = "^\\.ho")
cat("Saving:", objs, "\n")
save(list = objs, file = "R/sysdata.rda", compress = "xz")
