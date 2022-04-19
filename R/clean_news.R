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