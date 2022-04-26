#' Generates a tibble of news with title, description, published date and image link
#'
#' @param APIkey is the APIkey to access news
#'
#' @import rvest
#' @import purrr
#' @import httr
#' @import xml2
#' @import tibble
#'

#' @return a tibble of news
#'
#' @export



news_clean <- function(APIkey=NULL) {
  
  #url <- "https://newsapi.org/v2/"
  #req_data <- httr::GET(
   # paste0(url, "top-headlines?country=us", 
    #       "&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
  #)
  
  #if(req_data$status_code != 200){
   # stop("Request not successful.")
  #}
  #stopifnot(!is.null(APIkey))
  if(is.null(APIkey)){
    news<-get_data()
  }
 else{ 
  news <-get_data(APIkey) ### can we call it here?
 }
  
  news_to_df <- function(x) {
    tibble(
      name = x$title,
      description = x$description,
      date = as.Date(x$publishedAt),
      #sex = x$sex,
      #id = x$id,
      #shelterID = x$shelterId,
      pics = x$urlToImage
    )
  }
  
  news_df <- news$articles %>% purrr::map_df(news_to_df)
  
  return (news_df)
}