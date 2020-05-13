#' Generate random fact from current or historic Wikipedia main page
#'
#' @return A string with a random item from Wikipedia's main page if it exists for the date specified - otherwise "I got nothin'"
#' @param date A date string of the form "%Y-%m-%d".  Default value is today's date.
#'
#' @examples wiki_randomfact(date = "2020-05-02")

wiki_randomfact <- function(date = Sys.Date()) {

  fun1 <- function() {
    wiki_didyouknow(date)
  }

  fun2 <- function() {
    wiki_onthisday(date)
  }

  fun3 <- function() {
    wiki_inthenews(date)
  }

  s <- sample(1:3, 1)

  eval(parse(text = paste0("fun",s,"()")))

}
