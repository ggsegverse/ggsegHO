# Harvard-Oxford Atlas 2.0 Subcortical

Subcortical segmentation with 19 structures from the Harvard-Oxford
Atlas 2.0 (HOA-2), based on 100 HCP subjects. Contains 2D polygon
geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D mesh data for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
ho2_sub()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (subcortical).

## References

Rushmore RJ, et al. (2022). Frontiers in Neuroanatomy 16:1035420.
([doi:10.3389/fnana.2022.1035420](https://doi.org/10.3389/fnana.2022.1035420)
)

## See also

Other ggseg_atlases:
[`ho2_cereb()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cort.md),
[`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md),
[`ho_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho_sub.md)

Other subcortical_atlases:
[`ho_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho_sub.md)

## Examples

``` r
ho2_sub()
#> 
#> ── ho2_sub ggseg atlas ─────────────────────────────────────────────────────────
#> Type: subcortical
#> Regions: 10
#> Hemispheres: left, right, NA
#> Views: axial_1, axial_2, axial_3, coronal_1, coronal_2, coronal_3
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#>     hemi            region                   label
#> 1   left nucleus accumbens  Nucleus_Accumbens_Left
#> 2  right nucleus accumbens Nucleus_Accumbens_Right
#> 3   left           caudate            Caudate_Left
#> 4  right           caudate           Caudate_Right
#> 5   left           putamen            Putamen_Left
#> 6  right           putamen           Putamen_Right
#> 7   left   globus pallidus    Globus_Pallidus_Left
#> 8  right   globus pallidus   Globus_Pallidus_Right
#> 9   <NA>         brainstem               Brainstem
#> 10  left          thalamus           Thalamus_Left
#> ... with 9 more rows
plot(ho2_sub())
```
