
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
#> Did you know that Peter Moore announced Grand Theft Auto IV by rolling up his sleeve to reveal a tattoo of the logo? (Courtesy of Wikipedia on 02 January 2015)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact("2015-01-02"))
#> 
#>  -------------- 
#> Did you know that on January 2 in 1981 – English serial killer Peter Sutcliffe, the "Yorkshire Ripper", was arrested in Sheffield, ending one of the largest police investigations in British history. (Courtesy of Wikipedia) 
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
#>  1 2015-01-01 Here was some news on 01 January 2015. Italian ferry Norman Atlan…
#>  2 2015-01-02 Did you know that the success of the U.S. Auto Defense Choc was b…
#>  3 2015-01-03 Did you know that on January 3 in 1848 – Joseph Jenkins Roberts (…
#>  4 2015-01-04 Did you know that the Armenian liberal daily Aravot was prevented…
#>  5 2015-01-05 Did you know that on January 5 in 1919 – The German Workers' Part…
#>  6 2015-01-06 Here was some news on 06 January 2015. A militant attack on triba…
#>  7 2015-01-07 Did you know that despite being located beside the Ghent ring roa…
#>  8 2015-01-08 Did you know that on January 8 in 1920 – The steel strike of 1919…
#>  9 2015-01-09 Here was some news on 09 January 2015. Archaeologists announce th…
#> 10 2015-01-10 Did you know that on January 10 in 2004 – Helge Fossmo, the villa…
#> 11 2015-01-11 Did you know that on January 11 in 1693 – An intensity XI earthqu…
#> 12 2015-01-12 Here was some news on 12 January 2015. Maithripala Sirisena is el…
#> 13 2015-01-13 Here was some news on 13 January 2015. Archaeologists announce th…
#> 14 2015-01-14 Did you know that the Gibraltar Range waratah (pictured) was only…
```
