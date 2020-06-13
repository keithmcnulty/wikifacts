test_that("wiki_didyouknow() generates a valid fact on yesterday's date", {
  wiki_didyouknow(date = Sys.Date() - 1) %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_didyouknow() generates a valid fact on another valid date", {
  wiki_didyouknow(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1)) %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_didyouknow() fails in the expected way", {
  wiki_didyouknow(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
