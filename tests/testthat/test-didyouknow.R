test_that("wiki_didyouknow() generates a valid fact", {
  wiki_didyouknow() %>%
    testthat::expect_type("character")
})

test_that("wiki_didyouknow() generates facts when asked for many", {
  wiki_didyouknow(n_facts = 20) %>%
    length() %>%
    testthat::expect_lte(20)
})

test_that("wiki_didyouknow() fails in the expected way", {
  wiki_didyouknow(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
