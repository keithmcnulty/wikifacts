test_that("wiki_onthisday() generates a valid fact on yesterday's date", {
  wiki_onthisday() %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_onthisday() generates a valid fact on another valid date", {
  wiki_onthisday(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1)) %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_onthisday() generates facts when asked for many", {
  test <- wiki_onthisday(n_facts = 20) %>%
    subset(grepl("I got nothin'", .)) %>%
    length() %>%
    testthat::expect_equal(0)
})

test_that("wiki_onthisday() fails in the expected way", {
  wiki_onthisday(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
