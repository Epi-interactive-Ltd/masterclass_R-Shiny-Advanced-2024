library(shiny)

fluidPage(
  tags$head(
    bootstrapLib(theme = bslib::bs_theme(version = 5)),
    tags$link(rel = "stylesheet", href = "custom.css")
  ),
  titlePanel("Vote for your favourite!"),
  wellPanel(fluidRow(
    div(class = "col img-col",
        img(src = "sea_lion.jpg")),
    div(class = "col img-col",
        img(src = "puffin.jpg")),
    div(class = "col img-col",
        img(src = "lamb.jpg")),
    div(class = "col img-col",
        img(src = "horses.jpg"))
  )),
  wellPanel(
    actionButton("sealion", "Sea lion"),
    actionButton("puffin", "Puffin"),
    actionButton("lamb", "Lamb"),
    actionButton("horse", "Horse")
  ),
  wellPanel(
    actionButton("submit", "Reveal votes"),
    actionButton("reset", "Reset")
  ),
  wellPanel(
    
  )
)