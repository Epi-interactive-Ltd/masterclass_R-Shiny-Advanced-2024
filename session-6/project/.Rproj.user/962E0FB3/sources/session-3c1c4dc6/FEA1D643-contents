download_ui <- function(id){
  ns <- NS(id)
  
  div(
    downloadButton(
      ns("downloadButton"),
      label = "Download Table"
    )
  )
}

download_server <- function(id, data) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      table_data <- reactive({
        data()
      })
      
      
      output$downloadButton <- downloadHandler(
        
        filename = function() {
          return("filtered_world_data.csv")
        },
        content = function(file) {
          
          write.csv(as.data.frame(table_data()), file)
        }
      )
      }
  )
}
