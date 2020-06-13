test_that("Internet connection exists", {
  curl::has_internet() %>%
    testthat::expect_equal(TRUE)
})
