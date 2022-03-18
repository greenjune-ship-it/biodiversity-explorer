library(shiny)
library(dplyr)
library(data.table)
library(leaflet)
library(tidymodules)

source("utils/data_wrangling.R")

source("modules/mapModule.R")
source("modules/testModule.R")

data <- getData()

mapModule <- MapModule$new()
testModule <- TestModule$new()