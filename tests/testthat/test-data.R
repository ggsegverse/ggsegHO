describe("hoCort atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(hoCort(), "ggseg_atlas")
    expect_s3_class(hoCort(), "cortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(hoCort()))
  })

  it("has expected core rows", {
    expect_true(nrow(hoCort()$core) > 90)
  })

  it("renders with ggseg", {
    expect_doppelganger("hoCort-2d", ggseg::brain_test_plot(hoCort()))
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

  it("has brain_polygons 2D geometry", {
    expect_true(ggseg.formats::is_atlas_polygon(hoSub()))
  })

  it("has a named palette", {
    pal <- ggseg.formats::atlas_palette(hoSub())
    expect_type(pal, "character")
    expect_named(pal)
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    p <- ggplot2::ggplot() +
      ggseg::geom_brain(
        atlas = hoSub(),
        mapping = ggplot2::aes(fill = label),
        show.legend = FALSE
      ) +
      ggplot2::theme_void()
    expect_s3_class(p, "ggplot")
  })
})

describe("ho2_cort atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(ho2_cort(), "ggseg_atlas")
    expect_s3_class(ho2_cort(), "cortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(ho2_cort()))
  })

  it("has expected core rows", {
    expect_true(nrow(ho2_cort()$core) > 90)
  })

  it("renders with ggseg", {
    expect_doppelganger("ho2_cort-2d", ggseg::brain_test_plot(ho2_cort()))
  })
})

describe("ho2_sub atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(ho2_sub(), "ggseg_atlas")
    expect_s3_class(ho2_sub(), "subcortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(ho2_sub()))
  })

  it("renders with ggseg", {
    expect_doppelganger(
      "ho2_sub-2d",
      ggseg::brain_test_plot(ho2_sub(), position = ggseg::position_brain())
    )
  })
})

describe("ho2_cereb atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(ho2_cereb(), "ggseg_atlas")
    expect_s3_class(ho2_cereb(), "cerebellar_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(ho2_cereb()))
  })

  it("renders with ggseg", {
    expect_doppelganger(
      "ho2_cereb-2d",
      ggseg::brain_test_plot(ho2_cereb(), position = ggseg::position_brain())
    )
  })
})
