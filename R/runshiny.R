#' Runs shiny app
#'
#'
#' @import shiny
#'
#' 
#'
#' @export
#' 

runshiny <- function() {
  
  # find and launch the app
  appDir <- system.file("shiny-examples", package = "woRldnews")
  shiny::runApp(appDir, display.mode = "normal")
}





