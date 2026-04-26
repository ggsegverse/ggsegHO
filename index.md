# ggsegHO

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

![](reference/figures/README-hoCort-1.png)

### hoSub

Harvard-Oxford subcortical parcellation.

``` r
plot(hoSub())
```

![](reference/figures/README-hoSub-1.png) \## Data source

Harvard-Oxford atlas from FSL, remapped to cortical/subcortical.

- **Date obtained**: 2026-02-21
