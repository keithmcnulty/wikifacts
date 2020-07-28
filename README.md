
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

An R package which gets facts and data from Wikipedia and Wikibase.

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

  - `wiki_query()` sends SPARQL queries to the Wikibase retrieves
    results in a dataframe.
  - `wiki_didyouknow()` generates random ‘did you know’ facts from
    Wikipedia main page
  - `wiki_inthenews()` generates srandom ‘in the news’ facts from
    Wikipedia main page
  - `wiki_onthisday()` generates random ‘on this day’ facts from
    Wikipedia main page
  - `wiki_randomfact()` generates random facts from Wikipedia main page
  - `wiki_search()` launches browser with Wikipedia search results

## Examples - Query the Wikibase

You can send SPARQL queries to Wikibase using `wiki_query()` and
retrieve the results in a dataframe. If you have never queried Wikibase
before, [here](https://query.wikidata.org/) is a good starting point to
construct SPARQL queries and you can find lots of examples
[here](https://www.wikidata.org/wiki/Wikidata:SPARQL_query_service/queries/examples).

In this example, a bar chart is created to show the top ten countries
according to the number of cities with female mayors, according to data
in Wikibase:

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
       caption = paste("Based on Wikipedia Data as of", format(Sys.Date(), "%d %B %Y")))
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

Or, a more darker topic, the top twenty countries by number of serial
killers born there:

``` r
serial_killers <- 'SELECT ?countryLabel (COUNT(?human) AS ?count) WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  ?human wdt:P106 wd:Q484188. # occupation serial killer
  ?human wdt:P19 ?place_of_birth. # place of birth
  ?place_of_birth wdt:P17 ?country . # in country
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
       caption = paste("Based on Wikipedia Data as of", format(Sys.Date(), "%d %B %Y")))
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />

## Examples - Retrieving facts from Wikipedia Main Pages

``` r
cat(wiki_didyouknow())
#> Did you know that the Sunrise Ruby is the world's most expensive ruby, most expensive coloured gemstone, and most expensive gemstone other than a diamond? (Courtesy of Wikipedia)
```

``` r
cat(wiki_randomfact())
#> Did you know that on June 26 in 1918 – World War I: The 26-day Battle of Belleau Wood near the Marne River in France ended with American forces finally clearing that forest of German troops. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Did you know that on January 16 in 1938 – Benny Goodman (pictured) performed a concert at New York City's Carnegie Hall which has been considered instrumental in establishing jazz as a legitimate form of music. (Courtesy of Wikipedia) 
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
#>  [1] "... that the 2017–18 Thai temple fraud investigations, which led to the imprisonment of high-ranking Buddhist monks, were seen by critics as being politically motivated?"                           
#>  [2] "... that the UK's Violet Friend anti-ballistic missile system was designed to use Bloodhound anti-aircraft missiles (example pictured) and radars to lower its cost?"                                
#>  [3] "... that Philip Hugh-Jones coined the term type J diabetes, where J stands for Jamaica?"                                                                                                             
#>  [4] "... that though in a romantic relationship since the 1990s, the titular characters of the 2018 X-Men miniseries Rogue & Gambit had never previously headlined a comic book together?"                
#>  [5] "1965 – The \"glasnost meeting\" took place in Moscow, becoming the first demonstration in the Soviet Union after World War II and marking the beginning of the civil rights movement in the country."
#>  [6] "1888 – The body of Mary Ann Nichols was found in Buck's Row, London, allegedly the first victim of the unidentified serial killer known as Jack the Ripper."                                         
#>  [7] "... that the law center at Willamette University is named in honor of Oregon businessman and philanthropist Truman W. Collins?"                                                                      
#>  [8] "1346 – King David II of Scotland, under the terms of the Auld Alliance with France, led an invasion of England during the Hundred Years' War, but was captured in the Battle of Neville's Cross."    
#>  [9] "... that American Jewish cuisine has been influenced by a geographical gefilte fish line?"                                                                                                           
#> [10] "... that tenor Thomas Mohr, who has sung the roles of Loge, Siegmund, and Siegfried in Der Ring in Minden, hosts concerts in his cowshed?"
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
