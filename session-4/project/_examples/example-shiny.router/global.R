
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

library(shiny.router)


# load world data from the spData package
world_data <- spData::world |>
  filter(name_long != "Antarctica") |>
  mutate(popDensity = round(pop / area_km2, 4)) |>
  st_drop_geometry()


