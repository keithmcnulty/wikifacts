
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/keithmcnulty/wikifacts/workflows/R-CMD-check/badge.svg)](https://github.com/keithmcnulty/wikifacts/actions)
[![Total
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/wikifacts?color=green)](https://cran.r-project.org/package=wikifacts)
<!-- badges: end -->

R package which generates strings containing random facts from current
or historic Wikipedia main pages. Intended for light-hearted support for
scripts or apps that take a long time to execute.

## Installation

You can install the released version of wikifacts from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("wikifacts")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("keithmcnulty/wikifacts")
```

## Functionality

  - `wiki_didyouknow()` generates string with random ‘did you know’ fact
    from Wikipedia main page
  - `wiki_inthenews()` generates string with random ‘in the news’ fact
    from Wikipedia main page
  - `wiki_onthisday()` generates string with random ‘on this day’ fact
    from Wikipedia main page
  - `wiki_randomfact()` generates string with random fact from Wikipedia
    main page (one of the above selected randomly)

## Examples

``` r
wiki_didyouknow() %>% cat()
#> I got nothin'
```

``` r
wiki_randomfact("2015-01-02") %>% cat()
#> Here was some news on 02 January 2015. Authorities confirm the discovery of debris and bodies from Indonesia AirAsia Flight 8501 (aircraft pictured), which crashed en route to Singapore with 162 people on board. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact("2015-01-02"))
#> 
#>  -------------- 
#> Here was some news on 02 January 2015. Italian ferry Norman Atlantic catches fire in the Adriatic Sea with 466 passengers and crew on board, killing at least 11 people. (Courtesy of Wikipedia) 
#>  --------------
#>     \
#>       \
#>         \
#>             |\___/|
#>           ==) ^Y^ (==
#>             \  ^  /
#>              )=*=(
#>             /     \
#>             |     |
#>            /| | | |\
#>            \| | |_|/\
#>       jgs  //_// ___/
#>                \_)
#> 
```

Generate a table of random facts by date (using
`dplyr 1.0.0`):

``` r
date_tbl <- data.frame(date = seq(from = as.Date("2015-01-01"), to = as.Date("2015-01-14"), by = "days"))

date_tbl %>% 
  dplyr::rowwise() %>% 
  dplyr::mutate(fact = wiki_randomfact(date))
#> # A tibble: 14 x 2
#> # Rowwise: 
#>    date       fact                                                              
#>    <date>     <chr>                                                             
#>  1 2015-01-01 "Did you know that Confucius' disciple Qidiao Kai declined to tak…
#>  2 2015-01-02 "Did you know that on January 2 in 2004 – The Stardust space prob…
#>  3 2015-01-03 "Did you know that on January 3 in 1976 – The multilateral Intern…
#>  4 2015-01-04 "Did you know that on January 4 in 2004 – Spirit (artist's impres…
#>  5 2015-01-05 "Did you know that on January 5 in 2008 – Mikheil Saakashvili (pi…
#>  6 2015-01-06 "Here was some news on 06 January 2015. Italian ferry Norman Atla…
#>  7 2015-01-07 "Here was some news on 07 January 2015. At least 36 people are ki…
#>  8 2015-01-08 "Did you know that on January 8 in 2010 – Gunmen from an offshoot…
#>  9 2015-01-09 "Did you know that Campaign Thoan Thang marked both the first use…
#> 10 2015-01-10 "Did you know that estimates of the prevalence of metabolically h…
#> 11 2015-01-11 "Did you know that Daniel Ashelman built a cabin on Ashelman Run …
#> 12 2015-01-12 "Did you know that painter Theora Hamblett was one of the first M…
#> 13 2015-01-13 "Did you know that on January 13 in 1815 – War of 1812: British t…
#> 14 2015-01-14 "Did you know that the Lord's Slope affects cricketers but not ar…
```
