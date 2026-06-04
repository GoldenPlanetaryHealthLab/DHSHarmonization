
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DHSHarmonization

<!-- badges: start -->

<!-- badges: end -->

The goal of DHSHarmonization is to provide the Golden Lab with a
pipeline to harmonize and extract data from Demographic and Health
Surveys (DHS) for analysis. The pipeline is built on targets to ensure
reproducibility and is designed to be flexible to accommodate different
research questions and datasets.

To get an understanding of the data, investigate the vignettes in the
Articles section, which contain detailed explanations of the data
loading and harmonization process, and some minimal exploratory data
analysis (EDA) to help you understand the variables available.

If you require a pipeline endpoint dataset that is not currently
implemented, please open an issue or reach out to Tinashe.

## Installation

If you would like to install the development version of
DHSHarmonization, and build the package pipeline yourself, you can do so
with the following code:

``` r
# install.packages("devtools")
devtools::install_github("Climate-Smart-Public-Health/DHSHarmonization")
```

> Note: This can only be accomplished if you have access to the DHS data
> through FASRC and the Golden Lab space on FASRC.

## Example

> Important: This is a work in progress; please make a data request on
> Github first before running the pipeline locally.

Once you’ve installed the package, you can run the pipeline with
targets::tar\_make()

``` r
tar_make()
```

This will execute the entire pipeline as defined in the `_targets.R`
file, downloading and harmonizing the DHS data according to the
specifications in the package.

See the Articles section for vignettes that provide detailed
walkthroughs of pipeline development and target components.

## Pipeline

