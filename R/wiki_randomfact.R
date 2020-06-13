#' Generate random facts from historic Wikipedia main pages
#'
#' @description
#' `wiki_randomfact()` generates random facts from Wikipedia main pages after 1 January 2015.
#'
#' @param n_facts An integer determining the number of facts that will be generated.
#' @param fact String to determine the type of fact to be randomly generated - "any" will generate a random selection.
#' @param bare_fact Logical.  Determining whether the fact should be quoted as is or surrounded by a preamble and courtesy statement.
#' @param repeats Logical.  Determining if repeat facts should be permitted.  If FALSE the number of facts may be less than requested.

#' @return A vector of strings with random items from Wikipedia's main page - otherwise "I got nothin'"
#'
#' @examples
#' wiki_randomfact()

wiki_randomfact <- function(n_facts = 1L, fact = c("any", "didyouknow", "onthisday", "inthenews"),
                            bare_fact = FALSE, repeats = TRUE) {

  fact <- match.arg(fact)

  fun1 <- function() {
    wiki_didyouknow(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1), bare_fact = bare_fact)
  }

  fun2 <- function() {
    wiki_onthisday(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1), bare_fact = bare_fact)
  }

  fun3 <- function() {
    wiki_inthenews(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1), bare_fact = bare_fact)
  }

  out <- c()

  for (i in 1:n_facts) {
    s <- switch(fact, "any" = sample(1:3, 1), "didyouknow" = 1, "onthisday" = 2, "inthenews" = 3)
    out[i] <- eval(parse(text = paste0('fun', s, "()")))
  }

  if (repeats ==FALSE) {
    unique(out)
  } else{
    out
  }
}
