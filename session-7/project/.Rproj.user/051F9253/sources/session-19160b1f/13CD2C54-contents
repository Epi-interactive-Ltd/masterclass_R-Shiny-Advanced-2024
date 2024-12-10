ui <- fluidPage(
  tags$head(
    # here we load all of our required resources for the Shiny app
    useShinyjs(),
    bootstrapLib(theme = bslib::bs_theme(version = 5)),
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css"),
    tags$title("Session 7")
  ),
  tagList(
    
    div(class = "row",
        wellPanel(
          nav_module_ui("nav")
        )
        ),
    div(class = "row",
           div(
          class = "col-3",
          
          div(class = "row",
              wellPanel(
                filters_ui("filters")
                )
              )
          ),
      div(
        class = "col-9",
        router_ui(
          # create your routes and module UI elements here
          route("chart", chart_page_ui("chart")),
          route("table", table_page_ui("table")),
          route("temperature", temperature_page_ui("temperature")),
          route("compareCountries", compare_country_ui("compareCountries")),
          route("viewDownloads", view_downloads_page_ui("viewDownloads"))
        )
      )
      
    ))
    
  
  
  )

secure_app(ui)