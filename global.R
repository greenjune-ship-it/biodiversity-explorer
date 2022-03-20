library(shiny)
library(tidymodules)
library(dplyr)
library(stringr)
library(data.table)
library(leaflet)
library(RColorBrewer)

source("utils/dataWranglingUtil.R")

source("modules/sliderInputModule.R")
source("modules/mapModule.R")

wholeDataset <- getData()

sliderInputModule <- SliderInputModule$new(periodRange = wholeDataset$eventDate,
                                           scientificName = wholeDataset$scientificName %>% unique(),
                                           vernacularName = wholeDataset$vernacularName %>% unique(),)
mapModule <- MapModule$new(wholeDataset = wholeDataset)
mapLegendModule <- MapLegendModule$new()