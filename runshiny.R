runshiny <- function(choice) {
  # locate all the shiny app examples that exist
  validChoices <- list.files(system.file("shiny-examples", package = "woRldnews"))
  
  validChoicesMsg <-
    paste0(
      "Valid examples are: '",
      paste(validChoices, collapse = "', '"),
      "'")
  
  # if an invalid example is given, throw an error
  if (missing(choice) || !nzchar(choice) ||
      !choice %in% validChoices) {
    stop(
      'Please run `runshiny()` with a valid example app as an argument.\n',
      validChoicesMsg,
      call. = FALSE)
  }
  
  # find and launch the app
  appDir <- system.file("shiny-examples", choice, package = "woRldnews")
  shiny::runApp(appDir, display.mode = "normal")
}





