#' Takes user to register for API key
#' @importFrom usethis ui_yeah
#' @importFrom utils browseURL
#' @return none
#' @export

newsapi_setup <- function() {
  request <- "Welcome to woRldnews! Before you can search for news or articles \n in R , you'll need to get an apikey from Newsapi  at \n https://www.newsapi.org. Would you like to do this now? (Selecting \n 'Yes' will open browser.)"
  
  if (!interactive()) {
    message("Welcome to woRldnews! Before you can search for news or articles \n in R , you'll need to get an apikey from Newsapi  at \n https://www.newsapi.org. Once you have your user apikey, you can use it to search for news and articles in the shiny.app.")
    return(invisible(NULL))
  }
  
  if (usethis::ui_yeah(request)) {
    utils::browseURL("https://www.newsapi.org/register")
    cat("If a browser did not open automatically, please open a browser and register \n at https://www.newsapi.org/register.\n\n")
    cat("After registering, you will be given a 'apikey'. You can use it \n to search for news and articles in a shiny.app.\n You can also choose to save them to your .Rprofile for later use with \n the function newsapi_save_credentials(apikey).")
  }
}