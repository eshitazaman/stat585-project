
#' Run the shiny app that allows users to make search for articles and news headlines
#'
#' @param choice indicates the type of search (either article or headlines) a user want to make
#'
#' @import shiny
#'
#'
#' @export




  # locate all the shiny app examples that exist
  
 
runshiny <- function() {
  
  # find and launch the app
  appDir <- system.file("shiny-examples", package = "woRldnews")
  shiny::runApp(appDir, display.mode = "normal")
}





