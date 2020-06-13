
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts <img src="wikifacts.png" align="right" width="200"/>

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
[![Codecov test
coverage](https://codecov.io/gh/keithmcnulty/wikifacts/branch/master/graph/badge.svg)](https://codecov.io/gh/keithmcnulty/wikifacts?branch=master)
<!-- badges: end -->

R package which generates random facts from historic Wikipedia main
pages.

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

  - `wiki_didyouknow()` generates random ‘did you know’ facts from
    Wikipedia main page
  - `wiki_inthenews()` generates srandom ‘in the news’ facts from
    Wikipedia main page
  - `wiki_onthisday()` generates random ‘on this day’ facts from
    Wikipedia main page
  - `wiki_randomfact()` generates random facts from Wikipedia main page

## Examples

``` r
wiki_didyouknow() %>% cat()
#> Did you know that William G. King Jr. explored and surveyed islands where downrange stations were subsequently established as part of the Eastern Test Range? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact() %>% cat()
#> Did you know that the success of the U.S. Auto Defense Choc was based on prepacked equipment? (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Here's some news from 14 December 2019. In a non-binding referendum, Bougainville votes for independence from Papua New Guinea. (Courtesy of Wikipedia) 
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

Generate multiple random facts:

``` r
wiki_randomfact(n_facts = 10, bare_fact = TRUE)
#>  [1] "... that around the turn of the 20th century, New Jersey amber was burned for heat in the winter?"                                                                                                                     
#>  [2] "Yvonne Farrell and Shelley McNamara win the Pritzker Architecture Prize."                                                                                                                                              
#>  [3] "... that although its discoverer committed suicide after it was declared a forgery in 1883, the Shapira Scroll may be a Dead Sea Scroll after all?"                                                                    
#>  [4] "1941 – Adolf Hitler ordered the suspension of the T4 euthanasia program of the mentally ill and disabled, although killings continued in secret for the remainder of the war."                                         
#>  [5] "... that David A. Cooper diagnosed the first case of HIV in Australia?"                                                                                                                                                
#>  [6] "... that the fossil elm Ulmus okanaganensis had been tentatively identified as two other plants before it was formally described in 2005?"                                                                             
#>  [7] "The Airlander 10 hybrid airship – the largest aircraft flying today – completes its maiden civilian voyage."                                                                                                           
#>  [8] "An earthquake in Luzon, the Philippines, kills at least 16 people."                                                                                                                                                    
#>  [9] "In Canadian football, the Ottawa Redblacks defeat the Calgary Stampeders to win the Grey Cup."                                                                                                                         
#> [10] "1927 – Louis B. Mayer, head of Metro-Goldwyn-Mayer invited 36 people involved in the film industry to a banquet, where he announced the creation of what would become the Academy of Motion Picture Arts and Sciences."
```
