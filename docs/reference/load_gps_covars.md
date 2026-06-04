# Title

Description

## Usage

``` r
load_gps_covars(
  fpath,
  factor_vars = c("DHSCLUST", "DHSID", "DHSCC", "GPS_Dataset")
)
```

## Examples

``` r
ex_data <- here("data", "DHS Data", "DHS 1997", "GPS Data", "MDGC32FL") %>%
  list.files(full.names = TRUE) %>%
  grep(pattern = "csv$", value = TRUE)
#> Error in here("data", "DHS Data", "DHS 1997", "GPS Data", "MDGC32FL"): could not find function "here"
load_gps_covars(ex_data) %>%
  skimr::skim()
#> Error: object 'ex_data' not found
```