``` r
library(targets)
tar_mermaid()
#> - The project is out-of-sync -- use `renv::status()` for details.
#> here() starts at /n/holylabs/cgolden_lab/Lab/projects/DHSHarmonization
#> + gps_covar_data declared [6 branches]
#> + gps_data declared [6 branches]
#> + dhs_data_SQ declared [1 branches]
#> + dhs_data_HR declared [7 branches]
#> + dhs_data_BR declared [5 branches]
#> + dhs_data_CR declared [3 branches]
#> + dhs_data_PR declared [7 branches]
#> + dhs_data_IR declared [7 branches]
#> + dhs_data_HW declared [3 branches]
#> + dhs_data_FW declared [1 branches]
#> + dhs_data_WI declared [1 branches]
#> + dhs_data_MR declared [3 branches]
#> + dhs_data_KR declared [7 branches]
#>  [1] "graph LR"                                                                                                             
#>  [2] "  style Legend fill:#FFFFFF00,stroke:#000000;"                                                                        
#>  [3] "  style Graph fill:#FFFFFF00,stroke:#000000;"                                                                         
#>  [4] "  subgraph Legend"                                                                                                    
#>  [5] "    xf1522833a4d242c5([\"Up to date\"]):::uptodate"                                                                   
#>  [6] "    xeb2d7cac8a1ce544>\"Function\"]:::none"                                                                           
#>  [7] "    xd03d7c7dd2ddda2b([\"Regular target\"]):::none"                                                                   
#>  [8] "    x6f7e04ea3427f824[\"Dynamic branches\"]:::none"                                                                   
#>  [9] "  end"                                                                                                                
#> [10] "  subgraph Graph"                                                                                                     
#> [11] "    direction LR"                                                                                                     
#> [12] "    xee0c57ecf70dae2e([\"files_for_type_BR\"]):::uptodate --> xaf71ba3753864455[\"dhs_data_BR\"]:::uptodate"          
#> [13] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> xaf71ba3753864455[\"dhs_data_BR\"]:::uptodate"           
#> [14] "    xed47c6d9491838ba([\"files_for_type_CR\"]):::uptodate --> xc6a02429f1275e9c[\"dhs_data_CR\"]:::uptodate"          
#> [15] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> xc6a02429f1275e9c[\"dhs_data_CR\"]:::uptodate"           
#> [16] "    xe2d628dbe32b92f9([\"files_for_type_FW\"]):::uptodate --> x6669e45951c76542[\"dhs_data_FW\"]:::uptodate"          
#> [17] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x6669e45951c76542[\"dhs_data_FW\"]:::uptodate"           
#> [18] "    x2a0c300e1a8a6de2([\"files_for_type_HR\"]):::uptodate --> x0d47dad6983a1aa2[\"dhs_data_HR\"]:::uptodate"          
#> [19] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x0d47dad6983a1aa2[\"dhs_data_HR\"]:::uptodate"           
#> [20] "    xf99a6980afe5beec([\"files_for_type_HW\"]):::uptodate --> xfa615ac5c839fadb[\"dhs_data_HW\"]:::uptodate"          
#> [21] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> xfa615ac5c839fadb[\"dhs_data_HW\"]:::uptodate"           
#> [22] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x43215ab83c9a3a83[\"dhs_data_IR\"]:::uptodate"           
#> [23] "    x8ae7d8720f60fe7e([\"files_for_type_IR\"]):::uptodate --> x43215ab83c9a3a83[\"dhs_data_IR\"]:::uptodate"          
#> [24] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> xba497180dafcc8ba[\"dhs_data_KR\"]:::uptodate"           
#> [25] "    x94310d3977452ff7([\"files_for_type_KR\"]):::uptodate --> xba497180dafcc8ba[\"dhs_data_KR\"]:::uptodate"          
#> [26] "    xc5c93bfd1a87c867([\"files_for_type_MR\"]):::uptodate --> x5de2f30116c2c3d1[\"dhs_data_MR\"]:::uptodate"          
#> [27] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x5de2f30116c2c3d1[\"dhs_data_MR\"]:::uptodate"           
#> [28] "    x68c3c6c4b8901331([\"files_for_type_PR\"]):::uptodate --> x9972cdca00cfdeb8[\"dhs_data_PR\"]:::uptodate"          
#> [29] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x9972cdca00cfdeb8[\"dhs_data_PR\"]:::uptodate"           
#> [30] "    xde9081cd754fef2c([\"files_for_type_SQ\"]):::uptodate --> xbb71bb17868ddc3a[\"dhs_data_SQ\"]:::uptodate"          
#> [31] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> xbb71bb17868ddc3a[\"dhs_data_SQ\"]:::uptodate"           
#> [32] "    x5950ce2b2ae8abf6>\"load_flat_dhs_data\"]:::uptodate --> x287b4c29954b3f82[\"dhs_data_WI\"]:::uptodate"           
#> [33] "    xb5d9d5201bbb3f3f([\"files_for_type_WI\"]):::uptodate --> x287b4c29954b3f82[\"dhs_data_WI\"]:::uptodate"          
#> [34] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xee0c57ecf70dae2e([\"files_for_type_BR\"]):::uptodate" 
#> [35] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xed47c6d9491838ba([\"files_for_type_CR\"]):::uptodate" 
#> [36] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xe2d628dbe32b92f9([\"files_for_type_FW\"]):::uptodate" 
#> [37] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> x2a0c300e1a8a6de2([\"files_for_type_HR\"]):::uptodate" 
#> [38] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xf99a6980afe5beec([\"files_for_type_HW\"]):::uptodate" 
#> [39] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> x8ae7d8720f60fe7e([\"files_for_type_IR\"]):::uptodate" 
#> [40] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> x94310d3977452ff7([\"files_for_type_KR\"]):::uptodate" 
#> [41] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xc5c93bfd1a87c867([\"files_for_type_MR\"]):::uptodate" 
#> [42] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> x68c3c6c4b8901331([\"files_for_type_PR\"]):::uptodate" 
#> [43] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xde9081cd754fef2c([\"files_for_type_SQ\"]):::uptodate" 
#> [44] "    x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate --> xb5d9d5201bbb3f3f([\"files_for_type_WI\"]):::uptodate" 
#> [45] "    x1bba643633e63347>\"load_gps_covars\"]:::uptodate --> xadcf4f38c96c60e2[\"gps_covar_data\"]:::uptodate"           
#> [46] "    x1ac047943b5137b3([\"raw_gps_covar_files\"]):::uptodate --> xadcf4f38c96c60e2[\"gps_covar_data\"]:::uptodate"     
#> [47] "    x64718cb17342870c([\"raw_gps_dhs_files\"]):::uptodate --> x7a02edc4b3df73c1[\"gps_data\"]:::uptodate"             
#> [48] "    x26a1cf6aee197026([\"cfg\"]):::uptodate --> x66a202fd287760fb([\"raw_data_ready\"]):::uptodate"                   
#> [49] "    x39e927dcb2b817b3>\"link_inputs\"]:::uptodate --> x66a202fd287760fb([\"raw_data_ready\"]):::uptodate"             
#> [50] "    x97072365a517b011>\"list_raw_flat_dhs\"]:::uptodate --> x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate"   
#> [51] "    x66a202fd287760fb([\"raw_data_ready\"]):::uptodate --> x95ba995a9b41bdb4([\"raw_flat_dhs_files\"]):::uptodate"    
#> [52] "    x66a202fd287760fb([\"raw_data_ready\"]):::uptodate --> x1ac047943b5137b3([\"raw_gps_covar_files\"]):::uptodate"   
#> [53] "    x19c8cc5c1c41859e>\"list_raw_gps_covars\"]:::uptodate --> x1ac047943b5137b3([\"raw_gps_covar_files\"]):::uptodate"
#> [54] "    xbec1a22f3438e8ad>\"list_raw_gps_dhs\"]:::uptodate --> x64718cb17342870c([\"raw_gps_dhs_files\"]):::uptodate"     
#> [55] "    x66a202fd287760fb([\"raw_data_ready\"]):::uptodate --> x64718cb17342870c([\"raw_gps_dhs_files\"]):::uptodate"     
#> [56] "    xb18bb9f7b1b9f70c>\"list_raw_flat_mis\"]:::uptodate"                                                              
#> [57] "    x5d59b91dfcb23bc3>\"summarize_dhs_flat_dictionary\"]:::uptodate"                                                  
#> [58] "  end"                                                                                                                
#> [59] "  classDef uptodate stroke:#000000,color:#ffffff,fill:#354823;"                                                       
#> [60] "  classDef none stroke:#000000,color:#000000,fill:#94a4ac;"
```
