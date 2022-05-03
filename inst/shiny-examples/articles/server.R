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

 # output$articles <- DT::renderDataTable({
    apikey <- input$apikey
    text <- input$text
    language <- c("ar","de", "en","es","fr", "he", "it","nl","no","pt", "ru", "se", "ud", "zh")[which(c("Arabic", "German", "English", "Spanish", "French",
                                      "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
                                      "Serbian", "Urdu", "Zulu") == input$language)]
    sort_by <- input$sort_by
    url <- "https://newsapi.org/v2/"
    req_data <- httr::GET(
      paste0(url, "everything?q=", text, "&language=",language,"&from=",paste(as.character(input$dateRange), collapse = "&to="),"&apiKey=", Sys.getenv("newsapi_apikey"))
    )
    news <- httr::content(req_data, as = "parsed")    
    
    
    everything_df <- function(x, verbose=FALSE) {
      if (verbose) {
        cat(x$name)
        cat("\n")
      }
      author <- character()
      title <- character()
      description <- character()
      url <- character()
      imageURL <- character()
      publishedAt <- character()
      content <- character()
      l<-length(x$articles)
      
      for(i in 1:l){
        if(is.null(x$articles[[i]]$author)){
          author=c(author,NA)
        }
        author =c(author, x$articles[[i]]$author)
        
        if(is.null(x$articles[[i]]$title)){
          title=c(title,NA)
        }
        title=c(title, x$articles[[i]]$title)
        
        if(is.null(x$articles[[i]]$description)){
          description=c(description,NA)
        }
        description=c(description,x$articles[[i]]$description)
        
        if(is.null(x$articles[[i]]$url)){
          url=c(url,NA)
        }
        url=c(url,x$articles[[i]]$url)
        
        
        if(is.null(x$articles[[i]]$imageURL)){
          imageURL=c(imageURL,NA)
        }
        imageURL=c(imageURL,x$articles[[i]]$imageURL)
        
        if(is.null(x$articles[[i]]$publishedAt)){
          publishedAt=c(publishedAt,NA)
        }
        publishedAt=c(publishedAt,x$articles[[i]]$publishedAt)
        
        if(is.null(x$articles[[i]]$content)){
          content=c(content,NA)
        }
        content=c(content,x$articles[[i]]$content)
      }
      
      tibble (
        title = title,
        description = description,
        content = content,
        url = url,
        author = author,
        publishedAt = publishedAt
      )
      
      
    }
    
    articles <-  everything_df(news)
    
    return(articles)
    }
    
    
    
  })
  
  output$articles <- DT::renderDataTable({
    DT::datatable(articles(), escape = FALSE)
  })

    #articles<-DT::datatable(articles,options=list(lengthMenu = c(5, 2),pageLength=5))
    
 # })
}


