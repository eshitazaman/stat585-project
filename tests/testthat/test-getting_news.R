context("Getting news using APIkey")


test_that("APIkey exists", {
  APIkey<-"f8acc8a2a90845d5b57ab446ba1d9827"
  expect_type(APIkey,"character")
  
 
  #expect_error()
})
