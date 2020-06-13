test_that("wiki_inthenews() generates a valid fact on yesterday's date", {
  wiki_inthenews() %>%
    substr(., 1, 16) %>%
    testthat::expect_equal("Here's some news")
})

test_that("wiki_inthenews() generates a valid fact on another valid date", {
  wiki_inthenews(date = sample(seq(as.Date("2015-01-01"), Sys.Date() - 1, by = "day"), 1)) %>%
    substr(., 1, 16) %>%
    testthat::expect_equal("Here's some news")
})

test_that("wiki_inthenews() fails in the expected way", {
  wiki_inthenews(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
