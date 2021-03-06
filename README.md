
<!-- README.md is generated from README.Rmd. Please edit that file -->

# chainr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

## `chain`

When working with relational data, it’s easier to think of data frames
being chained together. You can for example create a `chain` list as
below.

``` r
library(chainr)
usa <- chain(
      state_stats = as.data.frame(state.x77),
      state_info = data.frame(name = state.name,
                              abb = state.abb,
                              division = state.division,
                              region = state.region),
      arrests = USArrests
    )
str(usa)
#> List of 3
#>  $ state_stats:'data.frame': 50 obs. of  8 variables:
#>   ..$ Population: num [1:50] 3615 365 2212 2110 21198 ...
#>   ..$ Income    : num [1:50] 3624 6315 4530 3378 5114 ...
#>   ..$ Illiteracy: num [1:50] 2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
#>   ..$ Life Exp  : num [1:50] 69 69.3 70.5 70.7 71.7 ...
#>   ..$ Murder    : num [1:50] 15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
#>   ..$ HS Grad   : num [1:50] 41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
#>   ..$ Frost     : num [1:50] 20 152 15 65 20 166 139 103 11 60 ...
#>   ..$ Area      : num [1:50] 50708 566432 113417 51945 156361 ...
#>  $ state_info :'data.frame': 50 obs. of  4 variables:
#>   ..$ name    : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#>   ..$ abb     : chr [1:50] "AL" "AK" "AZ" "AR" ...
#>   ..$ division: Factor w/ 9 levels "New England",..: 4 9 8 5 9 8 1 3 3 3 ...
#>   ..$ region  : Factor w/ 4 levels "Northeast","South",..: 2 4 4 2 4 4 1 2 2 2 ...
#>  $ arrests    :'data.frame': 50 obs. of  4 variables:
#>   ..$ Murder  : num [1:50] 13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
#>   ..$ Assault : int [1:50] 236 263 294 190 276 204 110 238 335 211 ...
#>   ..$ UrbanPop: int [1:50] 58 48 80 50 91 78 77 72 80 60 ...
#>   ..$ Rape    : num [1:50] 21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...
#>  - attr(*, "class")= chr [1:2] "chain" "list"
```

Then you can apply some familiar `dplyr` verbs, however you have an
additional argument to supply to reference which dataset(s).

``` r
library(dplyr)
usa %>% 
  select_in(arrests, Murder) %>% 
  str()
#> List of 3
#>  $ state_stats:'data.frame': 50 obs. of  8 variables:
#>   ..$ Population: num [1:50] 3615 365 2212 2110 21198 ...
#>   ..$ Income    : num [1:50] 3624 6315 4530 3378 5114 ...
#>   ..$ Illiteracy: num [1:50] 2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
#>   ..$ Life Exp  : num [1:50] 69 69.3 70.5 70.7 71.7 ...
#>   ..$ Murder    : num [1:50] 15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
#>   ..$ HS Grad   : num [1:50] 41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
#>   ..$ Frost     : num [1:50] 20 152 15 65 20 166 139 103 11 60 ...
#>   ..$ Area      : num [1:50] 50708 566432 113417 51945 156361 ...
#>  $ state_info :'data.frame': 50 obs. of  4 variables:
#>   ..$ name    : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#>   ..$ abb     : chr [1:50] "AL" "AK" "AZ" "AR" ...
#>   ..$ division: Factor w/ 9 levels "New England",..: 4 9 8 5 9 8 1 3 3 3 ...
#>   ..$ region  : Factor w/ 4 levels "Northeast","South",..: 2 4 4 2 4 4 1 2 2 2 ...
#>  $ arrests    :'data.frame': 50 obs. of  1 variable:
#>   ..$ Murder: num [1:50] 13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
#>  - attr(*, "class")= chr [1:2] "chain" "list"
```

``` r
usa %>% 
  select_links(starts_with("state")) %>% 
  str()
#> List of 2
#>  $ state_stats:'data.frame': 50 obs. of  8 variables:
#>   ..$ Population: num [1:50] 3615 365 2212 2110 21198 ...
#>   ..$ Income    : num [1:50] 3624 6315 4530 3378 5114 ...
#>   ..$ Illiteracy: num [1:50] 2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
#>   ..$ Life Exp  : num [1:50] 69 69.3 70.5 70.7 71.7 ...
#>   ..$ Murder    : num [1:50] 15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
#>   ..$ HS Grad   : num [1:50] 41.3 66.7 58.1 39.9 62.6 63.9 56 54.6 52.6 40.6 ...
#>   ..$ Frost     : num [1:50] 20 152 15 65 20 166 139 103 11 60 ...
#>   ..$ Area      : num [1:50] 50708 566432 113417 51945 156361 ...
#>  $ state_info :'data.frame': 50 obs. of  4 variables:
#>   ..$ name    : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
#>   ..$ abb     : chr [1:50] "AL" "AK" "AZ" "AR" ...
#>   ..$ division: Factor w/ 9 levels "New England",..: 4 9 8 5 9 8 1 3 3 3 ...
#>   ..$ region  : Factor w/ 4 levels "Northeast","South",..: 2 4 4 2 4 4 1 2 2 2 ...
```

Technically chain can hold objects that are not data frames. A tiny
difference to just using `list` is that it evaluates sequentially so you
can refer to an element in the list defined in previous lines.

``` r
library(rsample)
library(tidytuesdayR)
set.seed(1)
coffee <- chain(
  data = tt_load(2020, week = 28)$coffee,
  split = initial_split(data, prop = 0.8),
  train = training(split),
  test = testing(split),
  folds = vfold_cv(train, v = 5)
)
#> 
#>  Downloading file 1 of 1: `coffee_ratings.csv`
```

## Other related works

The approach in `chainr` is a really simple way of dealing with
in-memory relational database. Alternatively, you can create a mock SQL
database and work with it using `dbplyr`.

A chain is a simple list. A more general list manipulation can be found
in `rlist`.
