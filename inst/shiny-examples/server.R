server <- function(input, output) {
  numClicks <- 0
  
 
  
  headlines <- reactive({
    cat("in headlines reactive\n")
    cat(input$newstype)
    if(input$newstype == 'Top-headlines'){
      
      if (input$go > numClicks) {
        numClicks <<- numClicks + 1
        print("Start new search")
        # if(input$newstype == 'Top-headlines'){
        cntry <-  c("ae","ar","at","au",
                    "be","bg","br", "ca","ch",
                    "cn","co","cu","cz","de",
                    "eg","fr","gb","gr", "hk","hu","id",
                    "ie", "il","in","it","jp","kr","lt","lv","ma",
                    "mx","my","ng","nl","no","nz","ph",
                    "pl","pt","ro","rs","ru",
                    "sa","se","sg","si", "sk","th","tr","tw",
                    "ua","us","ve","za")[which(c("United Arab Emirates", "Argentina", "Austria","Australia",
                                                 "Belgium", "Bulgaria", "Brazil", "Canada", "Switzerland",
                                                 "China", "Colombia", "Cuba",
                                                 "Czech Republic", "Germany", "Egypt", "France", "United Kingdom",
                                                 "Greece", "Hong Kong", "Hungary", "Indonesia", "Ireland",
                                                 "Israel", "India", "Italia", "Japan", "Korea", "Lithuania",
                                                 "Latvia", "Morocco", "Mexico", "Malaysia", "Nigeria",
                                                 "Netherlands", "Norway", "New Zeland", "Philippines", "Poland",
                                                 "Portugal", "Romania", "Serbia", "Russia", "Saudi Arabia",
                                                 "Sweden", "Singapore", "Slovenia", "Slovakia",
                                                 "Thailand", "Turkey", "Taiwan", "Ukranie", "United States",
                                                 "Venezuela", "South Africa")== input$country)]
        url <- "https://newsapi.org/v2/"
        
        
        if(input$apikeymethod == "Manually") { req_data <- httr::GET(paste0(url, "top-headlines?country=", cntry, "&category=",
                                                                            input$category,"&apiKey=", input$apikey))} 
        else {req_data <- httr::GET(
          paste0(url, "top-headlines?country=", cntry, "&category=",input$category,"&apiKey=", Sys.getenv("apikey")))}
        
        
        news <- httr::content(req_data, as = "parsed")
        
        headlines <- news$articles %>% purrr::map_df(woRldnews::data_df)
        
        headlines<-format_table(headlines)
        
        
        
        return(headlines)
      }
      
      
    }
  })
  
  
  
  
  # output$articles <- DT::renderDataTable({
  #   DT::datatable(articles(), escape = FALSE)
  # })
  # 
  # output$headlines <- DT::renderDataTable({
  #   DT::datatable(headlines(), escape = FALSE)
  # })
  
  
  ff<-data.frame()
  z <- eventReactive(input$go,{
    ff <<- headlines()
    ff
  })
  
  output$results <- DT::renderDataTable({
    DT::datatable(z(), escape = FALSE)
  })
  
  
  articles <- reactive({
    if(input$newstype == 'Articles'){
      cat("in articles reactive\n")
      if (input$go > numClicks) {
        numClicks <<- numClicks + 1
        print("Start new search")
        
        # output$articles <- DT::renderDataTable({
        #apikey <- input$apikey
        keytext <- input$keytext
        cat("what is the keyword\n")
        cat(input$keytext)
        language <- c("ar","de", "en","es","fr", "he", "it","nl","no","pt", "ru", "se", "ud", "zh")[which(c("Arabic", "German", "English", "Spanish", "French",
                                                                                                            "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
                                                                                                            "Serbian", "Urdu", "Zulu") == input$language)]
        sort_by <- input$sort_by
        url <- "https://newsapi.org/v2/"
        
        if(input$apikeymethod == "Manually") { req_data <- httr::GET(paste0(url, "everything?q=", keytext, "&language=",language,"&from=",paste(as.character(input$dateRange), collapse = "&to="), 
                                                                            "&apiKey=", input$apikey))} 
        else {req_data <- httr::GET(
          paste0(url, "everything?q=", keytext, "&language=",language,"&from=",paste0(as.character(input$dateRange), collapse = "&to="),"&apiKey=", Sys.getenv("apikey")))}
        
        news <- httr::content(req_data, as = "parsed")
        articles <- news$articles %>% purrr::map_df(woRldnews::data_df)
        
        articles<-format_table(articles)
        
        
        
        return(articles)
      }
      
    }
    
  })
  
  # 
  f <-data.frame()
  t <- eventReactive(input$go,{
    f <<- articles()
    f
  })
  
  
  # output$results <- DT::renderDataTable({
  #   DT::datatable(headlines(),escape = FALSE )
  # })
  
  output$articles <- DT::renderDataTable({
    DT::datatable(t(),escape = FALSE)
  })
  
  
}

