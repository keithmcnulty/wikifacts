#' Generate random 'did you know' fact from current or historic Wikipedia main page.
#'
#' @return A string with a random 'did you know' fact from Wikipedia's main page if it exists for the date specified - otherwise "I got nothin'"
#' @param date A date string of the form "%Y-%m-%d".  Default value is today's date.
#'
#' @examples wiki_didyouknow(date = "2020-05-02")


wiki_didyouknow <- function(date = Sys.Date()) {

  # get url from input and read html
  date <- as.Date(date)
  date1 <- format(date, "%Y_%B_")
  date2 <- gsub("^0+", "", format(date, "%d"))
  date_str <- paste0(date1, date2)

  input <- paste0("https://en.wikipedia.org/wiki/Wikipedia:Main_Page_history/", date_str)

  tryCatch({
    input <- url(input, "rb")
    wiki_page <- xml2::read_html(input, fill = TRUE)
    close(input)

    # scrape list data
    dyk <- wiki_page %>%
      rvest::html_nodes(xpath = '//*[@id="mp-dyk"]') %>%
      rvest::html_nodes("li") %>%
      rvest::html_text()

    dyk <- dyk[grepl("... that", dyk)] %>%
      sample(1)

    if (date == Sys.Date()) {
      paste("Did you know", gsub("\\.\\.\\. ", "", dyk), "(Courtesy of Wikipedia)")
    } else {
      paste0("Did you know ", gsub("\\.\\.\\. ", "", dyk), " (Courtesy of Wikipedia on ", format(date, "%d %B %Y"), ")")
    }
  },
  error = function (e) {"I got nothin'"},
  warning = function (w) {"I got nothin'"})

}



