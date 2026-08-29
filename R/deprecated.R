#' Atlases renamed to snake_case
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' The two FSL Harvard-Oxford atlases were the only ones in this package
#' named in camelCase. They now match the HOA-2 atlases and the rest of the
#' ggsegverse:
#'
#' * `hoCort()` is now [ho_cort()]
#' * `hoSub()` is now [ho_sub()]
#'
#' The old names still return the same atlas, with a warning.
#'
#' @return The renamed atlas, invisibly identical to what the new name
#'   returns.
#' @name ggsegHO-deprecated
#' @keywords internal
NULL

#' @rdname ggsegHO-deprecated
#' @export
hoCort <- function() {
  lifecycle::deprecate_warn("2.1.0", "hoCort()", "ho_cort()")
  ho_cort()
}

#' @rdname ggsegHO-deprecated
#' @export
hoSub <- function() {
  lifecycle::deprecate_warn("2.1.0", "hoSub()", "ho_sub()")
  ho_sub()
}
