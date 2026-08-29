# Harvard-Oxford Subcortical Atlas

Subcortical segmentation from the Harvard-Oxford atlas distributed with
FSL, drawn on a grey-brain anatomical context. Contains 2D polygon
geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D mesh data for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
ho_sub()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (subcortical).

## References

Makris, et al. (2006) Schizophrenia research 83(2-3):155-151
([doi:10.1016/j.schres.2005.11.020](https://doi.org/10.1016/j.schres.2005.11.020)
)

## See also

Other ggseg_atlases:
[`ho2_cereb()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cort.md),
[`ho2_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_sub.md),
[`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md)

Other subcortical_atlases:
[`ho2_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_sub.md)

## Examples

``` r
ho_sub()
#> 
#> ── hoSub ggseg atlas ───────────────────────────────────────────────────────────
#> Type: subcortical
#> Regions: 8
#> Hemispheres: left, NA, right
#> Views: axial_1, axial_2, axial_3, coronal_1, coronal_2, coronal_3
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#>     hemi      region            label
#> 1   left    thalamus    Left-Thalamus
#> 2   left     caudate     Left-Caudate
#> 3   left     putamen     Left-Putamen
#> 4   left    pallidum    Left-Pallidum
#> 5   <NA>  brain stem       Brain-Stem
#> 6   left hippocampus Left-Hippocampus
#> 7   left    amygdala    Left-Amygdala
#> 8   left   accumbens   Left-Accumbens
#> 9  right    thalamus   Right-Thalamus
#> 10 right     caudate    Right-Caudate
#> ... with 5 more rows
plot(ho_sub())
```
