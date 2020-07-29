#' Send queries to Wikidata and receive results as dataframe
#'
#' @description
#' `wiki_query()` sends a SPARQL query to Wikidata and collects the results in a dataframe
#'
#' @param qry A character string representing a SPARQL query to be sent to Wikidata
#' @return A dataframe of results
#'
#' @examples
#' # List five diseases
#' query <- 'SELECT ?itemLabel WHERE {
#'   ?item wdt:P31 wd:Q12136. #instance of disease
#'   SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
#' }
#' LIMIT 5'
#' wiki_query(query)

wiki_query <- function(qry) {

  # constants
  LIMIT <- 2048
  WIKIDATA <- "https://query.wikidata.org/sparql"

  # remove unnecessary white characters
  qry <- gsub("[[:blank:]]+", " ", qry)

  # encode the SPARQL query for URL
  qry <- utils::URLencode(qry)
  qry <- gsub("#", "%23", qry)

  # check SPARQL query length
  if (!length(qry)) {
    stop("No SPARQL query provided.")
  } else if (length(qry) > LIMIT) {
    stop(paste("Too long SPARQL query: maximum is", LIMIT, "characters"))
  }

  # get URL response from Wikidata
  spr <- url(
    description = paste0(WIKIDATA, "?query=", qry),
    headers = c("Accept" = "text/csv; charset=utf-8")
  )

  response <- tryCatch(
    utils::read.csv(spr, na.strings = "", encoding="UTF-8"),
    error = function(e) {
      message(e)
      close(spr)
      return(data.frame())
    }
  )

  # check empty response
  if (nrow(response) == 0) {
    return(data.frame())
  }

  # return the full data frame with response
  return(response)
}
