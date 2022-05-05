#' Saves the apikey to project .Renviron for future use
#'
#' @param apikey is the APIkey obtained from Newsapi.org
#' @import usethis
#' @import assertthat
#' @export

save_apikey <- function(apikey = NULL) {
  usethis::edit_r_environ('project')
  assertthat::assert_that(file.exists(".Renviron"))
  renv_contents <- readLines(".Renviron")
  assertthat::assert_that(!is.null(apikey))
  file_changed <- F
  
  if (!is.null(apikey)) {
    assertthat::assert_that(is.character(apikey))
    apikey_exists <- any(grepl("apikey", renv_contents))
    if (!apikey_exists) {
      str <- sprintf('\napikey = \"%s\"\n', apikey)
      cat(str, file = ".Renviron", append = TRUE)
      file_changed <- T
    } else {
      warning(".Renviron already contains an apikey; no file change was made.\n")
    }
  }
  
  if (file_changed) {
    source(".Renviron")
  }
}
