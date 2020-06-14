#' Generate 'on this day' facts from the Wikipedia main page on a specified date.
#'
#' @description
#' `wiki_onthisday()` generates 'on this day' facts from the Wikipedia main page on a specified date.
#'
#' @param n_facts An integer determining the number of facts that will be generated, up to a limit of the maximum facts for the date specified.
#' @param date A date string of the form YYYY-MM-DD.  Default value is yesterday's date.
#' @param bare_fact Logical.  Determining whether the fact should be quoted as is or surrounded by a preamble and courtesy statement.
#'
#' @return A vector of strings with random 'on this day' facts from Wikipedia's main page if it exists for the date specified - otherwise "I got nothin'"
#'
#' @examples
#' wiki_onthisday(date = '2020-05-02')

wiki_onthisday <- function(n_facts = 1L, date = Sys.Date() - 1, bare_fact = FALSE) {

  locale <- Sys.getlocale("LC_TIME")

  if (.Platform$OS.type == "windows") {
    invisible(Sys.setlocale("LC_TIME", "English"))
  } else {
    invisible(Sys.setlocale("LC_TIME", "en_US.UTF-8"))
  }

  # get url from input and read html
  date <- as.Date(date)
  date1 <- format(date, "%Y_%B_")
  date2 <- gsub("^0+", "", format(date, "%d"))
  date_str <- paste0(date1, date2)

  invisible(Sys.setlocale("LC_TIME", locale))

  input <- paste0("https://en.wikipedia.org/wiki/Wikipedia:Main_Page_history/", date_str)

  tryCatch({
    input <- url(input, 'rb')
    wiki_page <- xml2::read_html(input, fill = TRUE)
    close(input)

    # scrape list data
    otd <- wiki_page %>%
      rvest::html_nodes(xpath = '//*[@id="mp-otd"]') %>%
      rvest::html_nodes("li") %>%
      rvest::html_text() %>%
      subset(grepl("^\\d{3}", .))

    n <- min(n_facts, length(otd))

    otd <- otd%>%
      sample(n)

    if(bare_fact == TRUE) {
      otd
    } else {
      paste0("Did you know that on ", format(date, "%B"), " ", date2, " in ", otd, " (Courtesy of Wikipedia)")
    }
  },
  error = function (e) {"I got nothin'"},
  warning = function (w) {"I got nothin'"})

}
