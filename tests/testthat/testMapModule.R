test_that("Filter data by ranges of dates", {

  data <- setDT(list(date = seq(as.Date("2010-1-1"), as.Date("2015-1-1"), by = "years")))
  range <- c(as.Date("2011-01-01"), as.Date("2014-01-01"))

  map_instance <- MapModule$new(wholeDataset = data)

  result <- data %>% map_instance$filterDatasetByDateRange(column = "date", range = range)

  expect_equal(result$date, as.Date(c("2011-01-01", "2012-01-01", "2013-01-01", "2014-01-01")))

})

test_that("Filter dataset by values from two columns", {

  data <- setDT(list(
    scientificName = c("a", "b", "c", 1, 2, 3),
    vernacularName = c(1, 2, 3, "d", "e", "g")
  ))
  species <- c("a", "b", "g")

  map_instance <- MapModule$new(wholeDataset = data)

  result <- data %>% map_instance$filterDatasetBySpecies(species)

  expect_equal(result, setDT(list(
    scientificName = c("a", "b", 3),
    vernacularName = c(1, 2, "g")
  )))

})