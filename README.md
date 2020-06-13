
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
[![Codecov test
coverage](https://codecov.io/gh/keithmcnulty/wikifacts/branch/master/graph/badge.svg)](https://codecov.io/gh/keithmcnulty/wikifacts?branch=master)
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
#> Did you know that Blackrocks Brewery was created by two unemployed pharmaceutical salesmen? (Courtesy of Wikipedia)
```

``` r
wiki_randomfact() %>% cat()
#> Did you know that the 12th-century Eadwine Psalter has a famous portrait of Eadwine, "prince of scribes" (pictured), and illustrations to the psalms copied from a book then over 300 years old? (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Here's some news from 04 December 2016. Magnus Carlsen defeats Sergey Karjakin to retain the World Chess Championship title. (Courtesy of Wikipedia) 
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
#>  [1] "... that facing the rise of Nazi ideology, Otto Riethmüller compiled the song \"Sonne der Gerechtigkeit\" for young people from hymns by three authors of two earlier centuries?"                                                        
#>  [2] "1981 – English serial killer Peter Sutcliffe, the \"Yorkshire Ripper\", was arrested in Sheffield, ending one of the largest police investigations in British history."                                                                  
#>  [3] "... that Hancock Bridge in Mumbai, built in 1879 and rebuilt in 1923, was demolished in 2016 to be rebuilt again?"                                                                                                                       
#>  [4] "... that Jamaica High School (pictured), once Queens' largest public high school with 4,613 students, closed in 2014 with a graduating class of only 24 students?"                                                                       
#>  [5] "1947 – A commission led by Cyril Radcliffe established the Radcliffe Line, the border between India and Pakistan after the Partition of India."                                                                                          
#>  [6] "1917 – Being unable to resolve disputes with Eddie Livingstone, owner of the Toronto Blueshirts, the other ice hockey clubs of Canada's National Hockey Association officially agreed to break away and form the National Hockey League."
#>  [7] "1975 – The AH-64 Apache, the primary attack helicopter for a number of countries, made its first flight."                                                                                                                                
#>  [8] "Serzh Sargsyan  resigns as Prime Minister of Armenia, following large-scale protests."                                                                                                                                                   
#>  [9] "1946 – Named after Bikini Atoll, the site of the nuclear weapons test Operation Crossroads in the Marshall Islands, the modern bikini was introduced at a fashion show in Paris."                                                        
#> [10] "Taiwan becomes the first state in Asia to legalize same-sex marriage."
```
