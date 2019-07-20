#' Generate random 'on this day' fact
#'
#' @return A message with a random 'on this day' fact from Wikipedia's main page

wiki_onthisday <- function() {

  # get url from input and read html
  input <- "https://en.wikipedia.org/wiki/Main_Page"
  wiki_page <- xml2::read_html(input, fill = TRUE)

  # scrape data from any sortable table
  otd <- wiki_page %>%
    rvest::html_nodes(xpath = '//*[@id="mp-otd"]') %>%
    rvest::html_nodes("li") %>%
    rvest::html_text()

  otd <- otd[grepl("^\\d{4}", otd)] %>%
    sample(1)



  paste("Did you know that on this day in", otd, "(Courtesy of Wikipedia)") %>%
    message()

}
