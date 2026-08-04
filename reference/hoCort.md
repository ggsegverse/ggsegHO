# Harvard-Oxford Cortical Atlas

Cortical parcellation with 48 regions per hemisphere from the
Harvard-Oxford atlas distributed with FSL. Contains 2D polygon geometry
for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D vertex indices for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
hoCort()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (cortical).

## References

Makris, et al. (2006) Schizophrenia research 83(2-3):155-151
([doi:10.1016/j.schres.2005.11.020](https://doi.org/10.1016/j.schres.2005.11.020)
)

## See also

Other ggseg_atlases:
[`ho2_cereb()`](https://ggseg.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_cort()`](https://ggseg.github.io/ggsegHO/reference/ho2_cort.md),
[`ho2_sub()`](https://ggseg.github.io/ggsegHO/reference/ho2_sub.md),
[`hoSub()`](https://ggseg.github.io/ggsegHO/reference/hoSub.md)

Other cortical_atlases:
[`ho2_cort()`](https://ggseg.github.io/ggsegHO/reference/ho2_cort.md)

## Examples

``` r
hoCort()
#> 
#> ── ho_cortical ggseg atlas ─────────────────────────────────────────────────────
#> Type: cortical
#> Regions: 49
#> Hemispheres: left, right
#> Views: inferior, lateral, medial, superior
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (vertices)
#> ────────────────────────────────────────────────────────────────────────────────
#>    hemi                                   region
#> 1  left                             Frontal_Pole
#> 2  left                           Insular_Cortex
#> 3  left                   Superior_Frontal_Gyrus
#> 4  left                     Middle_Frontal_Gyrus
#> 5  left Inferior_Frontal_Gyrus_pars_triangularis
#> 6  left  Inferior_Frontal_Gyrus_pars_opercularis
#> 7  left                         Precentral_Gyrus
#> 8  left                            Temporal_Pole
#> 9  left         Superior_Temporal_Gyrus_anterior
#> 10 left        Superior_Temporal_Gyrus_posterior
#>                                          label
#> 1                              lh_Frontal_Pole
#> 2                            lh_Insular_Cortex
#> 3                    lh_Superior_Frontal_Gyrus
#> 4                      lh_Middle_Frontal_Gyrus
#> 5  lh_Inferior_Frontal_Gyrus_pars_triangularis
#> 6   lh_Inferior_Frontal_Gyrus_pars_opercularis
#> 7                          lh_Precentral_Gyrus
#> 8                             lh_Temporal_Pole
#> 9          lh_Superior_Temporal_Gyrus_anterior
#> 10        lh_Superior_Temporal_Gyrus_posterior
#> ... with 88 more rows
plot(hoCort())
```
