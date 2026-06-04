# Title

Ingest the list of files in the project and return those that are flat
DHS recode files

## Usage

``` r
list_raw_flat_dhs(file_list)
```

## Arguments

- file_list:

  Character vector of file paths to check.

## Value

Character vector of flat DHS recode file paths.

## Examples

``` r
link_inputs("config.yml") %>%
  list_raw_flat_dhs()
#> Linking the google drive data space to the local Data directory: /n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data
#> Warning: cannot symlink '/n/holylabs/LABS/cgolden_lab/Lab/data_freeze/golden_googledrive_rclone/Climate-Smart Public Health - Madagascar/4. Datasets/DHS Data' to '/work/data/DHS Data', reason 'File exists'
#> Linking successful!
#>  [1] "/work/data/DHS Data/DHS 1992/MDBR21FL"                                             
#>  [2] "/work/data/DHS Data/DHS 1992/MDHR21FL"                                             
#>  [3] "/work/data/DHS Data/DHS 1992/MDHW21FL"                                             
#>  [4] "/work/data/DHS Data/DHS 1992/MDIR21FL"                                             
#>  [5] "/work/data/DHS Data/DHS 1992/MDKR21FL"                                             
#>  [6] "/work/data/DHS Data/DHS 1992/MDPR21FL"                                             
#>  [7] "/work/data/DHS Data/DHS 1992/MDSQ21FL"                                             
#>  [8] "/work/data/DHS Data/DHS 1997/MDBR31FL"                                             
#>  [9] "/work/data/DHS Data/DHS 1997/MDHR31FL"                                             
#> [10] "/work/data/DHS Data/DHS 1997/MDHW31FL"                                             
#> [11] "/work/data/DHS Data/DHS 1997/MDIR31FL"                                             
#> [12] "/work/data/DHS Data/DHS 1997/MDKR31FL"                                             
#> [13] "/work/data/DHS Data/DHS 1997/MDPR31FL"                                             
#> [14] "/work/data/DHS Data/DHS 1997/MDWI31FL"                                             
#> [15] "/work/data/DHS Data/DHS 2003-04/MDBR42FL"                                          
#> [16] "/work/data/DHS Data/DHS 2003-04/MDCR42FL"                                          
#> [17] "/work/data/DHS Data/DHS 2003-04/MDHR42FL"                                          
#> [18] "/work/data/DHS Data/DHS 2003-04/MDHW41FL"                                          
#> [19] "/work/data/DHS Data/DHS 2003-04/MDIR42FL"                                          
#> [20] "/work/data/DHS Data/DHS 2003-04/MDKR42FL"                                          
#> [21] "/work/data/DHS Data/DHS 2003-04/MDMR42FL"                                          
#> [22] "/work/data/DHS Data/DHS 2003-04/MDPR42FL"                                          
#> [23] "/work/data/DHS Data/DHS 2008-09/MDBR51FL"                                          
#> [24] "/work/data/DHS Data/DHS 2008-09/MDCR51FL"                                          
#> [25] "/work/data/DHS Data/DHS 2008-09/MDHR51FL"                                          
#> [26] "/work/data/DHS Data/DHS 2008-09/MDIR51FL"                                          
#> [27] "/work/data/DHS Data/DHS 2008-09/MDKR51FL"                                          
#> [28] "/work/data/DHS Data/DHS 2008-09/MDMR51FL"                                          
#> [29] "/work/data/DHS Data/DHS 2008-09/MDPR51FL"                                          
#> [30] "/work/data/DHS Data/DHS 2021/MDBR80FL"                                             
#> [31] "/work/data/DHS Data/DHS 2021/MDCR80FL"                                             
#> [32] "/work/data/DHS Data/DHS 2021/MDFW81FL"                                             
#> [33] "/work/data/DHS Data/DHS 2021/MDHR80FL"                                             
#> [34] "/work/data/DHS Data/DHS 2021/MDIR80FL"                                             
#> [35] "/work/data/DHS Data/DHS 2021/MDKR80FL"                                             
#> [36] "/work/data/DHS Data/DHS 2021/MDMR80FL"                                             
#> [37] "/work/data/DHS Data/DHS 2021/MDPR80FL"                                             
#> [38] "/work/data/DHS Data/MIS 2011/MDHR61FL"                                             
#> [39] "/work/data/DHS Data/MIS 2011/MDIR61FL"                                             
#> [40] "/work/data/DHS Data/MIS 2011/MDKR61FL"                                             
#> [41] "/work/data/DHS Data/MIS 2011/MDPR61FL"                                             
#> [42] "/work/data/DHS Data/MIS 2016/MDHR71FL"                                             
#> [43] "/work/data/DHS Data/MIS 2016/MDIR71FL"                                             
#> [44] "/work/data/DHS Data/MIS 2016/MDKR71FL"                                             
#> [45] "/work/data/DHS Data/MIS 2016/MDPR71FL"                                             
#> [46] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDBR21FL"   
#> [47] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDHR21FL"   
#> [48] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDHW21FL"   
#> [49] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDIR21FL"   
#> [50] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDKR21FL"   
#> [51] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDPR21FL"   
#> [52] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1992/MDSQ21FL"   
#> [53] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDBR31FL"   
#> [54] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDHR31FL"   
#> [55] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDHW31FL"   
#> [56] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDIR31FL"   
#> [57] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDKR31FL"   
#> [58] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDPR31FL"   
#> [59] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 1997/MDWI31FL"   
#> [60] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDBR42FL"
#> [61] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDCR42FL"
#> [62] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDHR42FL"
#> [63] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDHW41FL"
#> [64] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDIR42FL"
#> [65] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDKR42FL"
#> [66] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDMR42FL"
#> [67] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2003-04/MDPR42FL"
#> [68] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDBR51FL"
#> [69] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDCR51FL"
#> [70] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDHR51FL"
#> [71] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDIR51FL"
#> [72] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDKR51FL"
#> [73] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDMR51FL"
#> [74] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2008-09/MDPR51FL"
#> [75] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDBR80FL"   
#> [76] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDCR80FL"   
#> [77] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDFW81FL"   
#> [78] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDHR80FL"   
#> [79] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDIR80FL"   
#> [80] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDKR80FL"   
#> [81] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDMR80FL"   
#> [82] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/DHS 2021/MDPR80FL"   
#> [83] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/MDHR61FL"   
#> [84] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/MDIR61FL"   
#> [85] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/MDKR61FL"   
#> [86] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2011/MDPR61FL"   
#> [87] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/MDHR71FL"   
#> [88] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/MDIR71FL"   
#> [89] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/MDKR71FL"   
#> [90] "/work/data/inputs/01_gold_mine/google_drive_DHS_data/DHS Data/MIS 2016/MDPR71FL"   
```
