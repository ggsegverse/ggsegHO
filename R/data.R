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
