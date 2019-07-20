#' Generate random 'did you know' fact
#'
#' @return A message with a random 'did you know' fact from Wikipedia's main page


wiki_didyouknow <- function() {

  # get url from input and read html
  input <- "https://en.wikipedia.org/wiki/Main_Page"
  wiki_page <- xml2::read_html(input, fill = TRUE)

  # scrape data from any sortable table
  dyk <- wiki_page %>%
    rvest::html_nodes(xpath = '//*[@id="mp-dyk"]') %>%
    rvest::html_nodes("li") %>%
    rvest::html_text()

  dyk <- dyk[grepl("... that", dyk)] %>%
    sample(1)



  paste("Did you know", gsub("\\.\\.\\. ", "", dyk), "(Courtesy of Wikipedia)") %>%
    message()

}



