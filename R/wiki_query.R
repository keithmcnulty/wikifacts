#' Send queries to the Wikidata knowledge graph and receive results as dataframe.
#'
#' @description
#' `wiki_query()` sends a SPARQL query to the Wikidata knowledge graph and collects the results in a dataframe.
#'
#' @param qry A character string representing a SPARQL query to be run against the Wikidata knowledge graph.
#' @param raw_results Logical.  If TRUE, the results of the query will not be cleaned to remove escaped quotes and language tags.
#'
#' @return A dataframe of results
#'
#' @examples
#' # List five diseases
#' library(SPARQL)
#' query <- 'SELECT ?item ?itemLabel WHERE {
#'   ?item wdt:P31 wd:Q12136. #instance of disease
#'   SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
#' }
#' LIMIT 5'
#' wiki_query(query)

wiki_query <- function(qry, raw_results = FALSE) {

  endpoint <- "https://query.wikidata.org/sparql"
  useragent <- paste("WDQS", R.version.string)

  qd <- SPARQL::SPARQL(endpoint, qry, curl_args = list(useragent = useragent))
  df <- as.data.frame(qd$results)

  if (!raw_results) {
    df <- df %>%
      dplyr::mutate(dplyr::across(is.character, function(x) gsub('\"', '', x))) %>%
      dplyr::mutate(dplyr::across(is.character, function(x) gsub('@(.*)', '', x)))
  }

  df
}
