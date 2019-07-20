#' Generate random fact
#'
#' @return A message with a random item from Wikipedia's main page

wiki_randomfact <- function() {

  fun1 <- function() {
    wiki_didyouknow()
  }

  fun2 <- function() {
    wiki_onthisday()
  }

  fun3 <- function() {
    wiki_inthenews()
  }

  s <- sample(1:3, 1)

  eval(parse(text = paste0("fun",s,"()")))

}
