library(targets)
library(here)
library(tidyverse)
library(purrr)
library(rdhs)
library(glue)
library(sf)


#' Load a flat DHS dataset from a folder
#'
#' This function zips the contents of the provided folder and uses rdhs:::
#' read_dhs_flat to read a DHS flat file archive into R. It is intended for
#' DHS flat file folders (e.g. MDIR21FL) that contain the standard DHS flat
#' data files.
#'
#' @param folder_path Character. Path to a folder containing DHS flat files to
#'   be zipped and read.
#' @return A data.frame/tibble containing the DHS flat data as returned by
#'   rdhs:::read_dhs_flat.
#' @export
#' @examples
#' ex_data <- here::here("data", "DHS Data", "DHS 1992", "MDIR21FL")
#' df <- load_flat_dhs_data(ex_data)
#' head(df)
load_flat_dhs_data <- function(folder_path) {

  temp_zip <- tempfile(fileext = ".zip")
  zip::zipr(zipfile = temp_zip, files = list.files(folder_path, full.names = TRUE))
  dhs_data <- rdhs:::read_dhs_flat(temp_zip)
  return(dhs_data)

}


#' Summarize DHS flat-file variable dictionaries
#'
#' Summarize variable names and descriptions across a list of DHS survey datasets.
#'
#' @param all_survey_data A list of survey datasets to summarize.
#'
#' @return A tibble of variable descriptions with counts across surveys.
#'
#' @export
summarize_dhs_flat_dictionary <- function(all_survey_data){
  
  n_surveys <- length(all_survey_data) # shows the number of branches   

  map(
    all_survey_data,
    ~ get_variable_labels(.x) %>%
      as_tibble()
    ) %>%
    list_rbind() %>%
    group_by(description, variable) %>%
    summarise(
      description = first(description),
      n = n()
    ) %>%
    arrange(-n) -> var_descriptions

  return(var_descriptions)
}
