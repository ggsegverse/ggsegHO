

<!-- README.md is generated from README.qmd. Please edit that file -->

# ggsegHO <img src='man/figures/logo.png' align="right" height="138.5" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/ggsegverse/ggsegHO/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ggsegverse/ggsegHO/actions/workflows/R-CMD-check.yaml)
[![r-universe](https://ggseg.r-universe.dev/badges/ggsegHO.png)](https://ggseg.r-universe.dev/ggsegHO)
<!-- badges: end -->

Harvard-Oxford cortical, subcortical, and cerebellar atlases for the
ggseg ecosystem. Includes the original Harvard-Oxford atlas (FSL) and
the Harvard-Oxford Atlas 2.0 (HOA-2).

## Installation

We recommend installing the ggseg-atlases through the ggseg
[r-universe](https://ggseg.r-universe.dev/ui#builds):

``` r
options(repos = c(
  ggseg = "https://ggseg.r-universe.dev",
  CRAN = "https://cloud.r-project.org"
))

install.packages("ggsegHO")
```

You can install this package from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ggsegverse/ggsegHO")
```

## Harvard-Oxford cortical

``` r
library(ggseg)
library(ggsegHO)

plot(hoCort())
```

<img src="man/figures/README-ho-cort-1.png" style="width:100.0%" />

## Harvard-Oxford subcortical

``` r
plot(hoSub())
```

<img src="man/figures/README-ho-sub-1.png" style="width:100.0%" />

## HOA-2 cortical

``` r
plot(ho2_cort())
```

<img src="man/figures/README-ho2-cort-1.png" style="width:100.0%" />

## HOA-2 subcortical

``` r
plot(ho2_sub())
```

<img src="man/figures/README-ho2-sub-1.png" style="width:100.0%" />

## HOA-2 cerebellar

``` r
plot(ho2_cereb())
```

<img src="man/figures/README-ho2-cereb-1.png" style="width:100.0%" />

## Data source

Makris N, et al. (2006). Decreased volume of left and total anterior
insular lobule in schizophrenia. *Schizophrenia Research*,
83(2-3):155-171.
[doi:10.1016/j.schres.2005.11.020](https://doi.org/10.1016/j.schres.2005.11.020)

Rushmore RJ, et al. (2022). HOA2.0-ComPaRe: A next generation
Harvard-Oxford Atlas. *Frontiers in Neuroanatomy*, 16:1035420.
