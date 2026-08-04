# Changelog

## ggsegHO 2.0.1

- Atlas 2D geometry migrated to the sf-optional `brain_polygons` format
  (`ggseg.formats` 0.0.3). The atlases now render without `sf` and its
  GDAL/GEOS/PROJ system libraries, enabling wasm and air-gapped
  installs. Plots are unchanged.

## ggsegHO 2.0.0

### Breaking changes

- `hoCort` is now a `ggseg_atlas` object (from ggseg.formats) containing
  2D data. This is a 2D-only atlas (no 3D mesh data available).

- Use `ggplot() + ggseg::geom_brain(atlas = hoCort)` for 2D plots.

- `ggseg.formats` is now a hard dependency (in Depends).

- Package URLs updated from `LCBC-UiO` to `ggseg` GitHub organisation.

## ggsegHO 1.0.02

- updated atlases to work with ggseg \>= 1.6.0

## ggsegHO 1.0.01

- Added a `NEWS.md` file to track changes to the package.
