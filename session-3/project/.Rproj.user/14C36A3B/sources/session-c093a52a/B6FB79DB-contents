fluidPage(
  tags$head(
    useShinyjs(),
    bootstrapLib(theme = bslib::bs_theme(version = 5)),
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "nprogress.css"),
    tags$script(src = "main.js"),
    tags$script(src="nprogress.js")
  ),
  titlePanel("Bootstrap Extensions"),
  sidebarLayout(
    sidebarPanel(
      h2("Filter:"),
      
      div(id = "region-container",
        selectInput(
          inputId = "region",
          label = "Select Region:",
          choices = c("All", unique(world_data$region_un)),
          selected = "All",
          multiple = F
        ),
      ),
      div(id = "subregion-container",
        selectInput(
          inputId = "subregion",
          label = "Select Subregion:",
          choices = NULL,
          multiple = F
        ),
      ),  
      div(id = "country-container",
          selectizeInput(
            inputId = "country",
            label = "Select Country:",
            choices = NULL,
            multiple = T,
            selected = NULL,
            options = list(placeholder = "Select a country...")
          ),
      ),
      sliderInput("gdp", "GDP Per Capita", min = 0, step = 100,
                  max = round(max(world_data$gdpPercap, na.rm = T), digits = -1) + 100,
                  value = c(0, round(max(world_data$gdpPercap, na.rm = T), digits = -1) + 100)),
      shinyjs::disabled(actionButton("go", "Go"))
    ),
    
    mainPanel(tabsetPanel(tabPanel(
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
    )))
  ))