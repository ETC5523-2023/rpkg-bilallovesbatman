library(testthat)

test_that("summary_tvrating function returns NULL when less than 5 values are input", {
  # Sample data of less than 5 values
  tv_data_test <- data.frame(av_rating = c(5, 9, 8, 3))

  result <- summary_tvrating(tv_data_test)

  expect_type(result, "NULL")
})
