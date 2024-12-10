
library(shiny)
library(dplyr)
library(readr)
library(leaflet)
library(plotly)
library(spData)
library(sf)
library(DT)
library(RColorBrewer)

library(shinyjs)
# introduced shiny.router for navigation
library(shiny.router)
# introduced shinyWidgets for extra shiny inputs
library(shinyWidgets)

# load the new modules using the source() function
source("src/nav-module.R")
source("src/filters-module.R")
# Load your new module files here (make sure to create them in the 'src/' folder)

# load world data from the spData package
world_data <- spData::world |>
  filter(name_long != "Antarctica") |>
  mutate(popDensity = round(pop / area_km2, 4)) |>
  st_drop_geometry()


