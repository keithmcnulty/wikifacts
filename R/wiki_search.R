#' Display results of a Wikipedia search in the browser
#'
#' @description
#' `wiki_search()` displays the results of a Wikipedia search in the browser.
#'
#' @param term A non-empty character string giving the name of the term to be searched
#' @param browser A non-empty character string passed to [browseURL()] to determine the browser used.
#'
#' @return A display of the results of the search in the browser.
#'
#' @examples
#' wiki_search('R (programming language)')

wiki_search <- function(term = NULL, browser = getOption("browser")) {
  url <- paste0("https://en.wikipedia.org/wiki/", term)
  browseURL(url, browser = browser)
}
