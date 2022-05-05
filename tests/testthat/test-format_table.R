context("formatting data frame")


url <- "https://newsapi.org/v2/top-headlines?country=us&apiKey=92385a05cc794ccda5780f08987f6918"

req_data <- httr::GET(paste0(url))

news <- httr::content(req_data, as = "parsed") 

headlines <- news$articles %>% purrr::map_df(woRldnews::data_df)



test_that("checking news dataframe", {
  df <- format_table(headlines)
  expect_s3_class(df,"data.frame")
  
  expect_named(headlines, c("Title", "Description", "Date", "Url", "Image"))
  
  expect_equal(dim(headlines)[2],5)
})