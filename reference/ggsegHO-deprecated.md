# Atlases renamed to snake_case

**\[deprecated\]**

The two FSL Harvard-Oxford atlases were the only ones in this package
named in camelCase. They now match the HOA-2 atlases and the rest of the
ggsegverse:

- `hoCort()` is now
  [`ho_cort()`](https://ggsegverse.github.io/ggsegHO/reference/ho_cort.md)

- `hoSub()` is now
  [`ho_sub()`](https://ggsegverse.github.io/ggsegHO/reference/ho_sub.md)

The old names still return the same atlas, with a warning.

## Usage

``` r
hoCort()

hoSub()
```

## Value

The renamed atlas, invisibly identical to what the new name returns.
