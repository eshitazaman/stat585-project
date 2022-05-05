#' Runs the shiny app that allows users to make search for articles and news headlines
#'
#' @importFrom shiny runApp
#' @export


runshiny <- function() {
  
  # find and launch the app
  appDir <- system.file("shiny-examples", package = "woRldnews")
  shiny::runApp(appDir, display.mode = "normal")
}




