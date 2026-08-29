#' Deprecated atlases
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
#' `ho2_cereb()` is now part of [ho2_sub()]. HOA-2 divides the cerebellum
#' into grey and white matter only, which is a tissue segmentation like the
#' rest of the subcortical volume rather than a cerebellar parcellation, so
#' the four structures are drawn alongside the deep grey ones instead of in
#' an atlas of their own.
#'
#' The old names return the atlas that replaced them, with a warning.
#'
#' @return The atlas that replaced the deprecated one.
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

#' @rdname ggsegHO-deprecated
#' @export
ho2_cereb <- function() {
  lifecycle::deprecate_warn(
    "2.1.0",
    "ho2_cereb()",
    "ho2_sub()",
    details = "The cerebellar grey and white matter are structures of
      `ho2_sub()`."
  )
  ho2_sub()
}
