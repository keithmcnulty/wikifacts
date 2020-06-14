
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
cat(wiki_didyouknow())
#> Did you know that Fannie Flagg set her 2010 comedy-mystery novel I Still Dream About You in Birmingham, Alabama, because she wanted "to write a Valentine to my hometown"? (Courtesy of Wikipedia)
```

``` r
cat(wiki_randomfact())
#> Here's some news from 24 October 2019. In Santiago, Chile, protests over increased metro fares cause President Sebastián Piñera to declare a state of emergency. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Did you know that on July 10 in 1973 – John Paul Getty III, grandson of American oil magnate J. Paul Getty, was kidnapped in Rome. (Courtesy of Wikipedia) 
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
#>  [1] "French police free hostages from two buildings following a shooting at the headquarters of satirical magazine Charlie Hebdo in Paris."                                                                         
#>  [2] "An explosion at Saint Mark's Coptic Orthodox Cathedral (pictured) in Cairo, Egypt, kills at least 25 people and injures many others."                                                                          
#>  [3] "... that the conductor Michael Hofstetter has performed and recorded rarely played operas at the Ludwigsburg Festival, including Salieri's Les Danaïdes?"                                                      
#>  [4] "Typhoon Lekima (satellite image shown) impacts the Philippines, the Ryukyu Islands, Taiwan and East China, killing at least 80 people."                                                                        
#>  [5] "A suicide bombing after an Ariana Grande concert at the Manchester Arena in the United Kingdom kills 22 people and injures more than 100 others."                                                              
#>  [6] "... that the Gateway Center shopping mall in Brooklyn, New York, is built on a former landfill?"                                                                                                               
#>  [7] "1976 – The Teton Dam in eastern Idaho, US, collapsed as its reservoir was being filled for the first time, resulting in the deaths of eleven people and 13,000 cattle, and causing up to $2 billion in damage."
#>  [8] "China and Pakistan announce the China–Pakistan Economic Corridor, a $46 billion project to connect Gwadar Port in Pakistan to Xinjiang in China."                                                              
#>  [9] "In eSports, The International Dota 2 championships conclude with Wings Gaming defeating Digital Chaos in the final."                                                                                           
#> [10] "The Cricket World Cup concludes with England defeating New Zealand in the final."
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
