#' Harvard-Oxford Cortical Atlas
#'
#' Brain atlas for the Harvard-Oxford cortical parcellation with
#' 48 regions per hemisphere. Contains 2D polygon geometry for
#' [ggseg::geom_brain()].
#'
#' @family ggseg_atlases
#'
#' @references Makris, et al. (2006) Schizophrenia research 83(2-3):155-151
#' (\doi{10.1016/j.schres.2005.11.020})
#'
#' @return A [ggseg.formats::ggseg_atlas] object (cortical).
#' @export
#' @examples
#' hoCort()
hoCort <- function() .hoCort
