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
[`ho2_cereb()`](https://ggseg.github.io/ggsegHO/reference/ho2_cereb.md),
[`ho2_sub()`](https://ggseg.github.io/ggsegHO/reference/ho2_sub.md),
[`hoCort()`](https://ggseg.github.io/ggsegHO/reference/hoCort.md),
[`hoSub()`](https://ggseg.github.io/ggsegHO/reference/hoSub.md)

Other cortical_atlases:
[`hoCort()`](https://ggseg.github.io/ggsegHO/reference/hoCort.md)

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
#> # A tibble: 102 × 3
#>     hemi  region        label           
#>     <chr> <chr>         <chr>           
#>   1 left  fp left       lh_FP_Left      
#>   2 left  f1 left       lh_F1_Left      
#>   3 left  f2 left       lh_F2_Left      
#>   4 left  f3t left      lh_F3t_Left     
#>   5 left  f3o left      lh_F3o_Left     
#>   6 left  foct left     lh_FOCt_Left    
#>   7 left  fo left       lh_FO_Left      
#>   8 left  co left       lh_CO_Left      
#>   9 left  po left       lh_PO_Left      
#>  10 left  pp left       lh_PP_Left      
#>  11 left  h1 left       lh_H1_Left      
#>  12 left  pt left       lh_PT_Left      
#>  13 left  ins left      lh_INS_Left     
#>  14 left  prg left      lh_PRG_Left     
#>  15 left  pog left      lh_POG_Left     
#>  16 left  sga left      lh_SGa_Left     
#>  17 left  sgp left      lh_SGp_Left     
#>  18 left  spl left      lh_SPL_Left     
#>  19 left  ag left       lh_AG_Left      
#>  20 left  ols left      lh_OLs_Left     
#>  21 left  oli left      lh_OLi_Left     
#>  22 left  op left       lh_OP_Left      
#>  23 left  tp left       lh_TP_Left      
#>  24 left  t1a left      lh_T1a_Left     
#>  25 left  t1p left      lh_T1p_Left     
#>  26 left  t2a left      lh_T2a_Left     
#>  27 left  t2p left      lh_T2p_Left     
#>  28 left  to2 left      lh_TO2_Left     
#>  29 left  t3a left      lh_T3a_Left     
#>  30 left  t3p left      lh_T3p_Left     
#>  31 left  to3 left      lh_TO3_Left     
#>  32 left  fmc left      lh_FMC_Left     
#>  33 left  pac left      lh_PAC_Left     
#>  34 left  sc left       lh_SC_Left      
#>  35 left  cga left      lh_CGa_Left     
#>  36 left  cgp left      lh_CGp_Left     
#>  37 left  smc left      lh_SMC_Left     
#>  38 left  pcn left      lh_PCN_Left     
#>  39 left  cn left       lh_CN_Left      
#>  40 left  calc left     lh_CALC_Left    
#>  41 left  sclc left     lh_SCLC_Left    
#>  42 left  pha left      lh_PHa_Left     
#>  43 left  php left      lh_PHp_Left     
#>  44 left  lg left       lh_LG_Left      
#>  45 left  tfa left      lh_TFa_Left     
#>  46 left  tfp left      lh_TFp_Left     
#>  47 left  tof left      lh_TOF_Left     
#>  48 left  of left       lh_OF_Left      
#>  49 left  bfsbcmp left  lh_BFsbcmp_Left 
#>  50 left  unknown       lh_unknown      
#>  51 right cga left      rh_CGa_Left     
#>  52 right cgp left      rh_CGp_Left     
#>  53 right fp right      rh_FP_Right     
#>  54 right f1 right      rh_F1_Right     
#>  55 right f2 right      rh_F2_Right     
#>  56 right f3t right     rh_F3t_Right    
#>  57 right f3o right     rh_F3o_Right    
#>  58 right foct right    rh_FOCt_Right   
#>  59 right fo right      rh_FO_Right     
#>  60 right co right      rh_CO_Right     
#>  61 right po right      rh_PO_Right     
#>  62 right pp right      rh_PP_Right     
#>  63 right h1 right      rh_H1_Right     
#>  64 right pt right      rh_PT_Right     
#>  65 right ins right     rh_INS_Right    
#>  66 right prg right     rh_PRG_Right    
#>  67 right pog right     rh_POG_Right    
#>  68 right sga right     rh_SGa_Right    
#>  69 right sgp right     rh_SGp_Right    
#>  70 right spl right     rh_SPL_Right    
#>  71 right ag right      rh_AG_Right     
#>  72 right ols right     rh_OLs_Right    
#>  73 right oli right     rh_OLi_Right    
#>  74 right op right      rh_OP_Right     
#>  75 right tp right      rh_TP_Right     
#>  76 right t1a right     rh_T1a_Right    
#>  77 right t1p right     rh_T1p_Right    
#>  78 right t2a right     rh_T2a_Right    
#>  79 right t2p right     rh_T2p_Right    
#>  80 right to2 right     rh_TO2_Right    
#>  81 right t3a right     rh_T3a_Right    
#>  82 right t3p right     rh_T3p_Right    
#>  83 right to3 right     rh_TO3_Right    
#>  84 right fmc right     rh_FMC_Right    
#>  85 right pac right     rh_PAC_Right    
#>  86 right sc right      rh_SC_Right     
#>  87 right cga right     rh_CGa_Right    
#>  88 right cgp right     rh_CGp_Right    
#>  89 right smc right     rh_SMC_Right    
#>  90 right pcn right     rh_PCN_Right    
#>  91 right cn right      rh_CN_Right     
#>  92 right calc right    rh_CALC_Right   
#>  93 right sclc right    rh_SCLC_Right   
#>  94 right pha right     rh_PHa_Right    
#>  95 right php right     rh_PHp_Right    
#>  96 right lg right      rh_LG_Right     
#>  97 right tfa right     rh_TFa_Right    
#>  98 right tfp right     rh_TFp_Right    
#>  99 right tof right     rh_TOF_Right    
#> 100 right of right      rh_OF_Right     
#> 101 right bfsbcmp right rh_BFsbcmp_Right
#> 102 right unknown       rh_unknown      
plot(ho2_cort())
```
