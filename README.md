
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggsegHO

<!-- badges: start -->

[![R-CMD-check](https://github.com/ggsegverse/ggsegHO/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ggsegverse/ggsegHO/actions/workflows/R-CMD-check.yaml)
[![r-universe](https://ggsegverse.r-universe.dev/badges/ggsegHO)](https://ggsegverse.r-universe.dev/ggsegHO)
<!-- badges: end -->

Harvard-Oxford Atlas for the ggsegverse Ecosystem.

## Installation

``` r
# From r-universe
install.packages("ggsegHO", repos = "https://ggsegverse.r-universe.dev")

# From GitHub
# install.packages("remotes")
remotes::install_github("ggsegverse/ggsegHO")
```

## Atlases

### hoCort

Harvard-Oxford cortical parcellation.

``` r
library(ggsegHO)
plot(hoCort())
```

<img src="man/figures/README-hoCort-1.png" alt="" width="100%" />

### hoSub

Harvard-Oxford subcortical parcellation.

``` r
plot(hoSub())
```

<img src="man/figures/README-hoSub-1.png" alt="" width="100%" /> \##
Data source

Harvard-Oxford atlas from FSL, remapped to cortical/subcortical.

- **Date obtained**: 2026-02-21
