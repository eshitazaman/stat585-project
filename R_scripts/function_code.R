library(httr)
library(rvest)
library(xml2)
library(xml2)
library(tibble)
library(lubridate)


url <- "https://newsapi.org/v2/"
API = #apikey

news_project <- function(url,API,Country=NULL,Source=NULL,Category=NULL,Newstype=NULL,from_date=NULL,Language=NULL){
  if(is.null(API)){
    stop("You must provide a APIkey to access news.")
  }
  
  if(!is.null(API) ){
    req_data <- httr::GET(
      paste0(url, "top-headlines?country=us&apiKey=",API)
    )
    
  }
  if (!is.null(API) && !is.null(Country) ){
    req_data <- httr::GET(
      paste0(url, "top-headlines?country=",Country,"&apiKey=",API)
    )
  }
  if (!is.null(API) && !is.null(Country) & !is.null(Source) ){
    stop("Source and Country cannnot be mixed together for search criteria")
  }
  
  
  if(req_data$status_code != 200){
    stop("Request not successful.")
  }
  news <- httr::content(req_data, as = "parsed")
  
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
