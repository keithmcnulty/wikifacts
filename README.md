
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/keithmcnulty/wikifacts/workflows/R-CMD-check/badge.svg)](https://github.com/keithmcnulty/wikifacts/actions)
[![Total
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/wikifacts?color=green)](https://cran.r-project.org/package=wikifacts)
[![CRAN
status](https://www.r-pkg.org/badges/version/wikifacts)](https://CRAN.R-project.org/package=wikifacts)
[![Travis build
status](https://travis-ci.com/keithmcnulty/wikifacts.svg?branch=master)](https://travis-ci.com/keithmcnulty/wikifacts)
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
#> Did you know that investigative journalist Jessica Lussenhop has written articles on corruption in the standardized-testing industry, and the murders and disappearances of Indigenous women? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact("2015-01-02") %>% cat()
#> Did you know that on January 2 in 1971 – At Ibrox Park in Glasgow, Scotland, 66 people were killed in a stampede during an Old Firm football match. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact("2015-01-02"))
#> 
#>  -------------- 
#> Did you know that Peter Moore announced Grand Theft Auto IV by rolling up his sleeve to reveal a tattoo of the logo? (Courtesy of Wikipedia on 02 January 2015) 
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
#>  1 2015-01-01 "Did you know that when Bruckner's Pange lingua was published in …
#>  2 2015-01-02 "Did you know that Jean-Claude Van Damme is returning in the rema…
#>  3 2015-01-03 "Did you know that the ring-tailed ground squirrel is more dainty…
#>  4 2015-01-04 "Did you know that the Armenian liberal daily Aravot was prevente…
#>  5 2015-01-05 "Here was some news on 05 January 2015. Italian ferry Norman Atla…
#>  6 2015-01-06 "Here was some news on 06 January 2015. At least 36 people are ki…
#>  7 2015-01-07 "Did you know that the Egyptian pharaoh Seti II was buried in tom…
#>  8 2015-01-08 "Here was some news on 08 January 2015. Angola, Malaysia, New Zea…
#>  9 2015-01-09 "Here was some news on 09 January 2015. At least 36 people are ki…
#> 10 2015-01-10 "Did you know that Independence Blue Cross CEO Daniel J. Hilferty…
#> 11 2015-01-11 "Here was some news on 11 January 2015. French police free hostag…
#> 12 2015-01-12 "Did you know that painter Theora Hamblett was one of the first M…
#> 13 2015-01-13 "Did you know that approximately 28,000 topographic names were ch…
#> 14 2015-01-14 "Did you know that on January 14 in 1301 – The Árpád dynasty, whi…
```
