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

        # Existing code - for reference -------------------------------------------

        # remove the existing UI definitions from here and move them into modules
        # remember to apply namespaces where (if) needed!
        # Think about what will be kept and what is no longer needed with shiny.router?
        
        tabsetPanel(tabPanel(
          title = "Chart",
          wellPanel(plotlyOutput("world_data_chart"))
        ),
        tabPanel(
          title = "Table",
          div(
            fluidRow(
              div(class = "col", wellPanel(uiOutput("data_summary"))),
              div(class = "col", wellPanel(uiOutput("filter_summary")))
            ),
            fluidRow(
              div(class = "col",
                  wellPanel(dataTableOutput("table"))
              )
            )
          )
        ))
        

        # Exercise - use Shiny router and page modules -------------------------

        
        # router_ui(
        #   # create your routes and module UI elements here
        #   
        # )
      )
    )
  ))