library(shiny)
library(shinycssloaders)
library(dplyr)
library(data.table)
library(leaflet)
library(tidymodules)

source("utils/data_wrangling.R")

source("modules/sliderInputModule.R")
source("modules/mapModule.R")

wholeDataset <- getData()

sliderInputModule <- SliderInputModule$new(periodRange = wholeDataset$eventDate,
                                           vernacularName = wholeDataset$vernacularName %>% unique(),
                                           scientificName = wholeDataset$scientificName %>% unique())
mapModule <- MapModule$new(wholeDataset = wholeDataset)