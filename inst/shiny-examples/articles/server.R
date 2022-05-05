server <- function(input, output) {
  numClicks <- 0
  
  output$dateRangeText  <- renderText({
    paste("input$dateRange is",
          paste(as.character(input$dateRange), collapse = " &to= ")
    )
  })
  
  articles <- reactive({
    if (input$go > numClicks) {
      numClicks <<- numClicks + 1
      print("Start new search")

 
    apikey <- input$apikey
    text <- input$text
    language <- c("ar","de", "en","es","fr", "he", "it","nl","no","pt", "ru", "se", "ud", "zh")[which(c("Arabic", "German", "English", "Spanish", "French",
                                      "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
                                      "Serbian", "Urdu", "Zulu") == input$language)]
    sort_by <- input$sort_by
    url <- "https://newsapi.org/v2/"

    if(input$apikeymethod == "Manually") { req_data <- httr::GET(paste0(url, "everything?q=", text, "&language=",language,"&from=",paste(as.character(input$dateRange), collapse = "&to="), 
                                                                        "&apiKey=", input$apikey))} 
    else {req_data <- httr::GET(
      paste0(url, "everything?q=", text, "&language=",language,"&from=",paste(as.character(input$dateRange), collapse = "&to="),"&apiKey=", Sys.getenv("apikey")))}
    
    
    news <- httr::content(req_data, as = "parsed")    
    
    articles <- news$articles %>% purrr::map_df(woRldnews::articles_df)
    x1 <- articles[,1]
    x2 <- articles[,2]
    x3 <- articles[,3]
    x4 <- articles[,4]
    x5 <- articles[,5]
    
    image <- c()
    for (i in 1:dim(articles)[1]){
      image <-c(image,paste0('<img src=',articles[i,5],' height=200','></img>'))
    }
    
    urls <- c()
    for (i in 1:dim(articles)[1]){
      urls <-c(urls,paste0("<a href='",articles[i,4],"' target='_balank'>",articles[i,4], "</a>"))}
    dat <- NULL
    dat <- data.frame(x1,x2,x3,urls, image)

    articles <-  dat
    
    return(articles)
    }
    

  })
  
  output$articles <- DT::renderDataTable({
    DT::datatable(articles(), escape = FALSE)
  })

   
}


