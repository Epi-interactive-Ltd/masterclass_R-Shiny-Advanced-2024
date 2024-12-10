
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
      
      observeEvent(list(input$name, input$download_reason), {
        req(input$name, input$download_reason)
        if (input$name != "" & input$download_reason != ""){
          # Make sure that both inputs are filled in
          shinyjs::enable("downloadPDF")
        } else {
          shinyjs::disable("downloadPDF")
        }
      })
      
      
      output$pdfButton <- renderUI({
        # Force pdf button to only display if there is filtered data
        req(filtered_data())
        wellPanel(
          textInput(
            inputId = ns("name"),
            label = "Enter your name: ",
            value = ""
            
          ),
          textInput(
            inputId = ns("download_reason"),
            label = "Reason for download",
            value = ""
          ),
          shinyjs::disabled(downloadButton(ns("downloadPDF"), "Download Quarto Markdown Report"))
        )
        
      })
      
      output$downloadPDF <- downloadHandler(
        filename = function() {
          # returned file name
          return("Compare_Countries_Report.html")
        },
        content = function(file) {
          # Insert row into database
          sql <- 'INSERT INTO data_downloads (user_name, reason) VALUES (?name, ?download_reason)'
          query <- DBI::sqlInterpolate(dbConn, sql, name = input$name, download_reason = input$download_reason)
          DBI::dbExecute(dbConn, query)
          
          # # render quarto file to local file 'report.html'
          
          
          # return local file 'report.html'
          
        }
      )
    }
  )
  
}