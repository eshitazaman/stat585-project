#' Creates a thinned Shapefile
#'
#' @param parsed news
#'
#' @import rvest
#' @import purrr
#' @import httr
#' @import xml2
#'

#' @return a tibble of news
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
news_df <- function(x, verbose=FALSE) {
  if (verbose) {
    cat(x$name)
    cat("\n")
  }
  title <- character()
  description <- character()
  content <- character()
  imageURL <- character()
  l<-length(x$articles)
  #print("this is length")
  #print(l)
  for(i in 1:l){
    title=c(title, x$articles[[i]]$title)
    if(is.null(x$articles[[i]]$description)){
      description=c(description,NA)
    }
    
    description=c(description,x$articles[[i]]$description)
  }
  
  tibble (
    title = title,
    description = description
  )
}
