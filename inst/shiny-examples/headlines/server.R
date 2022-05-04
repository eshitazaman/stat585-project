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
      #headlines <- news_df(news)
      #news_to_df <- function(x) {
        #tibble(
         # name = x$title,
          #description = x$description,
          #date = x$publishedAt, # date is in days since Jan 1 1970
          #sex = x$sex,
          #id = x$id,
          #shelterID = x$shelterId,
          #url = x$url,
          #urlToImage = x$urlToImage
          
        #)
      #}
      
      
      headlines <- news$articles %>% purrr::map_df(woRldnews::news_to_df)
      x1 <- headlines[,1]
      x2 <- headlines[,2]
      x3 <- headlines[,3]
      x4 <- headlines[,4]
      x5 <- headlines[,5]
      
      image <- c()
      for (i in 1:dim(headlines)[1]){
        image <-c(image,paste0('<img src=',headlines[i,5],' height=200','></img>'))
      }
      
      urls <- c()
      for (i in 1:dim(headlines)[1]){
        urls <-c(urls,paste0("<a href='",headlines[i,4],"' target='_balank'>",headlines[i,4], "</a>"))}
      dat <- NULL
      dat <- data.frame(x1,x2,x3,urls, image)
      
      
      
      headlines<-dat
      
      return(headlines)
    }
  })
  
  output$headlines <- DT::renderDataTable({
    DT::datatable(headlines(), escape = FALSE)
  })
}



