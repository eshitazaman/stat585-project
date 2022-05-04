#' Generates a tibble of news with title, description, published date, news url and image url
#'
#' @param x is the APIkey to access news
#'
#' @import tibble
#'

#' @return a tibble of news
#'
#' @export






news_to_df <- function(x) {
tibble(
name = x$title,
description = x$description,
date = x$publishedAt, # date is in days since Jan 1 1970
url = x$url,
urlToImage = x$urlToImage
)
}