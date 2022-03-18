library(shiny)
library(dplyr)
library(data.table)
library(leaflet)
library(tidymodules)

source("utils/data_wrangling.R")

source("modules/sliderInputModule.R")
source("modules/mapModule.R")

data <- getData()

sliderInputModule <- SliderInputModule$new()
mapModule <- MapModule$new()