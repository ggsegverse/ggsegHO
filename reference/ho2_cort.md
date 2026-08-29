# Harvard-Oxford Atlas 2.0 Cortical

Cortical parcellation with 49 regions per hemisphere from the
Harvard-Oxford Atlas 2.0 (HOA-2), based on 50 HCP subjects. Contains 2D
polygon geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D vertex indices for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
ho2_cort()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (cortical).

## References

Rushmore RJ, et al. (2022). Frontiers in Neuroanatomy 16:1035420.
([doi:10.3389/fnana.2022.1035420](https://doi.org/10.3389/fnana.2022.1035420)
)

## See also

Other ggseg_atlases:
[`ho2_cereb()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_sub.md),
[`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md),
[`ho_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho_sub.md)

Other cortical_atlases:
[`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md)

## Examples

``` r
ho2_cort()
#> 
#> ── ho2_cort_cortical ggseg atlas ───────────────────────────────────────────────
#> Type: cortical
#> Regions: 99
#> Hemispheres: left, right
#> Views: inferior, lateral, medial, superior
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (vertices)
#> ────────────────────────────────────────────────────────────────────────────────
#>    hemi    region        label
#> 1  left   fp left   lh_FP_Left
#> 2  left   f1 left   lh_F1_Left
#> 3  left   f2 left   lh_F2_Left
#> 4  left  f3t left  lh_F3t_Left
#> 5  left  f3o left  lh_F3o_Left
#> 6  left foct left lh_FOCt_Left
#> 7  left   fo left   lh_FO_Left
#> 8  left   co left   lh_CO_Left
#> 9  left   po left   lh_PO_Left
#> 10 left   pp left   lh_PP_Left
#> ... with 92 more rows
plot(ho2_cort())
```
