
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wikifacts <img src="wikifacts.png" align="right" width="200"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
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

-   `wiki_query()` sends SPARQL queries to Wikidata and retrieves
    results in a dataframe.
-   `wiki_define()` generates a short definition of the given terms as
    an extract from Wikipedia article.
-   `wiki_didyouknow()` generates random ‘did you know’ facts from
    Wikipedia main page.
-   `wiki_inthenews()` generates random ‘in the news’ facts from
    Wikipedia main page.
-   `wiki_onthisday()` generates random ‘on this day’ facts from
    Wikipedia main page.
-   `wiki_randomfact()` generates random facts from Wikipedia main page.
-   `wiki_define()` obtains definitions of terms from Wikipedia.
-   `wiki_search()` launches browser with Wikipedia search results.

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

## Examples - Getting definitions of terms from Wikipedia

``` r
# Create animals dataframe
animals <- data.frame(
  name = c("kangaroo", "kookaburra", "wombat", "tasmanian devil", "quokka")
)

# get definitions from wikipedia
knitr::kable(
  animals %>% 
    dplyr::mutate(definition = wiki_define(name, sentence = 1))
)
```

| name            | definition                                                                                                                                                                                       |
|:----------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| kangaroo        | The kangaroo is a marsupial from the family Macropodidae (macropods, meaning “large foot”).                                                                                                      |
| kookaburra      | Kookaburras are terrestrial tree kingfishers of the genus Dacelo native to Australia and New Guinea, which grow to between 28 and 42 cm (11 and 17 in) in length and weigh around 300 g (11 oz). |
| wombat          | Wombats are short-legged, muscular quadrupedal marsupials that are native to Australia.                                                                                                          |
| tasmanian devil | The Tasmanian devil (Sarcophilus harrisii) is a carnivorous marsupial of the family Dasyuridae.                                                                                                  |
| quokka          | The quokka, also known as the short-tailed scrub wallaby () (Setonix brachyurus), the only member of the genus Setonix, is a small macropod about the size of a domestic cat.                    |

## Examples - Retrieving facts from Wikipedia Main Pages

``` r
cat(wiki_didyouknow())
#> Did you know that in 2007, the Pennsylvania Supreme Court ruled that a sperm donor was not obligated to pay child support? (Courtesy of Wikipedia)
```

``` r
cat(wiki_randomfact())
#> Here's some news from 29 September 2016. Nobel Peace Prize-winning former Israeli President and Prime Minister Shimon Peres (pictured) dies at the age of 93. (Courtesy of Wikipedia)
```

Use with `cowsay`:

``` r
cowsay::say(wiki_randomfact())
#> 
#>  -------------- 
#> Did you know that a DV4 electric dustcart (example pictured) continued to run after being hit by a bomb during the Second World War? (Courtesy of Wikipedia) 
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
#>  [1] "1398 – The Grand Duke of Lithuania Vytautas the Great and the Grand Master of the Teutonic Knights Konrad von Jungingen signed the Treaty of Salynas, the third attempt to cede Samogitia to the Knights."
#>  [2] "... that Cabilao Island is the location of the only natural lake in the Philippine province of Bohol?"                                                                                                    
#>  [3] "... that the horseshoe shrimp Hutchinsoniella macracantha is the first example of a new class of crustaceans that was given the name Cephalocarida?"                                                      
#>  [4] "Ngozi Okonjo-Iweala becomes the first woman and the first African to be appointed Director-General of the World Trade Organization."                                                                      
#>  [5] "A shooting at a gay nightclub in Orlando, Florida, kills 49 people."                                                                                                                                      
#>  [6] "1840 – Prince Albert (pictured) of Saxe-Coburg and Gotha married Queen Victoria at the Chapel Royal in St James's Palace, London, becoming prince consort."                                               
#>  [7] "1849 – Abraham Lincoln was issued a patent for an invention to lift boats over obstacles in a river, making him the only U.S. President to ever hold a patent."                                           
#>  [8] "... that in 1920, Irvin S. Cobb, a writer for The Saturday Evening Post, organized a hunting trip to Oregon looking for a lava bear specimen?"                                                            
#>  [9] "... that linguist Esther T. Mookini translated many works of 19th-century native Hawaiians, including the 1838 Anatomia, the only medical textbook written in the Hawaiian language?"                     
#> [10] "1770 – British soldiers fired into a crowd in Boston, Massachusetts, killing five civilians."
```

Search Wikipedia (launches browser with results):

``` r
wiki_search('R (programming language)')
```
