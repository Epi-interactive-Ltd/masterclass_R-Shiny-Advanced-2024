temperature_page_ui <- function(id){
  ns <- NS(id)
  div(
    fluidRow(
      div(class = "col-3",
          wellPanel(
            h3("Temperature Filter"),
            tagList(
              selectInput(
                inputId = ns("column_order"),
                label = "Select a column to order by:",
                choices = c("region", "country", "city", "month", "year", "avg_monthly_temp"),
                selected = "avg_monthly_temp"
              ),
              selectInput(
                inputId = ns("order_direction"),
                label = "Order direction:",
                choices = c("Ascending" = "asc", "Descending" = "desc"),
                selected = "Ascending"
              ),
              sliderInput(
                inputId = ns("date_slider"),
                label = "Select a date range:",
                min = 1995,
                max = 2020,
                value = c(1995, 2020),
                step = 1,
                sep = ""
              ),
              
            )
          )
          ),
      div(class = "col-9",
          wellPanel(
            dataTableOutput(ns("temperature_table"))
          )
          )
      
    )
    
  )
  
  
}

temperature_page_server <- function(id, filtered_data) {
  
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      # Create a reactive to store the iso_a2 codes from filtered_data
      
      
      # Create a reactive to retrieve temperature data from DB based on the selected countries using your getCountries function
      # Make sure to turn the data into a data frame before you return it (hint: as.data.frame())
      # Apply a bindCache to improve performance
     
      
      
      # Create a reactive to filter the country temperature data by year
      # Apply a bindCache to improve performance
     
      
      
      # Uncomment once you have created your reactives
      # output$temperature_table <- renderDataTable({
      # 
      # 
      #   # use the temperature_data to fill in the table
      #   temp_data <- temperature_data() %>% mutate(avg_monthly_temp = as.numeric(sprintf("%.2f", avg_monthly_temp)))
      # 
      #   if(!is.null(input$order_direction)){
      #     # Order the table based on the selected column and direction
      #     if(input$order_direction == "asc"){
      #       temp_data <- temp_data %>% arrange(!!sym(input$column_order))
      #     }else{
      #       temp_data <- temp_data %>% arrange(desc(!!sym(input$column_order)))
      #     }
      #   }
      # 
      #   datatable(
      #     temp_data,
      #     rownames = FALSE,
      #     escape = F,
      #     selection = "none",
      #     options = list(ordering=F
      #     )
      # 
      # 
      #   )
      # })
    }
  )
}