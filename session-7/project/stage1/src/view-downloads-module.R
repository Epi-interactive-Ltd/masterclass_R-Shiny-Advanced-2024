view_downloads_page_ui <- function(id) {
  
  ns <- NS(id)
  
  div(
    fluidRow(
      div(class = "col",
          wellPanel(dataTableOutput(ns("table")))
      )
    )
  )
}


view_downloads_page_server <- function(id) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      
      ns <- session$ns
      
      output$table <- renderDataTable({ 
        
        data <- tbl(dbConn, 'data_downloads') %>% 
          select(
            'ID' = id,
            'Date' = created,
            'Name' = user_name,
            'Reason' = reason
          ) %>%
          collect()
        
        datatable(
          data,
          rownames = FALSE,
          escape = F,
          selection = "none"
        )
      })
    }
  )
  
}