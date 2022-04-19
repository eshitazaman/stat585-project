#' Creates a thinned Shapefile
#'
#' @param url and API key
#'
#' @import rvest
#' @import purrr
#' @import httr
#' @import xml2
#'

#' @return parsed news
#'
#' @export


get_data <- function(){
url <- "https://newsapi.org/v2/"
req_data <- httr::GET(
  paste0(url, "top-headlines?country=us&category=sports", 
         "&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
)

news <- httr::content(req_data, as = "parsed")

return (news)
}

