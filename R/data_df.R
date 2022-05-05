#' Generates a tibble of news with title, description, published date, url and image url
#'
#' @param x is the parsed data
#' @importFrom tibble tibble
#' @return a tibble of news or articles depending on the search type
#' @export

data_df <- function(x) {
  tibble(
    Title = x$title,
    Description = x$description,
    Date = x$publishedAt,
    Url = x$url,
    Image = x$urlToImage
)
}