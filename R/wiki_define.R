#' Define a term from Wikipedia
#'
#' @description
#' `wiki_define()` displays plaintext extract(s) of the given term(s) from
#'' the Wikipedia article(s).
#'
#' @param term A non-empty character string or vector giving the name(s) of the term to be searched
#' @param sentences An integer (or whole number) giving the number of sentences to return
#'
#' @return An extract from the Wikipedia article
#'
#' @examples
#' wiki_define('R (programming language)')
#'
#' animals <- data.frame(name = c("dog", "cat"))
#' animals$definition <- wiki_define(animals$name, sentences = 1)
#' print(animals)

wiki_define <- function(term = NULL, sentences = 5L) {
  if (!is.numeric(sentences)) {
	sentences <- 10L
	warning("'sentences' at wiki_define() should be an integerm falling back to 10L")
  }
  sentences <- trunc(sentences)
  tryCatch({
    sapply(term, function(x){
      response <- xml2::read_xml(paste0("https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exsentences=",
        sentences,
        "&exlimit=1&titles=",
        utils::URLencode(x),
        "&explaintext=1&format=xml"))
      xml2::xml_text(xml2::xml_find_first(response, "query/pages/page/extract"))
    })
  },
  error = function (e) {"I got nothin'"},
  warning = function (w) {"I got nothin'"})
}
