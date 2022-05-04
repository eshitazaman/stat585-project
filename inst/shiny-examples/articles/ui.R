shinyUI<- fluidPage(
  
  titlePanel("Articles"),

  sidebarPanel(
    selectInput("apikeymethod", "Choose how you will enter the API key", choices = c("Manually", "From .Renviron")),
    textInput("apikey", label = h4("Enter apikey(if you prefferd to enter it manually)", value = "Enter apikey...")),
    textInput("text", label = h3("Enter keyword(s)", value = "Enter keyword(s)...")),
    selectInput("language", "Select Language", choices = c("Arabic", "German", "English", "Spanish", "French",
                                                           "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
                                                           "Serbian", "Urdu", "Zulu"), selected = "English"),
    selectInput("sort_by", "Sort by", choices = c("relevancy", "popularity", "publishedAt"), selected = "relevancy"),
    dateRangeInput('dateRange',
                   label = 'Date range input: yyyy-mm-dd',
                   start = Sys.Date() - 30, end = Sys.Date() ),
    
    actionButton(inputId = "go", label = "Search")
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Articles", DT::dataTableOutput("articles"))
      
    )
  )
)