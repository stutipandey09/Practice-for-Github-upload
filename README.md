practise2
================
Stuti Pandey
3/7/2018

R Markdown
----------

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(magrittr)
library(choroplethr)
```

    ## Loading required package: acs

    ## Loading required package: stringr

    ## Loading required package: XML

    ## 
    ## Attaching package: 'acs'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    ## The following object is masked from 'package:base':
    ## 
    ##     apply

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ readr   1.1.1
    ## ✔ tibble  1.4.2     ✔ purrr   0.2.4
    ## ✔ tidyr   0.8.0     ✔ forcats 0.2.0

    ## ── Conflicts ───────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ acs::combine()     masks dplyr::combine()
    ## ✖ tidyr::extract()   masks magrittr::extract()
    ## ✖ dplyr::filter()    masks stats::filter()
    ## ✖ dplyr::lag()       masks stats::lag()
    ## ✖ purrr::set_names() masks magrittr::set_names()

``` r
library(choroplethrMaps)
library(data.table)
```

    ## 
    ## Attaching package: 'data.table'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     transpose

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     between, first, last

``` r
setwd("/Users/stutipandey/Practice Github")
getwd()
```

    ## [1] "/Users/stutipandey/Practice Github"

``` r
data<-fread("Bridge data.csv")
data=mutate(data,cond=min(DECK_COND_058,SUPERSTRUCTURE_COND_059,SUBSTRUCTURE_COND_060,CHANNEL_COND_061,CULVERT_COND_062,na.rm=T))
summary(data)
```

    ##  STATE_CODE_001 STRUCTURE_NUMBER_008 RECORD_TYPE_005A ROUTE_PREFIX_005B
    ##  Min.   :56     Length:3127          Min.   :1        Min.   :1.000    
    ##  1st Qu.:56     Class :character     1st Qu.:1        1st Qu.:1.000    
    ##  Median :56     Mode  :character     Median :1        Median :3.000    
    ##  Mean   :56                          Mean   :1        Mean   :2.919    
    ##  3rd Qu.:56                          3rd Qu.:1        3rd Qu.:4.000    
    ##  Max.   :56                          Max.   :1        Max.   :8.000    
    ##                                                                        
    ##  SERVICE_LEVEL_005C ROUTE_NUMBER_005D  DIRECTION_005E  
    ##  Min.   :0.000      Length:3127        Min.   :0.0000  
    ##  1st Qu.:1.000      Class :character   1st Qu.:0.0000  
    ##  Median :1.000      Mode  :character   Median :0.0000  
    ##  Mean   :1.158                         Mean   :0.7886  
    ##  3rd Qu.:1.000                         3rd Qu.:1.0000  
    ##  Max.   :8.000                         Max.   :4.0000  
    ##                                                        
    ##  HIGHWAY_DISTRICT_002 COUNTY_CODE_003 PLACE_CODE_004    FEATURES_DESC_006A
    ##  Min.   :0.000        Min.   : 1.0    Min.   :    0.0   Length:3127       
    ##  1st Qu.:2.000        1st Qu.:11.0    1st Qu.:    0.0   Class :character  
    ##  Median :3.000        Median :21.0    Median :    0.0   Mode  :character  
    ##  Mean   :2.832        Mean   :21.8    Mean   :   48.9                     
    ##  3rd Qu.:4.000        3rd Qu.:33.0    3rd Qu.:    0.0                     
    ##  Max.   :6.000        Max.   :45.0    Max.   :21415.0                     
    ##                                                                           
    ##  CRITICAL_FACILITY_006B FACILITY_CARRIED_007 LOCATION_009      
    ##  Mode:logical           Length:3127          Length:3127       
    ##  NA's:3127              Class :character     Class :character  
    ##                         Mode  :character     Mode  :character  
    ##                                                                
    ##                                                                
    ##                                                                
    ##                                                                
    ##  MIN_VERT_CLR_010 KILOPOINT_011     BASE_HWY_NETWORK_012
    ##  Min.   : 0.30    Min.   :  0.000   Min.   :0.000       
    ##  1st Qu.:99.99    1st Qu.:  4.862   1st Qu.:0.000       
    ##  Median :99.99    Median : 37.942   Median :0.000       
    ##  Mean   :99.26    Mean   :116.245   Mean   :0.477       
    ##  3rd Qu.:99.99    3rd Qu.:178.270   3rd Qu.:1.000       
    ##  Max.   :99.99    Max.   :858.503   Max.   :1.000       
    ##                                     NA's   :3           
    ##  LRS_INV_ROUTE_013A SUBROUTE_NO_013B    LAT_016        
    ##  Length:3127        Min.   : 0.000   Min.   :       0  
    ##  Class :character   1st Qu.: 0.000   1st Qu.:41416936  
    ##  Mode  :character   Median : 1.000   Median :42512763  
    ##                     Mean   : 1.112   Mean   :42565674  
    ##                     3rd Qu.: 2.000   3rd Qu.:44160457  
    ##                     Max.   :43.000   Max.   :45000035  
    ##                     NA's   :1371                       
    ##     LONG_017         DETOUR_KILOS_019    TOLL_020     MAINTENANCE_021 
    ##  Min.   :        0   Min.   :  0.0    Min.   :3.000   Min.   : 1.000  
    ##  1st Qu.:105084222   1st Qu.:  2.0    1st Qu.:3.000   1st Qu.: 1.000  
    ##  Median :106412137   Median :  6.0    Median :3.000   Median : 1.000  
    ##  Mean   :106402427   Mean   : 59.4    Mean   :3.002   Mean   : 7.891  
    ##  3rd Qu.:108562132   3rd Qu.: 97.0    3rd Qu.:3.000   3rd Qu.: 2.000  
    ##  Max.   :111024786   Max.   :999.0    Max.   :5.000   Max.   :72.000  
    ##                                                                       
    ##    OWNER_022      FUNCTIONAL_CLASS_026 YEAR_BUILT_027
    ##  Min.   : 1.000   Min.   : 1.000       Min.   :1903  
    ##  1st Qu.: 1.000   1st Qu.: 2.000       1st Qu.:1961  
    ##  Median : 1.000   Median : 7.000       Median :1970  
    ##  Mean   : 7.953   Mean   : 6.451       Mean   :1974  
    ##  3rd Qu.: 2.000   3rd Qu.: 9.000       3rd Qu.:1987  
    ##  Max.   :72.000   Max.   :19.000       Max.   :2017  
    ##                                                      
    ##  TRAFFIC_LANES_ON_028A TRAFFIC_LANES_UND_028B    ADT_029     
    ##  Min.   :1.000         Min.   :0.000          Min.   :    0  
    ##  1st Qu.:2.000         1st Qu.:0.000          1st Qu.:  180  
    ##  Median :2.000         Median :0.000          Median : 1231  
    ##  Mean   :2.023         Mean   :0.434          Mean   : 2337  
    ##  3rd Qu.:2.000         3rd Qu.:0.000          3rd Qu.: 3660  
    ##  Max.   :8.000         Max.   :6.000          Max.   :33030  
    ##                                                              
    ##   YEAR_ADT_030  DESIGN_LOAD_031    APPR_WIDTH_MT_032 MEDIAN_CODE_033 
    ##  Min.   :   0   Length:3127        Min.   : 0.000    Min.   :0.0000  
    ##  1st Qu.:2013   Class :character   1st Qu.: 7.300    1st Qu.:0.0000  
    ##  Median :2016   Mode  :character   Median :10.400    Median :0.0000  
    ##  Mean   :1923                      Mean   : 9.759    Mean   :0.2875  
    ##  3rd Qu.:2016                      3rd Qu.:11.600    3rd Qu.:1.0000  
    ##  Max.   :2016                      Max.   :36.900    Max.   :3.0000  
    ##                                                                      
    ##  DEGREES_SKEW_034 STRUCTURE_FLARED_035 RAILINGS_036A     
    ##  Min.   : 0.000   Min.   :0.000000     Length:3127       
    ##  1st Qu.: 0.000   1st Qu.:0.000000     Class :character  
    ##  Median : 0.000   Median :0.000000     Mode  :character  
    ##  Mean   : 8.822   Mean   :0.002239                       
    ##  3rd Qu.:17.000   3rd Qu.:0.000000                       
    ##  Max.   :70.000   Max.   :1.000000                       
    ##                                                          
    ##  TRANSITIONS_036B   APPR_RAIL_036C     APPR_RAIL_END_036D  HISTORY_037   
    ##  Length:3127        Length:3127        Length:3127        Min.   :1.000  
    ##  Class :character   Class :character   Class :character   1st Qu.:4.000  
    ##  Mode  :character   Mode  :character   Mode  :character   Median :4.000  
    ##                                                           Mean   :4.387  
    ##                                                           3rd Qu.:5.000  
    ##                                                           Max.   :5.000  
    ##                                                                          
    ##  NAVIGATION_038     NAV_VERT_CLR_MT_039 NAV_HORR_CLR_MT_040
    ##  Length:3127        Min.   :0           Min.   :0          
    ##  Class :character   1st Qu.:0           1st Qu.:0          
    ##  Mode  :character   Median :0           Median :0          
    ##                     Mean   :0           Mean   :0          
    ##                     3rd Qu.:0           3rd Qu.:0          
    ##                     Max.   :0           Max.   :0          
    ##                                                            
    ##  OPEN_CLOSED_POSTED_041 SERVICE_ON_042A SERVICE_UND_042B
    ##  Length:3127            Min.   :1.000   Min.   :0.000   
    ##  Class :character       1st Qu.:1.000   1st Qu.:2.000   
    ##  Mode  :character       Median :1.000   Median :5.000   
    ##                         Mean   :1.698   Mean   :3.883   
    ##                         3rd Qu.:1.000   3rd Qu.:5.000   
    ##                         Max.   :7.000   Max.   :9.000   
    ##                                                         
    ##  STRUCTURE_KIND_043A STRUCTURE_TYPE_043B APPR_KIND_044A   
    ##  Min.   :1.000       Min.   : 0.00       Min.   :0.00000  
    ##  1st Qu.:2.000       1st Qu.: 2.00       1st Qu.:0.00000  
    ##  Median :3.000       Median : 2.00       Median :0.00000  
    ##  Mean   :3.144       Mean   : 5.09       Mean   :0.04221  
    ##  3rd Qu.:4.000       3rd Qu.: 4.00       3rd Qu.:0.00000  
    ##  Max.   :9.000       Max.   :22.00       Max.   :7.00000  
    ##                                                           
    ##  APPR_TYPE_044B     MAIN_UNIT_SPANS_045 APPR_SPANS_046    HORR_CLR_MT_047
    ##  Min.   : 0.00000   Min.   : 1.000      Min.   :0.00000   Min.   : 0.00  
    ##  1st Qu.: 0.00000   1st Qu.: 1.000      1st Qu.:0.00000   1st Qu.: 7.90  
    ##  Median : 0.00000   Median : 3.000      Median :0.00000   Median :11.00  
    ##  Mean   : 0.02654   Mean   : 2.588      Mean   :0.03102   Mean   :13.19  
    ##  3rd Qu.: 0.00000   3rd Qu.: 3.000      3rd Qu.:0.00000   3rd Qu.:12.20  
    ##  Max.   :11.00000   Max.   :23.000      Max.   :8.00000   Max.   :99.90  
    ##                                                                          
    ##  MAX_SPAN_LEN_MT_048 STRUCTURE_LEN_MT_049 LEFT_CURB_MT_050A
    ##  Min.   :  0.00      Min.   :  6.10       Min.   :0.0000   
    ##  1st Qu.:  7.60      1st Qu.: 13.10       1st Qu.:0.0000   
    ##  Median : 11.90      Median : 26.50       Median :0.0000   
    ##  Mean   : 15.13      Mean   : 35.69       Mean   :0.2258   
    ##  3rd Qu.: 19.20      3rd Qu.: 44.20       3rd Qu.:0.4000   
    ##  Max.   :411.00      Max.   :557.50       Max.   :4.9000   
    ##                                                            
    ##  RIGHT_CURB_MT_050B ROADWAY_WIDTH_MT_051 DECK_WIDTH_MT_052
    ##  Min.   :0.0000     Min.   : 0.00        Min.   : 0.000   
    ##  1st Qu.:0.0000     1st Qu.: 5.80        1st Qu.: 6.100   
    ##  Median :0.0000     Median : 9.80        Median :10.700   
    ##  Mean   :0.2189     Mean   : 8.63        Mean   : 9.539   
    ##  3rd Qu.:0.4000     3rd Qu.:11.60        3rd Qu.:12.550   
    ##  Max.   :4.9000     Max.   :28.00        Max.   :39.600   
    ##                                                           
    ##  VERT_CLR_OVER_MT_053 VERT_CLR_UND_REF_054A VERT_CLR_UND_054B
    ##  Min.   : 0.00        Length:3127           Min.   : 0.000   
    ##  1st Qu.:99.99        Class :character      1st Qu.: 0.000   
    ##  Median :99.99        Mode  :character      Median : 0.000   
    ##  Mean   :98.93                              Mean   : 1.449   
    ##  3rd Qu.:99.99                              3rd Qu.: 0.000   
    ##  Max.   :99.99                              Max.   :99.990   
    ##                                                              
    ##  LAT_UND_REF_055A   LAT_UND_MT_055B  LEFT_LAT_UND_MT_056
    ##  Length:3127        Min.   : 0.000   Min.   : 0.0000    
    ##  Class :character   1st Qu.: 0.000   1st Qu.: 0.0000    
    ##  Mode  :character   Median : 0.000   Median : 0.0000    
    ##                     Mean   : 2.092   Mean   : 0.6277    
    ##                     3rd Qu.: 0.000   3rd Qu.: 0.0000    
    ##                     Max.   :99.900   Max.   :99.8000    
    ##                                                         
    ##  DECK_COND_058      SUPERSTRUCTURE_COND_059 SUBSTRUCTURE_COND_060
    ##  Length:3127        Length:3127             Length:3127          
    ##  Class :character   Class :character        Class :character     
    ##  Mode  :character   Mode  :character        Mode  :character     
    ##                                                                  
    ##                                                                  
    ##                                                                  
    ##                                                                  
    ##  CHANNEL_COND_061   CULVERT_COND_062   OPR_RATING_METH_063
    ##  Length:3127        Length:3127        Length:3127        
    ##  Class :character   Class :character   Class :character   
    ##  Mode  :character   Mode  :character   Mode  :character   
    ##                                                           
    ##                                                           
    ##                                                           
    ##                                                           
    ##  OPERATING_RATING_064 INV_RATING_METH_065 INVENTORY_RATING_066
    ##  Min.   : 0.00        Length:3127         Min.   : 0.00       
    ##  1st Qu.:32.70        Class :character    1st Qu.:29.00       
    ##  Median :50.80        Mode  :character    Median :32.70       
    ##  Mean   :50.27                            Mean   :33.11       
    ##  3rd Qu.:59.90                            3rd Qu.:36.30       
    ##  Max.   :99.90                            Max.   :99.90       
    ##  NA's   :75                               NA's   :75          
    ##  STRUCTURAL_EVAL_067 DECK_GEOMETRY_EVAL_068 UNDCLRENCE_EVAL_069
    ##  Length:3127         Length:3127            Length:3127        
    ##  Class :character    Class :character       Class :character   
    ##  Mode  :character    Mode  :character       Mode  :character   
    ##                                                                
    ##                                                                
    ##                                                                
    ##                                                                
    ##  POSTING_EVAL_070 WATERWAY_EVAL_071  APPR_ROAD_EVAL_072 WORK_PROPOSED_075A
    ##  Min.   :0.000    Length:3127        Min.   :3.000      Min.   :31.00     
    ##  1st Qu.:5.000    Class :character   1st Qu.:8.000      1st Qu.:37.00     
    ##  Median :5.000    Mode  :character   Median :8.000      Median :38.00     
    ##  Mean   :4.827                       Mean   :7.543      Mean   :36.63     
    ##  3rd Qu.:5.000                       3rd Qu.:8.000      3rd Qu.:38.00     
    ##  Max.   :5.000                       Max.   :9.000      Max.   :38.00     
    ##                                                         NA's   :2097      
    ##  WORK_DONE_BY_075B IMP_LEN_MT_076   DATE_OF_INSPECT_090
    ##  Min.   :1.000     Min.   :  0.00   Min.   : 115.0     
    ##  1st Qu.:1.000     1st Qu.:  4.45   1st Qu.: 217.0     
    ##  Median :2.000     Median : 27.70   Median : 516.0     
    ##  Mean   :1.616     Mean   : 37.88   Mean   : 604.6     
    ##  3rd Qu.:2.000     3rd Qu.: 57.30   3rd Qu.: 916.0     
    ##  Max.   :2.000     Max.   :384.70   Max.   :1216.0     
    ##  NA's   :2100      NA's   :1872                        
    ##  INSPECT_FREQ_MONTHS_091 FRACTURE_092A      UNDWATER_LOOK_SEE_092B
    ##  Min.   :12.00           Length:3127        Length:3127           
    ##  1st Qu.:24.00           Class :character   Class :character      
    ##  Median :24.00           Mode  :character   Mode  :character      
    ##  Mean   :23.54                                                    
    ##  3rd Qu.:24.00                                                    
    ##  Max.   :24.00                                                    
    ##                                                                   
    ##  SPEC_INSPECT_092C  FRACTURE_LAST_DATE_093A UNDWATER_LAST_DATE_093B
    ##  Length:3127        Min.   : 116.0          Min.   : 509.0         
    ##  Class :character   1st Qu.: 316.0          1st Qu.: 914.0         
    ##  Mode  :character   Median : 664.5          Median :1014.0         
    ##                     Mean   : 601.3          Mean   : 986.4         
    ##                     3rd Qu.: 815.0          3rd Qu.:1014.0         
    ##                     Max.   :1216.0          Max.   :1209.0         
    ##                     NA's   :3049            NA's   :3036           
    ##  SPEC_LAST_DATE_093C BRIDGE_IMP_COST_094 ROADWAY_IMP_COST_095
    ##  Min.   : 101.0      Min.   :   0.0      Min.   :  0.00      
    ##  1st Qu.: 301.0      1st Qu.:   5.0      1st Qu.:  1.00      
    ##  Median : 355.5      Median :  11.0      Median : 17.00      
    ##  Mean   : 585.2      Mean   : 110.8      Mean   : 20.95      
    ##  3rd Qu.:1008.0      3rd Qu.:  51.0      3rd Qu.: 30.00      
    ##  Max.   :1109.0      Max.   :6510.0      Max.   :651.00      
    ##  NA's   :3117        NA's   :1948        NA's   :1950        
    ##  TOTAL_IMP_COST_096 YEAR_OF_IMP_097 OTHER_STATE_CODE_098A
    ##  Min.   :   0.0     Min.   :2010    Mode:logical         
    ##  1st Qu.:  10.0     1st Qu.:2012    NA's:3127            
    ##  Median :  41.0     Median :2013                         
    ##  Mean   : 170.2     Mean   :2013                         
    ##  3rd Qu.:  92.0     3rd Qu.:2014                         
    ##  Max.   :9765.0     Max.   :2016                         
    ##  NA's   :1897       NA's   :2025                         
    ##  OTHER_STATE_PCNT_098B OTHR_STATE_STRUC_NO_099 STRAHNET_HIGHWAY_100
    ##  Min.   :0             Length:3127             Min.   :0.0000      
    ##  1st Qu.:0             Class :character        1st Qu.:0.0000      
    ##  Median :0             Mode  :character        Median :0.0000      
    ##  Mean   :0                                     Mean   :0.3028      
    ##  3rd Qu.:0                                     3rd Qu.:1.0000      
    ##  Max.   :0                                     Max.   :2.0000      
    ##  NA's   :3106                                                      
    ##  PARALLEL_STRUCTURE_101 TRAFFIC_DIRECTION_102 TEMP_STRUCTURE_103
    ##  Length:3127            Min.   :1.000         Mode:logical      
    ##  Class :character       1st Qu.:1.000         TRUE:1            
    ##  Mode  :character       Median :2.000         NA's:3126         
    ##                         Mean   :1.812                           
    ##                         3rd Qu.:2.000                           
    ##                         Max.   :3.000                           
    ##                                                                 
    ##  HIGHWAY_SYSTEM_104 FEDERAL_LANDS_105 YEAR_RECONSTRUCTED_106
    ##  Min.   :0.000      Min.   :0.0000    Min.   :   0.0        
    ##  1st Qu.:0.000      1st Qu.:0.0000    1st Qu.:   0.0        
    ##  Median :0.000      Median :0.0000    Median :   0.0        
    ##  Mean   :0.434      Mean   :0.1474    Mean   : 126.6        
    ##  3rd Qu.:1.000      3rd Qu.:0.0000    3rd Qu.:   0.0        
    ##  Max.   :1.000      Max.   :3.0000    Max.   :2056.0        
    ##                                       NA's   :76            
    ##  DECK_STRUCTURE_TYPE_107 SURFACE_TYPE_108A  MEMBRANE_TYPE_108B
    ##  Length:3127             Length:3127        Length:3127       
    ##  Class :character        Class :character   Class :character  
    ##  Mode  :character        Mode  :character   Mode  :character  
    ##                                                               
    ##                                                               
    ##                                                               
    ##                                                               
    ##  DECK_PROTECTION_108C PERCENT_ADT_TRUCK_109 NATIONAL_NETWORK_110
    ##  Length:3127          Min.   : 0.00         Min.   :0.0000      
    ##  Class :character     1st Qu.: 5.00         1st Qu.:0.0000      
    ##  Mode  :character     Median :14.00         Median :0.0000      
    ##                       Mean   :15.71         Mean   :0.4522      
    ##                       3rd Qu.:20.00         3rd Qu.:1.0000      
    ##                       Max.   :58.00         Max.   :1.0000      
    ##                       NA's   :301                               
    ##  PIER_PROTECTION_111 BRIDGE_LEN_IND_112 SCOUR_CRITICAL_113 FUTURE_ADT_114 
    ##  Min.   :1           Length:3127        Length:3127        Min.   :    0  
    ##  1st Qu.:1           Class :character   Class :character   1st Qu.:  320  
    ##  Median :1           Mode  :character   Mode  :character   Median : 1730  
    ##  Mean   :1                                                 Mean   : 3369  
    ##  3rd Qu.:1                                                 3rd Qu.: 4765  
    ##  Max.   :1                                                 Max.   :52930  
    ##  NA's   :3096                                                             
    ##  YEAR_OF_FUTURE_ADT_115 MIN_NAV_CLR_MT_116  FED_AGENCY       
    ##  Min.   :2000           Min.   :0          Length:3127       
    ##  1st Qu.:2033           1st Qu.:0          Class :character  
    ##  Median :2036           Median :0          Mode  :character  
    ##  Mean   :2035           Mean   :0                            
    ##  3rd Qu.:2036           3rd Qu.:0                            
    ##  Max.   :2037           Max.   :0                            
    ##                         NA's   :2807                         
    ##  DATE_LAST_UPDATE   TYPE_LAST_UPDATE   DEDUCT_CODE        REMARKS       
    ##  Length:3127        Length:3127        Length:3127        Mode:logical  
    ##  Class :character   Class :character   Class :character   NA's:3127     
    ##  Mode  :character   Mode  :character   Mode  :character                 
    ##                                                                         
    ##                                                                         
    ##                                                                         
    ##                                                                         
    ##  PROGRAM_CODE         PROJ_NO           PROJ_SUFFIX     NBI_TYPE_OF_IMP
    ##  Length:3127        Length:3127        Min.   :0.0000   Min.   : 9.00  
    ##  Class :character   Class :character   1st Qu.:0.0000   1st Qu.:12.00  
    ##  Mode  :character   Mode  :character   Median :0.0000   Median :14.00  
    ##                                        Mean   :0.3748   Mean   :13.18  
    ##                                        3rd Qu.:1.0000   3rd Qu.:14.00  
    ##                                        Max.   :3.0000   Max.   :14.00  
    ##                                        NA's   :2364     NA's   :2364   
    ##  DTL_TYPE_OF_IMP SPECIAL_CODE   STEP_CODE      STATUS_WITH_10YR_RULE
    ##  Min.   : 2.00   Mode:logical   Mode:logical   Min.   :0.0000       
    ##  1st Qu.:11.00   NA's:3127      NA's:3127      1st Qu.:0.0000       
    ##  Median :14.00                                 Median :0.0000       
    ##  Mean   :12.71                                 Mean   :0.2721       
    ##  3rd Qu.:17.00                                 3rd Qu.:0.0000       
    ##  Max.   :44.00                                 Max.   :2.0000       
    ##  NA's   :2364                                                       
    ##  SUFFICIENCY_ASTERC SUFFICIENCY_RATING STATUS_NO_10YR_RULE
    ##  Length:3127        Min.   :  2.00     Min.   :0.0000     
    ##  Class :character   1st Qu.: 79.00     1st Qu.:0.0000     
    ##  Mode  :character   Median : 89.70     Median :0.0000     
    ##                     Mean   : 84.36     Mean   :0.2833     
    ##                     3rd Qu.: 96.40     3rd Qu.:0.0000     
    ##                     Max.   :100.00     Max.   :2.0000     
    ##                                                           
    ##      cond          
    ##  Length:3127       
    ##  Class :character  
    ##  Mode  :character  
    ##                    
    ##                    
    ##                    
    ## 

Including Plots
---------------

You can also embed plots, for example:

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
