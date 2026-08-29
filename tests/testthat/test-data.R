describe("ho_cort atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(ho_cort(), "ggseg_atlas")
    expect_s3_class(ho_cort(), "cortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(ho_cort()))
  })

  it("has expected core rows", {
    expect_gt(nrow(ho_cort()$core), 90)
  })

  it("renders with ggseg", {
    expect_doppelganger("ho_cort-2d", ggseg::brain_test_plot(ho_cort()))
  })
})

describe("ho_sub atlas", {
  it("is a ggseg_atlas", {
    expect_s3_class(ho_sub(), "ggseg_atlas")
    expect_s3_class(ho_sub(), "subcortical_atlas")
  })

  it("is valid", {
    expect_true(ggseg.formats::is_ggseg_atlas(ho_sub()))
  })

  it("has brain_polygons 2D geometry", {
    expect_true(ggseg.formats::is_atlas_polygon(ho_sub()))
  })

  it("has a named palette", {
    pal <- ggseg.formats::atlas_palette(ho_sub())
    expect_type(pal, "character")
    expect_named(pal)
  })

  it("renders with ggseg", {
    skip_if_not_installed("ggseg")
    p <- ggplot2::ggplot() +
      ggseg::geom_brain(
        atlas = ho_sub(),
        mapping = ggplot2::aes(fill = label),
        show.legend = FALSE
      ) +
      ggplot2::theme_void()
    expect_s3_class(p, "ggplot")
  })
})

describe("deprecated camelCase names", {
  it("hoCort() warns and returns ho_cort()", {
    expect_snapshot(x <- hoCort())
    expect_identical(x, ho_cort())
  })

  it("hoSub() warns and returns ho_sub()", {
    expect_snapshot(x <- hoSub())
    expect_identical(x, ho_sub())
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
    expect_gt(nrow(ho2_cort()$core), 90)
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

  it("keeps the 23 published HOA-2 structures", {
    expect_length(ggseg.formats::atlas_labels(ho2_sub()), 23)
  })

  it("includes the cerebellar grey/white split", {
    expect_setequal(
      grep(
        "Cerebellar",
        ggseg.formats::atlas_labels(ho2_sub()),
        value = TRUE
      ),
      c(
        "Cerebellar_Cortex_Left",
        "Cerebellar_Cortex_Right",
        "Cerebellar_White_Matter_Left",
        "Cerebellar_White_Matter_Right"
      )
    )
  })

  it("draws the structures inside grey anatomical context", {
    # Context geometry is not part of core, so it shows up in the geometry
    # rather than in atlas_labels().
    drawn <- ggseg.formats::atlas_geom(ho2_sub())$label
    expect_true("cortex" %in% drawn)
  })

  it("draws each view once", {
    expect_length(ggseg.formats::atlas_views(ho2_sub()), 7)
  })

  it("renders with ggseg", {
    expect_doppelganger(
      "ho2_sub-2d",
      ggseg::brain_test_plot(ho2_sub(), position = ggseg::position_brain())
    )
  })
})
