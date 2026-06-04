# load_flat_dhs_data Title

load_flat_dhs_data Title

## Usage

``` r
load_flat_dhs_data(folder_path)
```

## Value

1

## Examples

``` r
ex_data <- here("data", "DHS Data", "DHS 1992", "MDIR21FL")
#> Error in here("data", "DHS Data", "DHS 1992", "MDIR21FL"): could not find function "here"
load_flat_dhs_data(ex_data) %>%
  tibble() %>%
  head()
#> Error in tibble(.): could not find function "tibble"
```
