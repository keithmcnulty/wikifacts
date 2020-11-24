test_that("wiki_inthenews() generates a valid fact", {
  wiki_inthenews() %>%
    testthat::expect_type("character")
})

test_that("wiki_inthenews() generates facts when asked for many", {
  wiki_inthenews(n_facts = 20) %>%
    length() %>%
    testthat::expect_lte(20)
})

test_that("wiki_inthenews() fails in the expected way", {
  wiki_inthenews(date = "1900-01-01") %>%
    testthat::expect_equal("I got nothin'")
})
