# Pipeline Definition

``` r

library(DHSHarmonization)
```

### Preamble

The primary distribution mechanism of our data in the lab is via a
`targets` pipeline. `targets` is a powerful R package for orchestrating
data analysis pipelines. It helps manage dependencies, ensures
reproducibility, and optimizes performance by only rerunning the parts
of the pipeline that have changed.

In the lab, we separate the technical concerns of data storage,
processing, analysis, and reporting into distinct workspaces:

1.  Storage: Each project’s raw data is stored in a dedicated data
    repository on Google Drive
    (`Drive / <PROJECT> / 4. Datasets / <DATASET NAME>`). That dataset
    is *mirrored* to FASRC via `rclone` for processing. To work on your
    own project, you must be on FASRC – the pipeline will then *symlink*
    the google drive data to your local “data/” directory using the
    [`link_inputs()`](../reference/link_inputs.md) function defined in
    the pipeline.
2.  Processing and Analysis: The `targets` pipeline handles preliminary
    data processing and analysis. It reads raw data from the “data/”
    directory, processes it, and generates intermediate datasets and
    analysis results in your local workspace. To do this, simply:
    - Install this package in your local project space using
      [`remotes::install_github()`](https://remotes.r-lib.org/reference/install_github.html).
    - Load the package using
      [`library(your_package_name)`](https://rdrr.io/r/base/library.html).
    - Run the `targets` pipeline by executing
      [`build_targets_pipeline()`](../reference/build_targets_pipeline.md)
      and then
      [`tar_make()`](https://docs.ropensci.org/targets/reference/tar_make.html)
      in the R console. This will execute all defined targets,
      processing the data and generating clean datasets.
    - Access the processed data and analysis results stored in the
      `_targets/` directory using
      [`tar_load()`](https://docs.ropensci.org/targets/reference/tar_load.html)
      or other `targets` functions.
3.  Analysis: Once you’ve run the `targets` pipeline, you can access the
    processed data and analysis results stored in the `_targets/`
    directory. This data is then used for further analysis and
    reporting.
4.  Reporting: Your modelling and analysis are conducted on your own in
    the project space, using the processed data outputs from the
    `targets` pipeline. You can create reports, visualizations, and
    other outputs based on the analysis results. I recommend using
    Quarto for this purpose.
5.  Sharing: Finally, when you are ready to share your work, use the
    respective project’s `5. Data & Code Elements` Google Drive folder.
    This folder is intended for sharing intermediate data products — not
    raw or final data. You should always be able to reproduce any data
    product shared here by running the `targets` pipeline from raw data,
    and then rerunning your own analysis code.

## build_targets_pipeline

This is a convenience function that can build the targets pipeline for
the user in their local project. It does this by providing skeleton code
for the targets file, as well as the list of necessary targets in a
separate Quarto file, which is converted to targets objects via
[`tarchetypes::tar_tangle()`](https://docs.ropensci.org/tarchetypes/reference/tar_tangle.html)

``` r

#build_targets_pipeline()
```

## Pipeline Definition

Below we define the actual targets of the pipeline using `tar_tangle()`.

### Config

A YAML config file is used to define parameters for the pipeline. At
present, the only important parameter is the path to the raw data
repository on FASRC.

``` r

cfg <- system.file("config.yml", package = "DHSHarmonization")
```

### Raw Data Linking

We use the function [`link_inputs()`](../reference/link_inputs.md) to
symlink the raw data from the data repository to your local “data/”
directory. If successful, stores the full list of files in the raw data.

``` r

raw_data <- link_inputs(cfg_path = cfg)
```

### Acknowledge File Types

As demonstrated in the `vignette("Linking and Tracking Raw Inputs")`, we
catalog the different types of DHS data files present in the raw data
directory.

``` r

raw_flat_dhs_files <- list_raw_flat_dhs(raw_data)
```

``` r

raw_gps_dhs_files <- list_raw_gps_dhs(raw_data)
```

``` r

raw_gps_covar_files <- list_raw_gps_covars(raw_data)
```

For each type above, we create a mapping to read the data in:

``` r

raw_flat_dhs_files %>%
  str_subset(., "BR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_BR

raw_flat_dhs_files %>%
  str_subset(., "HW") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_HW

raw_flat_dhs_files %>%
  str_subset(., "CR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_CR

raw_flat_dhs_files %>%
  str_subset(., "HR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_HR

raw_flat_dhs_files %>%
  str_subset(., "IR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_IR

raw_flat_dhs_files %>%
  str_subset(., "KR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_KR

raw_flat_dhs_files %>%
  str_subset(., "PR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_PR

raw_flat_dhs_files %>%
  str_subset(., "WI") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_WI

raw_flat_dhs_files %>%
  str_subset(., "SQ") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_SQ

raw_flat_dhs_files %>%
  str_subset(., "MR") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_MR

raw_flat_dhs_files %>%
  str_subset(., "FW") %>%
  map(~ load_flat_dhs_data(.x)) -> dhs_data_FW
```

``` r

gps_data <- st_read(raw_gps_dhs_files)
```

``` r

gps_covar_data <- load_gps_covars(raw_gps_covar_files)
```

### Climate Diarrhea Analysis

Olivia’s analysis function to prepare the DHS data for climate-diarrhea
work.

``` r

climate_diarrhea_data <- climate_diarrhea_analysis(dhs_data_HR)
```

To fetch this endpoint, after you’ve run
[`tar_make()`](https://docs.ropensci.org/targets/reference/tar_make.html),
you can use:

``` r

tar_read(climate_diarrhea_data) #or
tar_load(climate_diarrhea_data)
```
