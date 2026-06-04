devtools::load_all()


library(stringr)
library(testthat)
library(dplyr)


library(yaml)
library(purrr)
library(here)


library(targets)


manifest <- here("stagecoach_manifest.yml")


repo_files <- list.files(
    here(
      "data", 
      "inputs"
    ),
    recursive = TRUE
)
