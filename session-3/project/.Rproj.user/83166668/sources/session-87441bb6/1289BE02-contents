
library(shiny)
library(dplyr)
library(readr)
library(leaflet)
library(plotly)
library(spData)
library(sf)
library(DT)
library(RColorBrewer)


# Load the alcohol consumption data
alcohol_consumption <- read.csv("data/Alcohol_data.csv")

# load world data from the spData package
world_data <- spData::world |>
  filter(name_long != "Antarctica") |>
  mutate(popDensity = round(pop / area_km2, 4)) |>
  mutate(popupText = sprintf("<div style = 'padding: 10px; background-color: #eee; color: #444;'>
                              <b>%s</b><br>
                              <b>Region: </b>%s<br>
                             <b>Subregion: </b>%s<br>
                             <b>Type: </b>%s<br>
                             <hr>
                             <b>Area (Sq. Km): </b>%s<br>
                             <b>Population: </b>%s<br>
                             <b>Population Density: </b>%s</div>",
                             name_long, region_un, subregion, type, area_km2, pop, popDensity)) |>
  st_as_sf() 


