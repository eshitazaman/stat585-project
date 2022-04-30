shinyUI<- fluidPage(
  
  titlePanel("Top Headlines"),
  
  
  sidebarPanel(
    

    selectInput("country", "Select Country", choices = c("United Arab Emirates", "Argentina", "Austria","Australia",
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
                                                        "Venezuela", "South Africa"), selected = "United States"),
    selectInput("category", "Select News Category", choices = c("sports","health", "entertainment",
                                                                "business","general",
                                                                "science","technology"), selected = "sports"),
    dateRangeInput('dateRange',
                   label = 'Date range input: yyyy-mm-dd',
                   start = Sys.Date() - 2, end = Sys.Date()
    ),
    actionButton(inputId = "go", label = "Search")
  ),
  
  
  mainPanel(
    tabsetPanel(
      tabPanel("Top Headlines", DT::dataTableOutput("headlines")),
      tabPanel("Everything", DT::dataTableOutput("all_headlines"))
    )
  )
)