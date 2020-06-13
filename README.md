
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
  - `wiki_search()` launches browser with Wikipedia search results

## Examples

``` r
wiki_didyouknow() %>% cat()
#> Did you know that Blackrocks Brewery was created by two unemployed pharmaceutical salesmen? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact() %>% cat()
#> Here's some news from 05 May 2019. An earthquake in Luzon, the Philippines, kills at least 18 people. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Here's some news from 02 November 2017. In New York City, a ramming attack (vehicle pictured) kills eight people and injures at least eleven others. (Courtesy of Wikipedia) 
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
#>  [1] "The wreck of Argentinian submarine San Juan, which disappeared in November 2017, is found in the South Atlantic."                                                                                           
#>  [2] "1842 – American Indian Wars: American general William J. Worth declared the Second Seminole War to be over."                                                                                                
#>  [3] "... that Kavya Manyapu led the development of a dust-repelling fabric for space suits using carbon nanotubes?"                                                                                              
#>  [4] "Cyberattacks on Ukraine spread a new variant of the Petya malware (ransom note pictured) around the world and cause severe disruptions."                                                                    
#>  [5] "... that Green Bay Packers defensive tackle Dave Roller, who weighed 270 pounds (120 kg) at the time, was carried off Lambeau Field by fans after a victory against the Detroit Lions?"                     
#>  [6] "... that Elad Chakrina initially won Mayotte's 1st constituency by 12 votes, lost by 54 votes after a counting error was corrected, then forced a by-election after an appeal?"                             
#>  [7] "... that director and screenwriter Travis Stevens paused renovations on his house to film Girl on the Third Floor?"                                                                                         
#>  [8] "1952 – The Congress of Guatemala passed Decree 900, redistributing unused lands of sizes greater than 224 acres (0.9 km2) to local peasants and having a major effect on the nation's land reform movement."
#>  [9] "... that Prisoners of the Sun—​the fourteenth volume of The Adventures of Tintin—​was made into a musical in 2001?"                                                                                           
#> [10] "... that the 2018 teen drama Skate Kitchen was partly filmed with a camera mounted on a motorized skateboard deck traveling at speeds of up to 20 miles per hour (32 km/h)?"
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
