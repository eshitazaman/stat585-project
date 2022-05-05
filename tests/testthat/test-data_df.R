url <- "https://newsapi.org/v2/top-headlines?country=us&apiKey=92385a05cc794ccda5780f08987f6918"

req_data <- httr::GET(paste0(url))

news <- httr::content(req_data, as = "parsed") 

test_that("checking news dataframe", {
  
  expect_type(news, "list")
  
  expect_equal(news$status, "ok")

})