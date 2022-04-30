runshiny <- function() {
  appDir <- system.file("shiny-examples", "myapp", package = "stat585")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `stat585`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}

