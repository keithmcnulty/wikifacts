
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/keithmcnulty/wikifacts/workflows/R-CMD-check/badge.svg)](https://github.com/keithmcnulty/wikifacts/actions)
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
#> Did you know that the first observed underwater explosive volcanic eruption (example pictured) occurred in 2004 at NW Rota-1? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact("2015-01-02") %>% cat()
#> Here was some news on 02 January 2015. Beji Caid Essebsi wins the Tunisian presidential election. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact("2015-01-02"))
#> 
#>  -------------- 
#> Did you know that on January 2 in 1944 – World War II: The United States and Australia successfully landed 13,000 troops on Papua New Guinea in an attempt to cut off a Japanese retreat. (Courtesy of Wikipedia) 
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
#>  1 2015-01-01 Did you know that construction of the Old Sisters High School (pi…
#>  2 2015-01-02 Did you know that King Bayinnaung of Burma entered into several m…
#>  3 2015-01-03 Here was some news on 03 January 2015. Authorities confirm the di…
#>  4 2015-01-04 Here was some news on 04 January 2015. Authorities confirm the di…
#>  5 2015-01-05 Here was some news on 05 January 2015. At least 83 people are kil…
#>  6 2015-01-06 Here was some news on 06 January 2015. Authorities confirm the di…
#>  7 2015-01-07 Here was some news on 07 January 2015. At least 83 people are kil…
#>  8 2015-01-08 Did you know that on January 8 in 2010 – Gunmen from an offshoot …
#>  9 2015-01-09 Did you know that the sea snail Halystina umberlee (pictured) was…
#> 10 2015-01-10 Did you know that on January 10 in 1929 – The Adventures of Tinti…
#> 11 2015-01-11 Here was some news on 11 January 2015. Lithuania becomes the 19th…
#> 12 2015-01-12 Here was some news on 12 January 2015. French police free hostage…
#> 13 2015-01-13 Here was some news on 13 January 2015. Attacks by Boko Haram on t…
#> 14 2015-01-14 Here was some news on 14 January 2015. More than three million pe…
```
