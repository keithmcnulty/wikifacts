#' Generate random 'on this day' fact from current or historic Wikipedia main page
#'
#' @description
#' `wiki_onthisday()` generates a random 'on this day' fact from a current or historic Wikipedia main page
#'
#' @param date A date string of the form YYYY-MM-DD.  Default value is today's date.
#' @return A string with a random 'on this day' fact from Wikipedia's main page if it exists for the date specified - otherwise "I got nothin'"
#'
#' @examples
#' wiki_onthisday(date = '2020-05-02')

wiki_onthisday <- function(date = Sys.Date()) {

  # get url from input and read html
  # get url from input and read html
  date <- as.Date(date)
  date1 <- format(date, "%Y_%B_")
  date2 <- gsub("^0+", "", format(date, "%d"))
  date_str <- paste0(date1, date2)

  input <- paste0("https://en.wikipedia.org/wiki/Wikipedia:Main_Page_history/", date_str)

  tryCatch({
    input <- url(input, 'rb')
    wiki_page <- xml2::read_html(input, fill = TRUE)
    close(input)

    # scrape list data
    otd <- wiki_page %>%
      rvest::html_nodes(xpath = '//*[@id="mp-otd"]') %>%
      rvest::html_nodes("li") %>%
      rvest::html_text()

    otd <- otd[grepl("^\\d{4}", otd)] %>%
      sample(1)

    if (date == Sys.Date()) {
      paste("Did you know that on this day in", otd, "(Courtesy of Wikipedia)")
    } else {
      paste0("Did you know that on ", format(date, "%B"), " ", date2, " in ", otd, " (Courtesy of Wikipedia)")
    }
  },
  error = function (e) {"I got nothin'"},
  warning = function (w) {"I got nothin'"})

}
