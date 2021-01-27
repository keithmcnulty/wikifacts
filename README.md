
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

An R package which gets facts and data from Wikipedia and Wikidata.

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

  - `wiki_query()` sends SPARQL queries to Wikidata and retrieves
    results in a dataframe.
  - `wiki_define()` generates a short definition of the given terms
    as an extract from Wikipedia article.
  - `wiki_didyouknow()` generates random ‘did you know’ facts from
    Wikipedia main page.
  - `wiki_inthenews()` generates random ‘in the news’ facts from
    Wikipedia main page.
  - `wiki_onthisday()` generates random ‘on this day’ facts from
    Wikipedia main page.
  - `wiki_randomfact()` generates random facts from Wikipedia main page.
  - `wiki_search()` launches browser with Wikipedia search results.

## Examples - Query Wikidata

You can send SPARQL queries to Wikidata using `wiki_query()` and
retrieve the results in a dataframe. If you have never queried Wikidata
before, [here](https://query.wikidata.org/) is a good starting point to
construct SPARQL queries and you can find lots of examples
[here](https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples).

In this example, a bar chart is created to show the top ten countries
according to the number of cities with female mayors, according to data
in Wikidata:

``` r
library(wikifacts)
library(ggplot2)

mayor_query <- 'SELECT ?countryLabel (count(*) AS ?count)
WHERE
{
    ?city wdt:P31/wdt:P279* wd:Q515 . # find instances of subclasses of city
    ?city p:P6 ?statement .           # with a P6 (head of goverment) statement
    ?statement ps:P6 ?mayor .         # ... that has the value ?mayor
    ?mayor wdt:P21 wd:Q6581072 .      # ... where the ?mayor has P21 (sex or gender) female
    FILTER NOT EXISTS { ?statement pq:P582 ?x }  # ... but the statement has no P582 (end date) qualifier
    ?city wdt:P17 ?country .          # Also find the country of the city
    
    # If available, get the "ru" label of the country, use "en" as fallback:
    SERVICE wikibase:label {
        bd:serviceParam wikibase:language "en" .
    }
}
GROUP BY ?countryLabel
ORDER BY DESC(?count)
LIMIT 10'

mayors <- wiki_query(mayor_query)

ggplot(mayors, aes(x = count, y = reorder(countryLabel, count))) +
  geom_bar(stat = "identity", fill = "lightblue") +
  labs(x = "Cities with female mayors",
       y = "",
       title = "Top Ten Countries Based on Number Female Mayors",
       caption = paste("Based on Wikidata as of", format(Sys.Date(), "%d %B %Y")))
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Or, a more dark topic, the top twenty countries by number of serial
killers born there:

``` r
serial_killers <- 'SELECT ?countryLabel (COUNT(?human) AS ?count) WHERE { 
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  ?human wdt:P106 wd:Q484188. # occupation: serial killer
  ?human wdt:P19 ?place_of_birth. # get place of birth
  ?place_of_birth wdt:P17 ?country . # map to country
}
GROUP BY ?countryLabel
ORDER BY DESC(?count)
LIMIT 20'



serialkillers <- wiki_query(serial_killers)

ggplot(serialkillers, aes(x = count, y = reorder(countryLabel, count))) +
  geom_bar(stat = "identity", fill = "darkred") +
  labs(x = "Number of Serial Killers",
       y = "",
       title = "Top 20 Countries Based on Serial Killers Born There",
       caption = paste("Based on Wikidata as of", format(Sys.Date(), "%d %B %Y")))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

## Examples - Retrieving facts from Wikipedia Main Pages

``` r
cat(wiki_didyouknow())
#> Did you know that after Catholic bishop Gaston Marie Jacquier was assassinated in Algiers, Archbishop Duval ordered priests not to wear clerical clothing or display the cross in public? (Courtesy of Wikipedia)
```

``` r
cat(wiki_randomfact())
#> Did you know that on January 10 in 1985 – Sir Clive Sinclair launched the Sinclair C5 personal electric vehicle, "one of the great marketing bombs of postwar British industry", which later became a cult collector's item. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Here's some news from 02 August 2019. Incumbent President of Tunisia Beji Caid Essebsi dies at the age of 92, and Mohamed Ennaceur is named as his interim replacement. (Courtesy of Wikipedia) 
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
#>  [1] "Mikhail Mishustin (pictured) is appointed Prime Minister of Russia following the resignation of Dmitry Medvedev and his cabinet."                               
#>  [2] "2008 – Georgia launched a large-scale military offensive against the separatist region of South Ossetia, opening the six-day Russo-Georgian War."               
#>  [3] "A total solar eclipse (pictured) crosses the contiguous United States for the first time since 1918."                                                           
#>  [4] "... that at the age of 17, Esther Arditi saved a pilot and a navigator from a burning plane?"                                                                   
#>  [5] "2009 – US Airways Flight 1549 struck a flock of Canada geese during its initial climb out from New York City and made an emergency landing in the Hudson River."
#>  [6] "... that the Dutch letter is traditionally eaten in the Netherlands on Christmas Eve?"                                                                          
#>  [7] "More than 70 people are killed in a suicide bombing and shooting in Quetta, Pakistan."                                                                          
#>  [8] "Jair Bolsonaro (pictured) is elected President of Brazil."                                                                                                      
#>  [9] "... that video game MeiQ: Labyrinth of Death features characters paired with robotic Guardians?"                                                                
#> [10] "1862 – American Civil War: The Battle of Perryville, one of the bloodiest battles of the war, was fought in the Chaplin Hills west of Perryville, Kentucky."
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
