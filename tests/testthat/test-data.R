describe("hoCort atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(hoCort(), "ggseg_atlas")
    expect_s3_class(hoCort(), "cortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(hoCort()))
  })

  it("has 96 core rows", {
    expect_equal(nrow(hoCort()$core), 96L)
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    skip_if_not_installed("ggplot2")
    skip_if_not_installed("vdiffr")
    p <- ggplot2::ggplot() +
      ggseg::geom_brain(
        atlas = hoCort(),
        mapping = ggplot2::aes(fill = label),
        position = ggseg::position_brain(hemi ~ view),
        show.legend = FALSE
      ) +
      ggplot2::scale_fill_manual(
        values = hoCort()$palette,
        na.value = "grey"
      ) +
      ggplot2::theme_void()
    vdiffr::expect_doppelganger("hoCort-2d", p)
  })

  it("renders with ggseg3d", {
    skip_if_not_installed("ggseg3d")
    p <- ggseg3d::ggseg3d(atlas = hoCort())
    expect_s3_class(p, c("plotly", "htmlwidget"))
  })
})

describe("hoSub atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(hoSub(), "ggseg_atlas")
    expect_s3_class(hoSub(), "subcortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(hoSub()))
  })

  it("has 19 core rows", {
    expect_equal(nrow(hoSub()$core), 19L)
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    skip_if_not_installed("ggplot2")
    skip_if_not_installed("vdiffr")
    p <- ggplot2::ggplot() +
      ggseg::geom_brain(
        atlas = hoSub(),
        mapping = ggplot2::aes(fill = label),
        show.legend = FALSE
      ) +
      ggplot2::scale_fill_manual(
        values = hoSub()$palette,
        na.value = "grey"
      ) +
      ggplot2::theme_void()
    vdiffr::expect_doppelganger("hoSub-2d", p)
  })

  it("renders with ggseg3d", {
    skip_if_not_installed("ggseg3d")
    p <- ggseg3d::ggseg3d(atlas = hoSub())
    expect_s3_class(p, c("plotly", "htmlwidget"))
  })
})
