
table_page_ui <- function(id) {
  
  ns <- NS(id)
  
  div(
    fluidRow(
      div(class = "col", wellPanel(uiOutput(ns("data_summary")))),
      div(class = "col", wellPanel(uiOutput(ns("filter_summary"))))
    ),
    fluidRow(
      div(class = "col",
          wellPanel(dataTableOutput(ns("table")))
      )
    )
  )
}


table_page_server <- function(id, filtered_data) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      ns <- session$ns
      
      
      # Summary outputs ---------------------------------------------------------
      
      
      output$data_summary <- renderUI({
        tagList(
          tags$h4("World data unfiltered"),
          tags$ul(
            tags$li(sprintf("Number of rows: %s", nrow(world_data))),
            tags$li(sprintf("Total Area: %.2f sq. km", sum(world_data$area_km2))),
            tags$li(sprintf("Total Population: %f", sum(world_data$pop, na.rm = T)))
          )
        )
      })
      
      
      output$filter_summary <- renderUI({
        tagList(
          tags$h4("World data filtered"),
          tags$ul(
            tags$li(sprintf("Filters: %s, %s, (%s)", input$region, input$subregion, 
                            paste(input$country, sep = ",", collapse = ","))),
            tags$li(sprintf("Number of rows: %s", nrow(filtered_data()))),
            tags$li(sprintf("Total Area: %.2f sq. km", sum(filtered_data()$area_km2))),
            tags$li(sprintf("Total Population: %.2f", sum(filtered_data()$pop, na.rm = T)))
          )
        )
      })
      
      
      
      
      
      # Table stuff -------------------------------------------------------------
      
      
      output$table <- renderDataTable({ 
        
        data <- filtered_data() %>% 
          mutate(
            life_exp_status = as.character(lifeExp >= 65)
          ) %>%
          select(
            "Region" = "region_un",
            "Subregion" = "subregion",
            "Country" = "name_long",
            "Life Expectancy" = "lifeExp",
            "GDP Per Capita" = "gdpPercap",
            "life_exp_status"
          )
        
        datatable(
          data,
          rownames = FALSE,
          escape = F,
          selection = "none",
          options = list(
            scrollX = T,
            dom = "ltpi",
            order = list(list(4, "asc")),
            columnDefs = list(list(visible=FALSE, targets=c(5)))
          )
        ) %>%
          formatStyle(
            'life_exp_status',
            target = 'row',
            backgroundColor = styleEqual(levels = "FALSE", values = 'orange')
          )
      })
    }
  )
  
}