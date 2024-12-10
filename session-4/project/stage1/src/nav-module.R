
nav_module_ui <- function(id) {
  
  ns <- NS(id)
  
  # this module demonstrates both ways of using shiny.router navigation
  tagList(
    div(class = "col",
        wellPanel(
          radioGroupButtons(
            inputId = ns("nav"),
            label = "Choices", 
            # note that the IDs here need to match with the IDs for your routes for change_page to work!
            # for consistency, also align these IDs with the module IDs
            choices = c("Chart" = "chart", "Table" = "table"),
            status = "primary"
          )
        )
    ),
    div(class = "col",
        wellPanel(
          tags$ul(            
            tags$li(a(href = "#!/chart", "Chart")),
            tags$li(a(href = "#!/table", "Table"))
          )
        )
    )
  )
}


nav_module_server <- function(id) {
  moduleServer(
    id,
    # note the inclusion of the 'session' parameter to get module state information (namespace)
    function(input, output, session) {
      
      ns <- session$ns
      
      # wait for the user to click on one of the radio buttons, then navigate to that page
      observeEvent(input$nav, {
        change_page(input$nav)
      }, ignoreInit = T, ignoreNULL = T)
      
    }
  )
}