# ggsegHO 2.1.0

## Atlas naming

- The FSL Harvard-Oxford atlases are renamed to snake_case, matching the HOA-2
  atlases and the rest of the ggsegverse: `hoCort()` is now `ho_cort()` and
  `hoSub()` is now `ho_sub()`. The old names still work and return the same
  atlas, with a deprecation warning.

## Harvard-Oxford Atlas 2.0

- `ho2_sub()` is rebuilt on a **grey-brain anatomical context**, the same route
  `ho_sub()` takes: the parcels are embedded in the fsaverage5 `aseg` through
  `ggseg.extra::prepare_subcortical_mni152()`, the slice positions come from
  `subcortical_slabs()` rather than being hard-coded, and the surrounding
  cortex, white matter, cerebellum and brain-stem are drawn as grey context.
  Previously the structures floated on an empty canvas across 12 cramped views.

- `ho2_cereb()` is rebuilt the same way, replacing the aseg cerebellum. It
  previously drew as a single undifferentiated mass, and its four structures
  carried doubled-up labels (`left_Cerebellar_Cortex_Left`); they are now named
  once, from the published HOA-2 lookup table.

- Both keep the colours the HOA-2 authors distribute, in which a structure and
  its contralateral twin share a colour.

- The build scripts for all five atlases are now in `data-raw/`. The HOA-2
  scripts had never been committed, so those atlases could not be reproduced
  from the repository.

# ggsegHO 2.0.2

- `hoSub` now renders on a **grey-brain anatomical context**. The Harvard-Oxford
  subcortical structures are registered into the fsaverage5 `aseg` and the
  surrounding cortex/white-matter/cerebellum/brainstem drawn as grey context, so
  the coloured structures sit inside a recognisable brain silhouette — matching
  the FreeSurfer subcortical atlases. Regenerating requires FreeSurfer 7.4.1.
  Also swaps the brittle `hoSub-2d` vdiffr snapshot for structural assertions.

# ggsegHO 2.0.1

- Atlas 2D geometry migrated to the sf-optional `brain_polygons` format
  (`ggseg.formats` 0.0.3). The atlases now render without `sf` and its
  GDAL/GEOS/PROJ system libraries, enabling wasm and air-gapped installs.
  Plots are unchanged.

# ggsegHO 2.0.0

## Breaking changes

- `hoCort` is now a `ggseg_atlas` object (from ggseg.formats) containing
  2D data. This is a 2D-only atlas (no 3D mesh data available).

- Use `ggplot() + ggseg::geom_brain(atlas = hoCort)` for 2D plots.

- `ggseg.formats` is now a hard dependency (in Depends).

- Package URLs updated from `LCBC-UiO` to `ggseg` GitHub organisation.

# ggsegHO 1.0.02

- updated atlases to work with ggseg >= 1.6.0

# ggsegHO 1.0.01

- Added a `NEWS.md` file to track changes to the package.
