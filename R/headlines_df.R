#' Generates a tibble of news with title, description, published date, url and image url
#'
#' @param x is the APIkey to access news
#'
#' @import tibble
#'

#' @return a tibble of news
#'
#' @export






headlines_df <- function(x) {
tibble(
Title = x$title,
Description = x$description,
Date = x$publishedAt,
Url = x$url,
Image = x$urlToImage
)
}