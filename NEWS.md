# wikifacts 0.4.9000

# wikifacts 0.4

• Fix issue with non-English System locales (#8)
* Adjust functions to remove reliance on yesterday's date as default (Wikipedia isn't always updated overnight)
* Introduce `wiki_query()` function

# wikifacts 0.3.0

## New features
* Generate multiple facts within functions (#5)
* Move default date to yesterday to avoid timezone issues
* Add ability to display bare facts without cosmetic wrapping
* Add ability for `wiki_randomfact()` to select the type of fact to randomize
* Add `wiki_search()` to open browser with results of search

## Breaking changes
* Remove date argument from `wiki_randomfact()`

# wikifacts 0.2

* Allows facts from historic Wikipedia main pages by adding a `date` argument to functions.
* Outputs a character string (vs previous message output)

# wikifacts 0.1.9000

* Added a `NEWS.md` file to track changes to the package.
