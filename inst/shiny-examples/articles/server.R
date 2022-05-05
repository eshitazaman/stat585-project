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
    
    articles <- format_table(articles)
    
    return(articles)
    }
    

  })
  
  output$articles <- DT::renderDataTable({
    DT::datatable(articles(), escape = FALSE)
  })

   
}


