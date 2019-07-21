#' Generate random news item
#'
#' @return A message with a random 'in the news' item from Wikipedia's main page

wiki_inthenews <- function() {

  # get url from input and read html
  input <- "https://en.wikipedia.org/wiki/Main_Page"
  wiki_page <- xml2::read_html(input, fill = TRUE)

  # scrape list data
  itn <- wiki_page %>%
    rvest::html_nodes(xpath = '//*[@id="mp-itn"]') %>%
    rvest::html_nodes("li") %>%
    rvest::html_text()

  itn <- itn[nchar(itn) > 40] %>%
    sample(1)

  paste("Here's some news.", itn, "(Courtesy of Wikipedia)") %>%
    message()

}
