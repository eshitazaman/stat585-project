category <- c("all", "business", "entertainment", "general", "health",
              "science", "sports", "technology")

language <- c("All", "Arabic", "German", "English", "Spanish", "French",
              "Hebrew", "Italian", "Norwegian", "Portuguese", "Russian",
              "Serbian", "Urdu", "Zulu")
countries <- c("United Arab Emirates", "Argentina", "Austria","Australia",
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
               "Venezuela", "South Africa"
)
abb_countries <- c("ae","ar","at","au",
                   "be","bg","br", "ca","ch",
                   "cn","co","cu","cz","de",
                   "eg","fr","gb","gr", "hk","hu","id",
                   "ie", "il","in","it","jp","kr","lt","lv","ma",
                   "mx","my","ng","nl","no","nz","ph",
                   "pl","pt","ro","rs","ru",
                   "sa","se","sg","si", "sk","th","tr","tw",
                   "ua","us","ve","za")

###################
news_df <- function(x, verbose=FALSE) {
  if (verbose) {
    cat(x$name)
    cat("\n")
  }
  title <- character()
  description <- character()
  content <- character()
  url <- character()
  imageURL <- character()
  l<-length(x$articles)
  for(i in 1:l){
    title=c(title, x$articles[[i]]$title)
    if(is.null(x$articles[[i]]$description)){
      description=c(description,NA)
    }
    
    description=c(description,x$articles[[i]]$description)
    url=c(url,x$articles[[i]]$url)
    urlToImage=c(urlToImage,x$articles[[i]]$urlToImage)
  }
  
  tibble (
    title = title,
    description = description,
    url = url,
    urlToImage = urlToImage
  )
}
#news <- httr::content(req_data, as = "parsed")

news_to_df <- function(x) {
  tibble(
    name = x$title,
    description = x$description,
    date = as.Date(x$publishedAt), # date is in days since Jan 1 1970
    #sex = x$sex,
    #id = x$id,
    #shelterID = x$shelterId,
    url = x$url,
    urlToImage = x$urlToImage
    
  )
}



###################
library(shiny)
library(tidyverse)
ui <- fluidPage(
  
  titlePanel("Top Headlines"),
  
  sidebarPanel(
    selectInput("country", "Select Country", choices = countries, selected = "United States"),
    selectInput("category", "Select News Category", choices = category, selected = "sports"),
    dateRangeInput('dateRange',
                   label = 'Date range input: yyyy-mm-dd',
                   start = Sys.Date() - 2, end = Sys.Date()
    ),
    actionButton(inputId = "go", label = "Search")
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Top Headlines", tableOutput("headlines")),
      tabPanel("Everything", tableOutput("all_headlines"))
    )
  )
)


server <- function(input, output) {
  output$dateRangeText  <- renderText({
    paste("input$dateRange is",
          paste(as.character(input$dateRange), collapse = " &to= ")
    )
  })
  
  headlines <- reactive({
    if (input$go) {
      print("Start new search")
      
      cntry <- abb_countries[which(countries == input$country)]
      #category_i <- which(category == input$category)
      url <- "https://newsapi.org/v2/"
      req_data <- httr::GET(
        paste0(url, "top-headlines?country=", cntry, "&category=",input$category,"&from=",paste(as.character(input$dateRange), collapse = "&to="),"&apiKey=f8acc8a2a90845d5b57ab446ba1d9827")
      )
      news <- httr::content(req_data, as = "parsed")    
      #headlines <- news_df(news)
      headlines <- news$articles %>% purrr::map_df(news_to_df)
      return(headlines)
    }
  })
  
  output$headlines <- renderTable({
    headlines()
  })
}

shinyApp(ui, server)
