test_that("wiki_randomfact() generates a valid didyouknow fact", {
  wiki_randomfact(fact = "didyouknow") %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_randomfact() generates a valid inthenews fact", {
  wiki_randomfact(fact = "inthenews") %>%
    substr(., 1, 16) %>%
    testthat::expect_equal("Here's some news")
})

test_that("wiki_randomfact() generates a valid onthisday fact", {
  wiki_randomfact(fact = "onthisday") %>%
    substr(., 1, 12) %>%
    testthat::expect_equal("Did you know")
})

test_that("wiki_randomfact() generates a valid random fact", {
  x <- wiki_randomfact() %>%
    substr(., 1, 13)

    testthat::expect_false(isTRUE(x = "I got nothin'"))
})

