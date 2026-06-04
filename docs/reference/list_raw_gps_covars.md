# Title

Description

## Usage

``` r
list_raw_gps_covars(file_list)
```

## Examples

``` r
link_inputs("config.yml") %>%
  list_raw_gps_covars()
#> Linking the google drive data space to the local Data directory: /n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data
#> Warning: cannot symlink '/n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data' to '/work/data/DHS Data', reason 'File exists'
#> Linking successful!
#>  [1] "/work/data/DHS Data/DHS 1997/GPS Data/MDGC32FL/MDGC32FL.csv"                                                   
#>  [2] "/work/data/DHS Data/DHS 2008 geospatial/MDGC52FL/MDGC52FL.csv"                                                 
#>  [3] "/work/data/DHS Data/DHS 2008-09/GPS Data/MDGC52FL/MDGC52FL.csv"                                                
#>  [4] "/work/data/DHS Data/DHS 2021/GPS data/MDGC81FL/MDGC81FL/MDGC81FL.csv"                                          
#>  [5] "/work/data/DHS Data/MIS 2011/GPS Data/MDGC62FL/MDGC62FL.csv"                                                   
#>  [6] "/work/data/DHS Data/MIS 2016/GPS Data/MDGC72FL/MDGC72FL.csv"                                                   
#>  [7] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/GPS Data/MDGC32FL/MDGC32FL.csv"         
#>  [8] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008 geospatial/MDGC52FL/MDGC52FL.csv"       
#>  [9] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/GPS Data/MDGC52FL/MDGC52FL.csv"      
#> [10] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/GPS data/MDGC81FL/MDGC81FL/MDGC81FL.csv"
#> [11] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/GPS Data/MDGC62FL/MDGC62FL.csv"         
#> [12] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/GPS Data/MDGC72FL/MDGC72FL.csv"         
```
