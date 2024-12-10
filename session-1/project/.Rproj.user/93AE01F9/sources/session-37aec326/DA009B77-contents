fluidPage(
  bootstrapLib(theme = bslib::bs_theme(version = 5)),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "main.css")
  ),
  titlePanel("Bootstrap Extensions"),
  sidebarLayout(
    sidebarPanel(
      h2("Filter:"),
      
      selectInput(
        inputId = "region",
        label = "Select Region:",
        choices = c("All", unique(world_data$region_un)),
        selected = "All",
        multiple = F
      ),
      
      conditionalPanel(
        condition = 'input.region != "All"',
        
        selectInput(
          inputId = "subregion",
          label = "Select Subregion:",
          choices = NULL,
          multiple = F
        ),
        
        conditionalPanel(
          condition = 'input.subregion != "All"',
          
          selectInput(
            inputId = "country",
            label = "Select Country:",
            choices = NULL,
            multiple = F
          ),
        )
        
      ),
      
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
          div(class = "col offset-4", wellPanel(uiOutput("filter_summary")))
        ),
        fluidRow(
          div(class = "col",
              wellPanel(dataTableOutput("table"))
          )
        ),
        fluidRow(
          wellPanel(
            div(class = "col offset-6", style = "float: right;",
              downloadButton("export", "Export table data")
            )
          )
        )
      )
    )))
  ))