#' Harvard-Oxford Cortical Atlas
#'
#' Cortical parcellation with 48 regions per hemisphere from the
#' Harvard-Oxford atlas distributed with FSL. Contains 2D polygon
#' geometry for [ggseg::geom_brain()] and 3D vertex indices for
#' [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#'
#' @references Makris, et al. (2006) Schizophrenia research 83(2-3):155-151
#' (\doi{10.1016/j.schres.2005.11.020})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @import ggseg.formats
#' @export
#' @examples
#' hoCort()
hoCort <- function() .hoCort


#' Harvard-Oxford Subcortical Atlas
#'
#' Subcortical segmentation with 19 structures from the Harvard-Oxford
#' atlas distributed with FSL. Contains 2D polygon geometry for
#' [ggseg::geom_brain()] and 3D mesh data for [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#'
#' @references Makris, et al. (2006) Schizophrenia research 83(2-3):155-151
#' (\doi{10.1016/j.schres.2005.11.020})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (subcortical).
#' @export
#' @examples
#' hoSub()
hoSub <- function() .hoSub


#' Harvard-Oxford Atlas 2.0 Cortical
#'
#' Cortical parcellation with 49 regions per hemisphere from the
#' Harvard-Oxford Atlas 2.0 (HOA-2), based on 50 HCP subjects.
#' Contains 2D polygon geometry for [ggseg::geom_brain()] and
#' 3D vertex indices for [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#'
#' @references Rushmore, et al. (2022) Frontiers in Neuroanatomy 16:1035420
#' (\doi{10.3389/fnana.2022.1035420})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @export
#' @examples
#' ho2Cort()
ho2Cort <- function() .ho2Cort


#' Harvard-Oxford Atlas 2.0 Subcortical
#'
#' Subcortical segmentation with 32 structures from the
#' Harvard-Oxford Atlas 2.0 (HOA-2), based on 100 HCP subjects.
#' Contains 2D polygon geometry for [ggseg::geom_brain()] and
#' 3D mesh data for [ggseg3d::ggseg3d()].
#'
#' @family ggseg_atlases
#'
#' @references Rushmore, et al. (2022) Frontiers in Neuroanatomy 16:1035420
#' (\doi{10.3389/fnana.2022.1035420})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (subcortical).
#' @export
#' @examples
#' ho2Sub()
ho2Sub <- function() .ho2Sub
