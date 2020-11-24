test_that("wiki_randomfact() generates a valid didyouknow fact", {
  wiki_randomfact(fact = "didyouknow") %>%
    testthat::expect_type("character")
})

test_that("wiki_randomfact() generates a valid inthenews fact", {
  wiki_randomfact(fact = "inthenews") %>%
    testthat::expect_type("character")
})

test_that("wiki_randomfact() generates a valid onthisday fact", {
  wiki_randomfact(fact = "onthisday") %>%
    testthat::expect_type("character")
})

test_that("wiki_randomfact() generates a valid random fact", {
  x <- wiki_randomfact() %>%
    testthat::expect_type("character")
})

