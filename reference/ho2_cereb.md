# Harvard-Oxford Atlas 2.0 Cerebellar

Cerebellar segmentation from the Harvard-Oxford Atlas 2.0 (HOA-2),
including cerebellar cortex and white matter. Contains 2D polygon
geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html).

## Usage

``` r
ho2_cereb()
```

## Value

A
[ggseg.formats::ggseg_atlas](https://ggsegverse.github.io/ggseg.formats/reference/ggseg_atlas.html)
object (cerebellar).

## References

Rushmore RJ, et al. (2022). Frontiers in Neuroanatomy 16:1035420.
([doi:10.3389/fnana.2022.1035420](https://doi.org/10.3389/fnana.2022.1035420)
)

## See also

Other ggseg_atlases:
[`ho2_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_cort.md),
[`ho2_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho2_sub.md),
[`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md),
[`ho_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho_sub.md)

## Examples

``` r
ho2_cereb()
#> 
#> ── ho2_cereb ggseg atlas ───────────────────────────────────────────────────────
#> Type: cerebellar
#> Regions: 2
#> Hemispheres: left, right
#> Views: sagittal_1, axial_1, axial_2, coronal_1, coronal_2
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#>    hemi                  region                         label
#> 1  left       cerebellar cortex        Cerebellar_Cortex_Left
#> 2 right       cerebellar cortex       Cerebellar_Cortex_Right
#> 3  left cerebellar white matter  Cerebellar_White_Matter_Left
#> 4 right cerebellar white matter Cerebellar_White_Matter_Right
plot(ho2_cereb())
```
