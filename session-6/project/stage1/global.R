
library(shiny)
library(dplyr)
library(dbplyr)
library(readr)
library(leaflet)
library(plotly)
library(spData)
library(sf)
library(DT)
library(RColorBrewer)

library(shinyjs)
library(shiny.router)
library(shinyWidgets)

library(quarto)
library(DBI)


# load the new modules using the source() function
source("src/nav-module.R")
source("src/filters-module.R")
source("src/chart-page-module.R")
source("src/table-page-module.R")
source("src/temperature-page-module.R")
source("src/download-module.R")
source("src/util.R")

# load world data from the spData package
world_data <- spData::world |>
  filter(name_long != "Antarctica") |>
  mutate(popDensity = round(pop / area_km2, 4)) |>
  st_drop_geometry()


# load DB connection values from .env
readRenviron(".env")

# use the environemnt variables with Sys.getenv() to create a db connection
dbConn <- DBI::dbConnect(
  RPostgres::Postgres(),
  dbname = Sys.getenv("DB_NAME"),
  host = Sys.getenv("DB_HOST"),
  port = as.numeric(Sys.getenv("DB_PORT")),
  user = Sys.getenv("DB_USER"),
  password = Sys.getenv("DB_PW")
)

# Fill out the getCountries function to query the world_temp_data table from the database, filter by country iso_a2 codes, and summarise an average monthly temperature

getCountries <- function(country_iso_codes){
  
  # use the tbl function to create a reference to the database
  result <- tbl(dbConn, "world_temp_data") %>%
    filter(iso_a2 %in% country_iso_codes) %>%
    group_by(country, city, region, month, year) %>%
    summarise(avg_monthly_temp =  mean(avg_temp, na.rm = T)) %>%
    distinct() %>% 
    # when the collect function is called, the dplyr code will be 
    # translated into SQL and evaluated to retrieve the data
    collect()
}

onStop(function() { dbDisconnect(dbConn)})