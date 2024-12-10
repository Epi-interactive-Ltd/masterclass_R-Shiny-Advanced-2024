library(shiny)

fluidPage(
  tags$head(
    bootstrapLib(theme = bslib::bs_theme(version = 5)),
    tags$link(rel = "stylesheet", href = "custom.css")
  ),
  titlePanel("Vote for your favourite!"),
  wellPanel(
    fluidRow(
      div(class = "col img-col", 
          img(src = "sea_lion.jpg")
          ),
      div(class = "col img-col", 
          img(src = "puffin.jpg")
      ),
      div(class = "col img-col", 
          img(src = "lamb.jpg")
      ),
      div(class = "col img-col", 
          img(src = "horses.jpg")
      )
    )
  ),
  wellPanel(
    actionButton("sealion", "Sea lion"),
    actionButton("puffin", "Puffin"),
    actionButton("lamb", "Lamb"),
    actionButton("horse", "Horse")
  ),
  wellPanel(
    fluidRow(
      div(class = "col-auto", actionButton("reset", "Reset")),
      div(class = "col-auto", actionButton("undo", "Undo last vote")),
    ),
    fluidRow(
      div(class = "col-auto", style = "margin-top: 15px", textOutput("timer"))
    )
    
    
  ),
  wellPanel(
    fluidRow(
    column(3, tags$b("Live results"),
           uiOutput("liveDisplay")),
    column(3, tags$b("Final results"),
           uiOutput("finalDisplay"))
    )
  )
)