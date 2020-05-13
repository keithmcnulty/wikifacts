#' Generate random news item from current or historic Wikipedia main page.
#'
#' @return A string with a random 'in the news' item from Wikipedia's main page, if it exists for the date specified - otherwise "I got nothin'"
#' @param date A date string of the form "%Y-%m-%d".  Default value is today's date.
#'
#' @examples wiki_inthenews(date = "2020-05-02")

wiki_inthenews <- function(date = Sys.Date()) {

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
    itn <- wiki_page %>%
      rvest::html_nodes(xpath = '//*[@id="mp-itn"]') %>%
      rvest::html_nodes("li") %>%
      rvest::html_text()

    itn <- itn[nchar(itn) > 40] %>%
      sample(1)

    if (date == Sys.Date()) {
      paste("Here's some news.", itn, "(Courtesy of Wikipedia)")
    } else {
      paste0("Here was some news on ", format(date, "%d %B %Y"), ". ", itn, " (Courtesy of Wikipedia)")
    }
  },
  error = function (e) {"I got nothin'"},
  warning = function (w) {"I got nothin'"})

}
