test_that("wiki_didyouknow() generates a valid fact", {
  wiki_didyouknow() %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_didyouknow() generates facts when asked for many", {
  test <- wiki_didyouknow(n_facts = 20) %>%
    subset(grepl("I got nothin'", .)) %>%
    length() %>%
    testthat::expect_equal(0)
})

test_that("wiki_didyouknow() fails in the expected way", {
  wiki_didyouknow(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
