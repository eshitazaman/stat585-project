library(httr)
library(rvest)
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
      paste0(url, "top-headlines?country=Country&apiKey=",API)
    )
  }
  if (!is.null(API) && !is.null(Country) & !is.null(Source) ){
    stop("Source and Country cannnot be mixed together for search criteria")
  }
  
  
  if(req_data$status_code != 200){
    stop("Request not successful.")
  }
  news <- httr::content(req_data, as = "parsed")
  
  news_df <- function(x, verbose=FALSE) {
    if (verbose) {
      cat(x$name)
      cat("\n")
    }
    title <- character()
    description <- character()
    content <- character()
    imageURL <- character()
    published_date <-character()
    pdate <- character()
    
    
    
    l= length(x[[3]]) 
    for(i in 1:l){
      title=c(title, x$articles[[i]]$title)
      description=c(description,x$articles[[i]]$description)
      published_date=x$articles[[i]]$publishedAt
      published_date= date(published_date)
      #print(published_date)
      pdate=c(as.Date(pdate),published_date)
      #print(":::::")
      #print(pdate)
      
    }
    
    tibble (
      title = title,
      description = description,
      published_at=pdate
    )
  }
  news_data = news_df(news)
  return (news_data)
  
}

#url <- "https://newsapi.org/v2/"
#API = "f8acc8a2a90845d5b57ab446ba1d9827"
#polity_asked <- politely(GET, verbose=TRUE)
#req_data <- politely_asked(
# paste0(url, "top-headlines?country =us&category=sports&apiKey=",API)
#)
#news <- httr::content(req_data, as = "parsed")
#str(tr_news)


