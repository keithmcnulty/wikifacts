
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/keithmcnulty/wikifacts.svg?branch=master)](https://travis-ci.org/keithmcnulty/wikifacts)
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
#> Did you know that Canberra MRT station was designed with a nautical theme to reflect Singapore's historical role as a British naval base? (Courtesy of Wikipedia)
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
#> Did you know that Indian film actor Rajesh Khanna contested the 1996 Gandhinagar parliamentary by-election? (Courtesy of Wikipedia on 02 January 2015) 
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
#>  1 2015-01-01 "Did you know that a 13th-century Armenian monastery dedicated to…
#>  2 2015-01-02 "Did you know that on January 2 in 1981 – English serial killer P…
#>  3 2015-01-03 "Here was some news on 03 January 2015. Lithuania becomes the 19t…
#>  4 2015-01-04 "Here was some news on 04 January 2015. At least 36 people are ki…
#>  5 2015-01-05 "Did you know that Gwalior's Teli ka Mandir (pictured) blends Nag…
#>  6 2015-01-06 "Did you know that on January 6 in 1066 – Harold Godwinson, widel…
#>  7 2015-01-07 "Here was some news on 07 January 2015. Lithuania becomes the 19t…
#>  8 2015-01-08 "Here was some news on 08 January 2015. Archaeologists announce t…
#>  9 2015-01-09 "Did you know that on January 9 in 1972 – Seawise University, for…
#> 10 2015-01-10 "Did you know that Grand Duke Andrei Vladimirovich of Russia marr…
#> 11 2015-01-11 "Did you know that on January 11 in 1946 – Enver Hoxha, First Sec…
#> 12 2015-01-12 "Did you know that on January 12 in 1945 – World War II: The Sovi…
#> 13 2015-01-13 "Did you know that on January 13 in 1815 – War of 1812: British t…
#> 14 2015-01-14 "Did you know that on January 14 in 1900 – Giacomo Puccini's oper…
```
