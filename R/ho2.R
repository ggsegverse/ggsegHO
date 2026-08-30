#' Harvard-Oxford Atlas 2.0 Cortical
#'
#' Cortical parcellation with 49 regions per hemisphere from the
#' Harvard-Oxford Atlas 2.0 (HOA-2), based on 50 HCP subjects.
#' Contains 2D polygon geometry for [ggseg::geom_brain()] and
#' 3D vertex indices for [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#' @family cortical_atlases
#'
#' @references Rushmore RJ, et al. (2022). Frontiers in
#'   Neuroanatomy 16:1035420.
#'   (\doi{10.3389/fnana.2022.1035420})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @export
#' @examples
#' ho2_cort()
#' plot(ho2_cort())
ho2_cort <- function() .ho2_cort


#' Harvard-Oxford Atlas 2.0 Subcortical
#'
#' Subcortical segmentation with 23 structures from the
#' Harvard-Oxford Atlas 2.0 (HOA-2), based on 100 HCP subjects: the
#' deep grey structures, the brain-stem, and the cerebellum split into
#' grey and white matter. Drawn in four views: two axial, one coronal
#' and a left-hemisphere sagittal. Contains 2D polygon geometry for
#' [ggseg::geom_brain()] and 3D mesh data for [ggseg3d::ggseg3d()].
#'
#' HOA-2 divides the cerebellum into cortex and white matter only, which
#' is a tissue segmentation like the rest of the subcortical volume
#' rather than a cerebellar parcellation, so it belongs to this atlas.
#' For a parcellated cerebellum see the SUIT and Buckner atlases in
#' `ggsegCerebellum`.
#'
#' @family ggseg_atlases
#' @family subcortical_atlases
#'
#' @references Rushmore RJ, et al. (2022). Frontiers in
#'   Neuroanatomy 16:1035420.
#'   (\doi{10.3389/fnana.2022.1035420})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (subcortical).
#' @export
#' @examples
#' ho2_sub()
#' plot(ho2_sub())
ho2_sub <- function() .ho2_sub
