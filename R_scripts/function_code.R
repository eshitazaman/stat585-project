library(httr)
library(rvest)
library(xml2)
library(tibble)
library(lubridate)


url <- "https://newsapi.org/v2/"
API = #apikey

news_project <- function(url,API,Country=NULL,Source=NULL,Category=NULL,Newstype=NULL,from_date=NULL,Language=NULL){
  if(is.null(API)){
    stop("You must provide an APIkey to access news.")
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

url <- "https://newsapi.org/v2/"
req_data <- httr::GET(
  paste0(url, "top-headlines?country=us&category=sports", 
         "&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
)


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
  print("this is length")
  print(l)
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


#pp <- news_df(news)
#data <- replace(data, data == 0, NA)

