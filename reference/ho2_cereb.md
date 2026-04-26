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
[`ho2_cort()`](https://ggseg.github.io/ggsegHO/reference/ho2_cort.md),
[`ho2_sub()`](https://ggseg.github.io/ggsegHO/reference/ho2_sub.md),
[`hoCort()`](https://ggseg.github.io/ggsegHO/reference/hoCort.md),
[`hoSub()`](https://ggseg.github.io/ggsegHO/reference/hoSub.md)

## Examples

``` r
ho2_cereb()
#> 
#> ── ho2_cereb ggseg atlas ───────────────────────────────────────────────────────
#> Type: cerebellar
#> Regions: 4
#> Hemispheres: left, right
#> Views: flatmap
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (vertices)
#> ────────────────────────────────────────────────────────────────────────────────
#> # A tibble: 4 × 3
#>   hemi  region                        label                              
#>   <chr> <chr>                         <chr>                              
#> 1 left  Cerebellar_Cortex_Left        left_Cerebellar_Cortex_Left        
#> 2 right Cerebellar_Cortex_Right       right_Cerebellar_Cortex_Right      
#> 3 left  Cerebellar_White_Matter_Left  left_Cerebellar_White_Matter_Left  
#> 4 right Cerebellar_White_Matter_Right right_Cerebellar_White_Matter_Right
plot(ho2_cereb())
```
