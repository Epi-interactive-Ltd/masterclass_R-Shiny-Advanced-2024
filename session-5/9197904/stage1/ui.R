fluidPage(
  tags$head(
    # here we load all of our required resources for the Shiny app
    useShinyjs(),
    bootstrapLib(theme = bslib::bs_theme(version = 5)),
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "nprogress.css"),
    tags$script(src = "main.js"),
    tags$script(src="nprogress.js")
  ),
  titlePanel("Modularisation"),
  sidebarLayout(
    sidebarPanel(
      # creating the filters UI
      filters_ui("filters")
    ),
    
    mainPanel(
      fluidRow(
        # creating the navigation UI
        nav_module_ui("nav")
      ),
      fluidRow(
        router_ui(
          # create your routes and module UI elements here
          route("chart", chart_page_ui("chart")),
          route("table", table_page_ui("table")),
          route("temperature", temperature_page_ui("temperature"))
        )
      )
    )
  ))