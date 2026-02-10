library(ggseg.formats)
load(here::here("data/hoCort.rda"))

class(hoCort$data) <- setdiff(
  class(hoCort$data),
  c("brain_data", "ggseg_atlas")
)

hoCort <- convert_legacy_brain_atlas(atlas_2d = hoCort)
stopifnot(is_ggseg_atlas(hoCort))

save(hoCort, file = here::here("data/hoCort.rda"), compress = "xz")

brain_pals <- stats::setNames(
  list(hoCort$palette),
  hoCort$atlas
)
save(brain_pals, file = here::here("R/sysdata.rda"), compress = "xz")
