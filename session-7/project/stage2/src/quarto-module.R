
quarto_module_ui <- function(id) {
  
  ns <- NS(id)
  tagList(
    uiOutput(ns("pdfButton"))  
  )
  
  
}


quarto_module_server <- function(id, filtered_data, filter_inputs, temperature_data, dl_country_list) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      ns <- session$ns
      
      # Create an observeEvent to disable the downloadPDF if either textInputs are empty, otherwise enable it

      
      
      output$pdfButton <- renderUI({
        # Force pdf button to only display if there is filtered data
        req(filtered_data())
        wellPanel(
          # Create two textInputs for the user to enter their name and reason for downloading
          
          
          downloadButton(ns("downloadPDF"), "Download Quarto Markdown Report")
        )
        
      })
      
      output$downloadPDF <- downloadHandler(
        filename = function() {
          # returned file name
          return("Compare_Countries_Report.html")
        },
        content = function(file) {
          # Use DBI::sqlInterpolate() and DBI::dbExecute() to insert the name and reason into the ‘data_downloads’ table in the database
          
          
          # Render quarto file to local file 'report.html'
          
          
          # Return local file 'report.html'
          
        }
      )
    }
  )
  
}