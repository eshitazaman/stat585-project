context("News data frame")

key <-"f8acc8a2a90845d5b57ab446ba1d9827"
test_that("checking news dataframe", {
  df <- news_clean(key)
  expect_s3_class(df,"data.frame")
})
