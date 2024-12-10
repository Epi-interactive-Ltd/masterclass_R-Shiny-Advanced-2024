server <- function(input, output) {
  
  
  votes <- reactiveValues(sealionCount = 0, puffinCount = 0, lambCount = 0, horseCount = 0)
  
  # Reactives ---------------------------------------------------------------
  
  
  results <- reactive({
    tagList(p("sealion:", votes$sealionCount),
            p("puffin:",votes$puffinCount),
            p("lamb:",votes$lambCount),
            p("horse:",votes$horseCount))
  })
  
  totalVotes <- eventReactive(list(input$submit, input$reset), {
    results()
  }, ignoreInit = T)
  
  
  
  # Render UI ---------------------------------------------------------------
  
  
  output$liveDisplay <- renderUI({
    results()
  })
  
  
  output$finalDisplay <- renderUI({
    tagList(
      tags$b("Final results"),
      totalVotes()
    )
  })
  
  
  # Observers ---------------------------------------------------------------
  
  
  # Observe events for voting -----------------------------------------------
  
  
  observeEvent(input$sealion, {
    votes$sealionCount <- votes$sealionCount + 1
  })
  
  observeEvent(input$puffin, {
    votes$puffinCount <- votes$puffinCount + 1
  })
  
  observeEvent(input$lamb, {
    votes$lambCount <- votes$lambCount + 1
  })
  
  observeEvent(input$horse, {
    votes$horseCount <- votes$horseCount + 1
  })
  
  
  # Observe event for resetting votes ---------------------------------------
  
  observeEvent(input$reset, {
    votes$sealionCount <- 0
    votes$puffinCount <- 0
    votes$lambCount<- 0
    votes$horseCount<- 0
  }, priority = 1)
}