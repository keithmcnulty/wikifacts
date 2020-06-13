test_that("wiki_search() works", {
  wiki_search('R Programming Language') %>%
    testthat::expect_silent()
})
