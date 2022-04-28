require(shiny)
library(DT)

#dim(xx)[1]
#image <- c()
#for (i in 1:dim(xx)[1]){
 # image <-c(image,paste0('<img src=',xx[i,4],' height=200','></img>'))
#}
#image<- xx[,4]
#newsx<- xx[,1]
ui <- shinyUI(
  DT::dataTableOutput('mytable')
)

dat <- data.frame(
  country = newsx,
  flag = image
  )
)

server <- shinyServer(function(input, output){
  output$mytable <- DT::renderDataTable({
    DT::datatable(dat, escape = FALSE)
  })
})

shinyApp(ui, server)