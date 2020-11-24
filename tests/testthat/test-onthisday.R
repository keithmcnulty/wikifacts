test_that("wiki_onthisday() generates a valid fact", {
  wiki_onthisday() %>%
    testthat::expect_type("character")
})

test_that("wiki_onthisday() generates facts when asked for many", {
  wiki_onthisday(n_facts = 20) %>%
    length() %>%
    testthat::expect_lte(20)
})

test_that("wiki_onthisday() fails in the expected way", {
  wiki_onthisday(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
