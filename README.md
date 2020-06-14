
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts <img src="wikifacts.png" align="right" width="200"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/wikifacts)](https://CRAN.R-project.org/package=wikifacts)
[![Total
Downloads](http://cranlogs.r-pkg.org/badges/grand-total/wikifacts?color=green)](https://cran.r-project.org/package=wikifacts)
[![R build
status](https://github.com/keithmcnulty/wikifacts/workflows/R-CMD-check/badge.svg)](https://github.com/keithmcnulty/wikifacts/actions)
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
  - `wiki_search()` launches browser with Wikipedia search results

## Examples

``` r
wiki_didyouknow() %>% cat()
#> Did you know that the song "Running", which was set to represent Cyprus in the Eurovision Song Contest 2020, was sung by a German-born singer of Greek and American ancestry? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact() %>% cat()
#> Did you know that on September 20 in 1906 – The ocean liner RMS Mauretania, the largest and fastest ship in the world at the time, was launched. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Did you know that on June 8 in 1953 – Two tornadoes caused by the same storm killed more than 200 people in Flint, Michigan and Worcester, Massachusetts, cities more than 650 miles (1,050 km) apart. (Courtesy of Wikipedia) 
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
#>  [1] "1745 – Bonnie Prince Charlie raised the Jacobite standard at Glenfinnan in the Scottish Highlands to begin the Second Jacobite Rising."                                                               
#>  [2] "1234 – An Englishman lost the Battle of the Curragh in Ireland, at the same place where an Australian would win the 1297 Battle of Stirling Bridge in Scotland."                                      
#>  [3] "1620 – The Mayflower Compact, the first governing document of the Plymouth Colony, was signed by 41 of the Mayflower's passengers while the ship was anchored in what is now Provincetown Harbor."    
#>  [4] "1905 – Despite being blind in one eye, ice hockey player Frank McGee set the record for most goals in a Stanley Cup game when he scored 14 against the Dawson City Nuggets."                          
#>  [5] "In Indonesia, flash floods in and around the capital of Jakarta kill at least 60 people."                                                                                                             
#>  [6] "2005 – Terrorist suicide bombs exploded at two sites in Bali, Indonesia, killing twenty people and injuring over 120 others."                                                                         
#>  [7] "... that Japanese singer Alisa Takigawa's debut song \"Season\" was originally a demo that was not intended to be her debut release?"                                                                 
#>  [8] "... that production on the first season of The House of Flowers was shut down twice—after an earthquake injured one of the leads, and when a store objected to homosexual content being filmed there?"
#>  [9] "... that while his parents wanted him to serve in the church, Albert Methfessel pursued his interest in music, becoming a key figure in German folk and male voice singing in the 19th century?"      
#> [10] "... that Lindsay Peat has represented Ireland internationally at association football, basketball, and rugby union?"
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
