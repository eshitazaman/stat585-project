sort_by <- c("relevancy", "popularity", "publishedAt")

languages <- c("Arabic", "German", "English", "Spanish", "French",
              "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
              "Serbian", "Urdu", "Zulu")

abb_languages <- c("ar","de", "en","es","fr", "he", "it","nl","no","pt", "ru", "se", "ud", "zh")

###################
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
    author = author,
    title = title,
    description = description,
    url = url,
    imageURL = imageURL,
    publishedAt = publishedAt,
    content = content
  )
}
#news <- httr::content(req_data, as = "parsed")


###################
library(shiny)
ui <- fluidPage(
  
  titlePanel("Articles"),
  
  sidebarPanel(
    textInput("text", label = h3("Enter keyword(s)", value = "Enter keyword(s)...")),
    selectInput("language", "Select Language", choices = languages, selected = "English"),
    selectInput("sort_by", "Sort by", choices = sort_by, selected = "relevancy"),
    dateRangeInput('dateRange',
                   label = 'Date range input: yyyy-mm-dd',
                   start = Sys.Date() - 30, end = Sys.Date() ),
),
    
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Articles", tableOutput("articles"))
    )
  )
)



server <- function(input, output) {
  output$dateRangeText  <- renderText({
    paste("input$dateRange is", 
          paste(as.character(input$dateRange), collapse = " &to= ")
    )
  })

  output$articles <- renderTable({
    text <- input$text
    language <- abb_languages[which(languages == input$language)]
    sort_by <- input$sort_by
    url <- "https://newsapi.org/v2/"
    req_data <- httr::GET(
      paste0(url, "everything?q=", text, "&language=",language,"&from=",paste(as.character(input$dateRange), collapse = "&to="),"&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
    )
    news <- httr::content(req_data, as = "parsed")    
    articles <- everything_df(news)
    #headlines <- news$articles %>% purrr::map_df(news_data)
  })
}

shinyApp(ui, server)
########



