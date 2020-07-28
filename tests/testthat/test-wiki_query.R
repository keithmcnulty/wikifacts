test_that("wiki_query() returns expected result", {
  library(SPARQL)
  query <- 'SELECT ?item ?itemLabel WHERE {
   ?item wdt:P31 wd:Q12136.
   SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
  }
  LIMIT 5'

  wiki_query(query) %>%
    nrow() %>%
    testthat::expect_equal(5)
})
