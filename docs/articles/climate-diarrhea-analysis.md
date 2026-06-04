# Climate Diarrhea Analysis

``` r

library(DHSHarmonization)
```

## climate_diarrhea_analysis

This endpoint function develops the dataset for analyzing the
relationship between climate variables and diarrhea incidence, based on
[Issue
\#2](https://github.com/Climate-Smart-Public-Health/DHSHarmonization/issues/2).

``` r

library(targets)
library(here)
#> here() starts at /work
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(purrr)
library(rdhs)
#> Thank you for using rdhs. If you are using rdhs regularly
#> or for automated tasks, please register for your own API key by
#> emailing api@dhsprogram.com. 
#> 
#> More info at <https://api.dhsprogram.com/#/introdevelop.html>
library(janitor)
#> 
#> Attaching package: 'janitor'
#> The following objects are masked from 'package:stats':
#> 
#>     chisq.test, fisher.test
library(lubridate)
#> 
#> Attaching package: 'lubridate'
#> The following objects are masked from 'package:base':
#> 
#>     date, intersect, setdiff, union
library(glue)
tar_load(dhs_data_HR, store = here("_targets/"))
```

We first load the DHS data from the household recode and filter the
relevant variables from the request:

``` r

dhs_data_HR %>% length()
#> [1] 7
```

There’s 7 datasets; will they merge automatically?

``` r

tryCatch({

  dhs_data_HR %>% rdhs::rbind_labelled()
}, error = function(e) {
  message("Error in merging datasets: ", e$message)
})
#> Error in merging datasets: undefined columns selected
```

Nope, so we have to filter it manually:

``` r

var_req_list <- c(
  "hv001",
  "hv008",
  "hv209",
  "hv013",
  "hv009",
  "hv201",
  "hv025",
  "hv205",
  "hv225",
  "hv237",
  "hv235",
  "hv238",
  "hv237b",
  "hv237a",
  "hv237z",
  "hv237f",
  "hv237x",
  "hv237e",
  "hv237c",
  "hv246f",
  "hv237d",
  "hv246b",
  "hv246d",
  "hv246c",
  "hv246",
  "hv246e",
  "hv232",
  "hv238a",
  "hv246f",
  "hv246g",
  "hv230a",
  "hv230b",
  "sh18a",
  "hv246a",
  "hv246f",
  "hv246b",
  "hv246g",
  "hv246h",
  "hv246d",
  "hv246c",
  "sh139c",
  "sh139b",
  "sh139a",
  "hv233",
  "hv232",
  "hv231",
  "hv246",
  "hv246h",
  "hv246i",
  "hv246j",
  "hv246k",
  "hv246a",
  "hv246f",
  "hv246a",
  "hv246i",
  "hv246h",
  "hv230",
  "hv246e",
  "sh22a",
  "sh138"
)
dhs_data_HR %>% 
  summarize_dhs_flat_dictionary() %>%
  mutate(description = janitor::make_clean_names(description)) -> dhs_dict_HR
```

``` r

dhs_dict_HR %>%
  dplyr::filter(variable %in% var_req_list)
#> # A tibble: 71 × 3
#> # Groups:   description [71]
#>    description                                  variable     n
#>    <chr>                                        <chr>    <int>
#>  1 cluster_number                               hv001        7
#>  2 date_of_interview_cmc                        hv008        7
#>  3 has_refrigerator                             hv209        7
#>  4 number_of_de_facto_members                   hv013        7
#>  5 number_of_household_members                  hv009        7
#>  6 source_of_drinking_water                     hv201        7
#>  7 type_of_place_of_residence                   hv025        7
#>  8 type_of_toilet_facility                      hv205        7
#>  9 share_toilet_with_other_households           hv225        5
#> 10 anything_done_to_water_to_make_safe_to_drink hv237        4
#> # ℹ 61 more rows
```

Now we need to filter each dataset for these variables and then merge
them:

``` r

dhs_data_HR %>%
  map(., function(df) {
    df %>%
      dplyr::select(hv000, hv006, hv007, hv008,dplyr::any_of(var_req_list))

  }) %>%
  map(., function(df) {
    data_and_labels(df) %>%
      pluck("dataset") %>%
      haven::as_factor()
  }) %>%
  bind_rows() %>%
  tibble() -> dhs_data_filtered_list
```

To rename the columns:

``` r

rename_map <- setNames(dhs_dict_HR$variable, dhs_dict_HR$description)
dhs_data_filtered_list %>%
  rename(any_of(rename_map)) -> dhs_data_renamed
```

We should also manipulate the date of the interview:

``` r

dhs_data_renamed %>%
  mutate(interview_date = my(glue("{month_of_interview} {year_of_interview}"))) %>%
  select(-c(month_of_interview, year_of_interview, date_of_interview_cmc)) -> dhs_data_final

skimr::skim(dhs_data_final)
```

|                                                  |                |
|:-------------------------------------------------|:---------------|
| Name                                             | dhs_data_final |
| Number of rows                                   | 79280          |
| Number of columns                                | 46             |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_   |                |
| Column type frequency:                           |                |
| character                                        | 1              |
| Date                                             | 1              |
| factor                                           | 41             |
| numeric                                          | 3              |
| \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_ |                |
| Group variables                                  | None           |

Data summary {.table}

**Variable type: character**

| skim_variable | n_missing | complete_rate | min | max | empty | n_unique | whitespace |
|:---|---:|---:|---:|---:|---:|---:|---:|
| country_code_and_phase | 0 | 1 | 3 | 3 | 0 | 6 | 0 |

**Variable type: Date**

| skim_variable | n_missing | complete_rate | min | max | median | n_unique |
|:---|---:|---:|:---|:---|:---|---:|
| interview_date | 0 | 1 | 1992-02-01 | 2021-07-01 | 2011-03-01 | 42 |

**Variable type: factor**

| skim_variable | n_missing | complete_rate | ordered | n_unique | top_counts |
|:---|---:|---:|:---|---:|:---|
| has_refrigerator | 0 | 1.00 | FALSE | 4 | no: 75696, yes: 3561, mis: 14, 9: 9 |
| source_of_drinking_water | 0 | 1.00 | FALSE | 41 | pub: 11443, unp: 10483, riv: 8538, unp: 8140 |
| type_of_place_of_residence | 0 | 1.00 | FALSE | 2 | rur: 56455, urb: 22825, mis: 0 |
| type_of_toilet_facility | 0 | 1.00 | FALSE | 33 | no : 24699, pit: 19399, pit: 5930, pit: 4536 |
| bathroom_is_used_by_household_only | 76318 | 0.04 | FALSE | 3 | no: 1907, yes: 1018, 9: 37 |
| share_toilet_with_other_households | 40543 | 0.49 | FALSE | 3 | yes: 25534, no: 13178, mis: 25 |
| items_present_soap_or_detergent | 55220 | 0.30 | FALSE | 3 | no: 14078, yes: 9975, mis: 7 |
| items_present_basin | 73120 | 0.08 | FALSE | 3 | no: 3333, yes: 2807, mis: 20 |
| items_present_water_tap | 73120 | 0.08 | FALSE | 3 | no: 3771, yes: 2376, mis: 13 |
| place_for_hand_washing | 70860 | 0.11 | FALSE | 4 | in : 6160, som: 1727, now: 531, mis: 2 |
| source_of_drinking_water_2 | 70860 | 0.11 | FALSE | 15 | riv: 3376, pub: 2023, pip: 557, pip: 522 |
| anything_done_to_water_to_make_safe_to_drink | 29629 | 0.63 | FALSE | 4 | no: 29054, yes: 20480, don: 114, mis: 3 |
| location_of_source_for_water | 33327 | 0.58 | FALSE | 4 | els: 39581, in : 6134, in : 223, mis: 15 |
| number_of_households_sharing_toilet | 60236 | 0.24 | FALSE | 11 | 2: 6121, 3: 4914, 4: 2774, 5: 1711 |
| water_usually_treated_by_add_bleach_chlorine | 29629 | 0.63 | FALSE | 4 | no: 47771, yes: 1760, don: 114, mis: 6 |
| water_usually_treated_by_boil | 29629 | 0.63 | FALSE | 4 | no: 32172, yes: 17359, don: 114, mis: 6 |
| water_usually_treated_by_dont_know | 29629 | 0.63 | FALSE | 6 | no: 49526, don: 103, don: 11, mis: 6 |
| water_usually_treated_by_let_it_stand_and_settle | 29629 | 0.63 | FALSE | 4 | no: 48563, yes: 968, don: 114, mis: 6 |
| water_usually_treated_by_other | 29629 | 0.63 | FALSE | 4 | no: 49476, don: 114, yes: 55, mis: 6 |
| water_usually_treated_by_solar_disinfection | 29629 | 0.63 | FALSE | 4 | no: 49501, don: 114, yes: 30, mis: 6 |
| water_usually_treated_by_strain_through_a_cloth | 29629 | 0.63 | FALSE | 4 | no: 48999, yes: 532, don: 114, mis: 6 |
| owns_chickens_poultry | 29629 | 0.63 | FALSE | 78 | non: 23307, 10: 2732, 2: 2635, 4: 2304 |
| water_usually_treated_by_use_water_filter | 29629 | 0.63 | FALSE | 4 | no: 49213, yes: 318, don: 114, mis: 6 |
| owns_cows_bulls | 29629 | 0.63 | FALSE | 51 | non: 45830, 2: 1080, 1: 777, 3: 481 |
| owns_goats | 29629 | 0.63 | FALSE | 44 | non: 48035, 2: 282, 3: 172, 4: 171 |
| owns_horses_donkeys_mules | 29629 | 0.63 | FALSE | 17 | non: 49465, 2: 122, 4: 12, 3: 11 |
| owns_livestock_herds_or_farm_animals | 29629 | 0.63 | FALSE | 3 | yes: 31954, no: 17692, mis: 5 |
| owns_sheep | 29629 | 0.63 | FALSE | 40 | non: 48341, 2: 273, 3: 142, 4: 140 |
| owns_cs | 29629 | 0.63 | FALSE | 62 | non: 39286, 2: 2921, 1: 1904, 3: 1167 |
| cattle_own | 50139 | 0.37 | FALSE | 67 | non: 22154, 2: 2031, 1: 882, 4: 821 |
| ducks_geese_turkeys | 40913 | 0.48 | FALSE | 50 | non: 32225, 1: 1471, 2: 1357, 3: 673 |
| household_has_basin | 65644 | 0.17 | FALSE | 3 | no: 8971, yes: 4622, mis: 43 |
| household_has_soap_ash_or_other_cleansing_agent | 65644 | 0.17 | FALSE | 3 | yes: 7152, no: 6459, mis: 25 |
| household_has_water_tap | 65644 | 0.17 | FALSE | 3 | yes: 11278, no: 2346, mis: 12 |
| na_cs_own | 58770 | 0.26 | FALSE | 27 | non: 17155, 1: 1481, 2: 1039, 3: 336 |
| na_owns_cs | 79280 | 0.00 | FALSE | 0 | non: 0, mor: 0, unk: 0, mis: 0 |
| na_owns_cs_2 | 79280 | 0.00 | FALSE | 0 | non: 0, mor: 0, unk: 0, mis: 0 |
| usual_place_for_handwashing | 61423 | 0.23 | FALSE | 4 | in : 12329, now: 4213, som: 1307, mis: 8 |
| location_of_toilet_facility | 59367 | 0.25 | FALSE | 3 | in : 11719, els: 7399, in : 795, mis: 0 |
| place_where_household_members_wash_their_hands | 58770 | 0.26 | FALSE | 5 | obs: 12091, obs: 5809, not: 2244, not: 228 |
| presence_of_water_at_hand_washing_place | 61380 | 0.23 | FALSE | 2 | wat: 11789, wat: 6111, mis: 0 |

**Variable type: numeric**

| skim_variable | n_missing | complete_rate | mean | sd | p0 | p25 | p50 | p75 | p100 | hist |
|:---|---:|---:|---:|---:|---:|---:|---:|---:|---:|:---|
| cluster_number | 0 | 1 | 228.01 | 165.41 | 1 | 96 | 193 | 325 | 657 | ▇▇▃▂▂ |
| number_of_de_facto_members | 0 | 1 | 4.47 | 2.47 | 0 | 3 | 4 | 6 | 40 | ▇▁▁▁▁ |
| number_of_household_members | 0 | 1 | 4.68 | 2.48 | 1 | 3 | 4 | 6 | 41 | ▇▁▁▁▁ |

Looks great! Let’s put this in the function:

``` r

#climate_diarrhea_analysis()
```
