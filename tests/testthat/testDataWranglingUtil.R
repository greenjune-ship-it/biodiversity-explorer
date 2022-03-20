test_that("Dataset has valid column names", {
  column_names <- colnames(getData("testdata/columnNames.csv"))
  expect_equal(column_names, c("id", "scientificName", "vernacularName", "long", "lat", "eventDate"))
})

test_that("Dataset eventDate column belongs to Date class", {
  data <- getData("testdata/columnNames.csv")
  expect_is(data$eventDate, "Date")
})

test_that("Dataset eventDate column converts from IDate to Date class", {
  data <- getData("testdata/columnNames.csv")
  expect_error(expect_is(data$eventDate, "IDate"))
})