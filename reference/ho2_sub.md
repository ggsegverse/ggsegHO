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
[`ho2_cereb()`](https://ggseg.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_cort()`](https://ggseg.github.io/ggsegHO/reference/ho2_cort.md),
[`hoCort()`](https://ggseg.github.io/ggsegHO/reference/hoCort.md),
[`hoSub()`](https://ggseg.github.io/ggsegHO/reference/hoSub.md)

Other subcortical_atlases:
[`hoSub()`](https://ggseg.github.io/ggsegHO/reference/hoSub.md)

## Examples

``` r
ho2_sub()
#> 
#> ── ho2_sub ggseg atlas ─────────────────────────────────────────────────────────
#> Type: subcortical
#> Regions: 19
#> Hemispheres: left, right, NA
#> Views: axial_2, axial_3, axial_4, axial_5, coronal_3, coronal_4, coronal_5,
#> sagittal, axial_1, axial_6, coronal_1, coronal_2
#> Palette: ✔
#> Rendering: ✔ ggseg
#> ✔ ggseg3d (meshes)
#> ────────────────────────────────────────────────────────────────────────────────
#> # A tibble: 19 × 3
#>    hemi  region                      label                      
#>    <chr> <chr>                       <chr>                      
#>  1 left  nucleus accumbens left      Nucleus_Accumbens_Left     
#>  2 right nucleus accumbens right     Nucleus_Accumbens_Right    
#>  3 left  caudate left                Caudate_Left               
#>  4 right caudate right               Caudate_Right              
#>  5 left  putamen left                Putamen_Left               
#>  6 right putamen right               Putamen_Right              
#>  7 left  globus pallidus left        Globus_Pallidus_Left       
#>  8 right globus pallidus right       Globus_Pallidus_Right      
#>  9 NA    brainstem                   Brainstem                  
#> 10 left  thalamus left               Thalamus_Left              
#> 11 right thalamus right              Thalamus_Right             
#> 12 left  hippocampal formation left  Hippocampal_Formation_Left 
#> 13 right hippocampal formation right Hippocampal_Formation_Right
#> 14 left  amygdala left               Amygdala_Left              
#> 15 right amygdala right              Amygdala_Right             
#> 16 left  vdc anterior left           VDC_Anterior_Left          
#> 17 right vdc anterior right          VDC_Anterior_Right         
#> 18 left  vdc posterior left          VDC_Posterior_Left         
#> 19 right vdc posterior right         VDC_Posterior_Right        
plot(ho2_sub())
```
