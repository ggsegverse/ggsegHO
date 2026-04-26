# Harvard-Oxford Subcortical Atlas

Subcortical segmentation from the Harvard-Oxford atlas distributed with
FSL. Contains 2D polygon geometry for
[`ggseg::geom_brain()`](https://ggsegverse.github.io/ggseg/reference/ggbrain.html)
and 3D mesh data for
[`ggseg3d::ggseg3d()`](https://ggsegverse.github.io/ggseg3d/reference/ggseg3d.html).

## Usage

``` r
hoSub()
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
[`ho2_cereb()`](https://ggseg.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_cort()`](https://ggseg.github.io/ggsegHO/reference/ho2_cort.md),
[`ho2_sub()`](https://ggseg.github.io/ggsegHO/reference/ho2_sub.md),
[`hoCort()`](https://ggseg.github.io/ggsegHO/reference/hoCort.md)

Other subcortical_atlases:
[`ho2_sub()`](https://ggseg.github.io/ggsegHO/reference/ho2_sub.md)

## Examples

``` r
hoSub()
#> 
#> ── ho_subcortical ggseg atlas ──────────────────────────────────────────────────
#> Type: subcortical
#> Regions: 6
#> Hemispheres: left, NA, right
#> Views: axial_1, axial_2, axial_3, axial_4, axial_5, coronal_1, coronal_2,
#> coronal_3, coronal_4, sagittal
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#> # A tibble: 11 × 3
#>    hemi  region            label                  
#>    <chr> <chr>             <chr>                  
#>  1 left  lateral ventricle Left_Lateral_Ventricle 
#>  2 left  thalamus          Left_Thalamus          
#>  3 NA    brain stem        Brain-Stem             
#>  4 left  hippocampus       Left_Hippocampus       
#>  5 left  amygdala          Left_Amygdala          
#>  6 left  accumbens         Left_Accumbens         
#>  7 right lateral ventricle Right_Lateral_Ventricle
#>  8 right thalamus          Right_Thalamus         
#>  9 right hippocampus       Right_Hippocampus      
#> 10 right amygdala          Right_Amygdala         
#> 11 right accumbens         Right_Accumbens        
plot(hoSub())
```
