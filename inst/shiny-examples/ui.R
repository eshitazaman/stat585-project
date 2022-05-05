shinyUI<- fluidPage(
  
  titlePanel("News Headlines"),
  
  
  sidebarPanel(
    selectInput("newstype","News Type",c("Articles","Top-headlines")),
    selectInput("apikeymethod", "Choose how you will enter the API key", choices = c("Manually", "From .Renviron")),
    textInput("apikey", label = h5("Enter apikey (if you haven't saved it in .Renviron)", value = "Enter apikeys...")),
    
    conditionalPanel(
      condition= "input.newstype =='Top-headlines'",
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
                                                                "science","technology"), selected = "sports")
  ),
  conditionalPanel(
    condition= "input.newstype =='Articles'",
    
      textInput("keytext", label = h5("Enter keyword(s)", value = "Enter keyword(s)...")),
      selectInput("language", "Select Language", choices = c("Arabic", "German", "English", "Spanish", "French",
                                                             "Hebrew", "Italian", "Dutch", "Norwegian", "Portuguese", "Russian",
                                                             "Serbian", "Urdu", "Zulu"), selected = "English"),
      selectInput("sort_by", "Sort by", choices = c("relevancy", "popularity", "publishedAt"), selected = "relevancy"),
      dateRangeInput('dateRange',
                     label = 'Date range input: yyyy-mm-dd',
                     start = Sys.Date() - 30, end = Sys.Date() )
      
    ),
  actionButton(inputId = "go", label = "Search")
  
 
  ),
  
  
  mainPanel(
    
    DT::dataTableOutput("results"),
    DT::dataTableOutput("articles")
    # tabsetPanel(
    #   
    #   tabPanel("Results", DT::dataTableOutput("results")),
    #   tabPanel("Articles", DT::dataTableOutput("articles"))
    #   
    # 
    # )
  )
)