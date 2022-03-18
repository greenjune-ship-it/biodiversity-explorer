getData <- function() {
  fread(file = "data/occurenceInPoland.csv") %>%
    filter(!is.na(longitudeDecimal) & !is.na(latitudeDecimal)) %>%
    select(c(id, scientificName, vernacularName, longitudeDecimal, latitudeDecimal, eventDate)) %>%
    mutate(eventDate = as.Date(eventDate)) %>%
    rename(lat = latitudeDecimal, long = longitudeDecimal)
}