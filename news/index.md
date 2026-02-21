# Changelog

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
