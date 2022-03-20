library(shiny)
library(tidymodules)
library(dplyr)
library(data.table)
library(leaflet)
library(RColorBrewer)

source("utils/dataWranglingUtil.R")
source("modules/customizeInputModule.R")
source("modules/mapModule.R")
source("modules/aboutModule.R")

wholeDataset <- getData("data/occurenceInPoland.csv")

customizeInputModule <- CustomizeInputModule$new(periodRange = wholeDataset$eventDate,
                                                 scientificName = wholeDataset$scientificName %>% unique(),
                                                 vernacularName = wholeDataset$vernacularName %>% unique(),)
mapModule <- MapModule$new(wholeDataset = wholeDataset)
aboutModule <- AboutModule$new()