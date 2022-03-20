getData <- function(path) {
  fread(file = path) %>%
    filter(!is.na(longitudeDecimal) & !is.na(latitudeDecimal)) %>%
    select(c(id, scientificName, vernacularName, longitudeDecimal, latitudeDecimal, eventDate)) %>%
    mutate(eventDate = as.Date(eventDate)) %>%
    rename(lat = latitudeDecimal, long = longitudeDecimal)
}