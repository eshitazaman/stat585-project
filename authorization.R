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


#### Function for saving apikey to Rprofile

newsapi_save_apikey <- function(apikey = NULL) {
  assertthat::assert_that(file.exists(".Rprofile"))
  rprof_contents <- readLines(".Rprofile")
  assertthat::assert_that(!is.null(apikey))
  file_changed <- F
  
  if (!is.null(apikey)) {
    assertthat::assert_that(is.character(apikey))
    apikey_exists <- any(grepl("newsapi_apikey", rprof_contents))
    if (!apikey_exists) {
      str <- sprintf('\nnewsapi_apikey = \"%s\"\n', apikey)
      cat(str, file = ".Rprofile", append = TRUE)
      file_changed <- T
    } else {
      warning(".Rprofile already contains an apikey; no file change was made.\n")
    }
  }
  
  if (file_changed) {
    source(".Rprofile")
  }
  #     if (!requireNamespace("rstudioapi", quietly = T) || 
  #         !requireNamespace("fs", quietly = T)) {
  # 
  #       message("Your credentials will be avaiable in your Global Environment after restarting RStudio.")
  #     } else {
  #       restart_rstudio("Your credentials will be avaiable in your Global Environment after restarting RStudio.")
  #     }
  #   }
}


newsapi_apikey <- "f8acc8a2a90845d5b57ab446ba1d9827"
newsapi_save_apikey(apikey = newsapi_apikey)


