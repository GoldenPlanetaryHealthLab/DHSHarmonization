# Title

Ingest the list of files in the project and return those that are GPS
DHS files

## Usage

``` r
list_raw_gps_dhs(file_list)
```

## Arguments

- file_list:

  Character vector of file paths to check.

## Value

Character vector of GPS DHS file paths.

## Examples

``` r
link_inputs("config.yml") %>%
  list_raw_gps_dhs()
#> Linking the google drive data space to the local Data directory: /n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data
#> Warning: cannot symlink '/n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data' to '/work/data/DHS Data', reason 'File exists'
#> Linking successful!
#>  [1] "/work/data/DHS Data/DHS 1997/GPS Data/MDGE32FL/MDGE32FL.shp"                                             
#>  [2] "/work/data/DHS Data/DHS 2008 geospatial/MDGE53FL/MDGE53FL.shp"                                           
#>  [3] "/work/data/DHS Data/DHS 2008-09/GPS Data/MDGE53FL/MDGE53FL.shp"                                          
#>  [4] "/work/data/DHS Data/DHS 2021/GPS data/MDGE81FL/MDGE81FL.shp"                                             
#>  [5] "/work/data/DHS Data/MIS 2011/GPS Data/MDGE61FL/MDGE61FL.shp"                                             
#>  [6] "/work/data/DHS Data/MIS 2016/GPS Data/MDGE71FL/MDGE71FL.shp"                                             
#>  [7] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/GPS Data/MDGE32FL/MDGE32FL.shp"   
#>  [8] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008 geospatial/MDGE53FL/MDGE53FL.shp" 
#>  [9] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/GPS Data/MDGE53FL/MDGE53FL.shp"
#> [10] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/GPS data/MDGE81FL/MDGE81FL.shp"   
#> [11] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/GPS Data/MDGE61FL/MDGE61FL.shp"   
#> [12] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/GPS Data/MDGE71FL/MDGE71FL.shp"   
```
