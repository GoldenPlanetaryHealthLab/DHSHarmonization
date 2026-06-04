# build_targets_pipeline Title

Dynamically build the targets pipeline for the project.

## Usage

``` r
build_targets_pipeline(
  targets_notebook_name = "_target_notebook.Rmd",
  targets_file_name = "_targets.R",
  pkg_name = "DHSHarmonization",
  vignette_name = "pipeline-definition.Rmd",
  overwrite = FALSE
)
```

## Value

1

## Details

This function sets up the targets pipeline by defining a local
`_targets.R` file and using `tar_tangle()` to create the necessary
targets from an Rmd file. The Rmd file is, itself, this vignette —
Pipeline Definition.

## Examples

``` r
#build_targets_pipeline()
```
