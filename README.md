<!-- badges: start -->
[![Travis build status](https://travis-ci.org/keithmcnulty/wikifacts.svg?branch=master)](https://travis-ci.org/keithmcnulty/wikifacts)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

# wikifacts
R package which generates messages containing random facts from Wikipedia.  Intended for light-hearted support for scripts or apps that take a long time to execute.

## Installation

```r
devtools::install_github("keithmcnulty/wikifacts")
```

## Functionality

- `wiki_didyouknow()` generates message with random 'did you know' fact from Wikipedia main page
- `wiki_inthenews()` generates message with random 'in the news' fact from Wikipedia main page
- `wiki_onthisday()` generates message with random 'on this day' fact from Wikipedia main page
- `wiki_randomfact()` generates message with random fact from Wikipedia main page (one of the above selected randomly)

## Examples

```
wikifacts::wiki_didyouknow()

Did you know that Captain Henry Meintjes, a South African World War I flying ace, was shot in the wrist when far over enemy lines but still managed to bring his airplane back and land it safely? (Courtesy of Wikipedia)

```

```
wikifacts::wiki_randomfact()

Did you know that on this day in 1982 – Members of the Provisional Irish Republican Army detonated two bombs in Hyde Park and Regent's Park in London, killing 11 people, 7 horses, and wounding over 50 other people. (Courtesy of Wikipedia)

```



