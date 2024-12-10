
chart_page_ui <- function(id) {
  
  ns <- NS(id)
  
    wellPanel(
      plotlyOutput(ns("world_data_chart")),
      actionButton(ns("download_img"), label = "Export chart image (the easy way)")
    )
}


chart_page_server <- function(id, filtered_data) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      ns <- session$ns
      
      
      # Chart stuff -------------------------------------------------------------
      
      
      output$world_data_chart <- renderPlotly({
        generate_subregion_plot(filtered_data())
      })
      
      
      observeEvent(input$download_img, {
        screenshot(download = TRUE, server_dir = tempdir(),
                         id = "world_data_chart")
      })
    }
  )
  
}