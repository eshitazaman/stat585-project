server <- function(input, output) {
  numClicks <- 0
  
  output$dateRangeText  <- renderText({
    paste("input$dateRange is",
          paste(as.character(input$dateRange), collapse = " &to= ")
    )
  })
  
  headlines <- reactive({
    if (input$go > numClicks) {
      numClicks <<- numClicks + 1
      print("Start new search")
      
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
  })
  
  output$headlines <- DT::renderDataTable({
    DT::datatable(headlines(), escape = FALSE)
  })
}



