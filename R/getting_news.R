#' Takes user to the url to register for the API key
#'
#' @return None
#'
#' @export


get_API <- function(){
  
request <- ""
message("Please reister to get an API key to get news from this site. After registering save the api key!")
utils::browseURL("https://newsapi.org/register")  
}



#' Creates a parsed news content from the raw news data
#'
#' @param APIkey provided by the user to get the news headlines of USA
#'
#' @import rvest
#' @import purrr
#' @import httr
#' @import xml2
#' @importFrom assertthat assert_that
#'

#' @return parsed news
#'
#' @export


get_data<-function(APIkey=NULL){
url <- "https://newsapi.org/v2/"
if(is.null(APIkey)){
  req_data <- httr::GET(
    paste0(url, "top-headlines?country=us&category=sports", 
           "&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
  )
}

else{
  assertthat::assert_that(is.character(APIkey))
  req_data <- httr::GET(
    paste0(url, "top-headlines?country=us", 
           "&apiKey=",APIkey)
  )
}

news <- httr::content(req_data, as = "parsed")

return (news)
}

