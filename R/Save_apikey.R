#' Saves the apikey to project .Renviron for future use
#'
#' @param apikey is the APIkey obtained from Newsapi.org
#'
#' @import usethis
#'
#'
#' @export

Save_apikey <- function(apikey = NULL) {
  usethis::edit_r_environ('project')
  apikey = apikey
}