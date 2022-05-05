#' Generates a tibble of news with title, description, publication date, url,  and image. 
#'
#' @param x is the JSON file obtained from  NewsApi.org
#'
#' @import tibble
#'
#' @return a tibble of news
#'
#' @export


articles_df <- function(x) {
  tibble(
    Title = x$title,
    Description = x$description,
    Date = x$publishedAt,
    Url = x$url,
    Image = x$urlToImage
  )
}
