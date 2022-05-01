woRldnews
================

# woRldnews

“woRldnews” is a R package that allows users to search for top and
breaking news in 50 countries in real time. A shiny.app allows users to
search in seven distinct categories and thirteen different languages.

## Installation

woRldnews can be installed with devtools to get the most recent
production version:

``` r
#install.packages('devtools') # if devtools is not already installed
#devtools::install_github('.....')
```

## Examples and Usage

To acquire an API, users must first create a free “Newsapi.org” account.
The Newsapi API will be accessed through the API. To get started, below
are some brief examples of how to use woRldnews. Please read the More
Samples and Tutorials section below for more in-depth tutorials for
woRldnews as well as some examples of what can be done with the library.

## Authenticating with the Newsapi API

Authenticating the connection with the Newsapi API is done at the same
time the woRldnews is initialized.

## Searchinng for headlines

From the select boxes on the shiny.app, users select the country and
category for the news search.
<img src="./man/figures/headlines.png" width="40%" />

In a table format, there are 20 top headlines with title, description,
date, url, and url to image. By clicking on the urls and urltoimage
links, users can access related websites.

<img src="./man/figures/results.png" width="40%" />

## Documentation

woRldnews API v2.0 documentation

## Vignettes

Vignettes are long-form documentation that explore more in-depth
concepts related to the package.

    Introduction to woRldnews

## About Newsapi.org

The Newsapi.org is a basic, easy-to-use REST API that offers JSON search
results for current and historical news stories from over 80,000 sources
throughout the world.
