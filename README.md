
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
vs_info <- data.frame(engine = c(0, 1), info = c("flat", "unknown"))
cl <- chain(original = mtcars,
            vs_dict = data.frame(vs = c(0, 1), engine = c("V-shaped", "Straight")),
            vs_info = link(vs_info, original, .by = c(vs = "engine")))

cl
#> $original
#>                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
#> 
#> $vs_dict
#>   vs   engine
#> 1  0 V-shaped
#> 2  1 Straight
#> 
#> $vs_info
#>   engine    info
#> 1      0    flat
#> 2      1 unknown
#> 
#> attr(,"class")
#> [1] "chain" "list"
```

Then you can apply some familiar `dplyr` verbs, however you have an
additional argument to supply to reference which data frame.

``` r
library(dplyr)
cl %>% 
  select(starts_with("vs")) # select all data frame starting with "vs"
#> $vs_dict
#>   vs   engine
#> 1  0 V-shaped
#> 2  1 Straight
#> 
#> $vs_info
#>   engine    info
#> 1      0    flat
#> 2      1 unknown

cl %>% 
  select(c(original, vs_dict), vs)
#> $original
#>                     vs
#> Mazda RX4            0
#> Mazda RX4 Wag        0
#> Datsun 710           1
#> Hornet 4 Drive       1
#> Hornet Sportabout    0
#> Valiant              1
#> Duster 360           0
#> Merc 240D            1
#> Merc 230             1
#> Merc 280             1
#> Merc 280C            1
#> Merc 450SE           0
#> Merc 450SL           0
#> Merc 450SLC          0
#> Cadillac Fleetwood   0
#> Lincoln Continental  0
#> Chrysler Imperial    0
#> Fiat 128             1
#> Honda Civic          1
#> Toyota Corolla       1
#> Toyota Corona        1
#> Dodge Challenger     0
#> AMC Javelin          0
#> Camaro Z28           0
#> Pontiac Firebird     0
#> Fiat X1-9            1
#> Porsche 914-2        0
#> Lotus Europa         1
#> Ford Pantera L       0
#> Ferrari Dino         0
#> Maserati Bora        0
#> Volvo 142E           1
#> 
#> $vs_dict
#>   vs
#> 1  0
#> 2  1
```
