
chart_page_ui <- function(id) {
  
  ns <- NS(id)
  
    wellPanel(
      plotlyOutput(ns("world_data_chart"))
    )
}


chart_page_server <- function(id, filtered_data) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      ns <- session$ns
      
      
      # Chart stuff -------------------------------------------------------------
      
      
      output$world_data_chart <- renderPlotly({
        
        data <- filtered_data() %>% 
          group_by(subregion) %>% 
          summarise(
            avgLifeExp = mean(lifeExp, na.rm = T),
            avgGdpPercap = mean(gdpPercap, na.rm = T)
          ) %>%
          st_drop_geometry()
        
        y_theme <- list(
          title = list(
            text = "Life Expp",
            standoff = 15
          ),
          ticklen = 15,
          showline = T
        )
        
        x_theme <- list(
          title = list(
            text = "Subregion",
            standoff = 10
          ),
          showgrid = F,
          tickangle = 90,
          showline = T
        )
        
        # create the legend customisation list
        legend_theme <- list(
          font = list( 
            family = "sans-serif",
            size = 10,
            color = "#000"),
          bgcolor = "#F5F5F5",
          bordercolor = "#000",
          borderwidth = 1,
          yanchor="top",
          y=0.99,
          xanchor="left",
          x=1.11
        )
        
        chart_colours <- RColorBrewer::brewer.pal(n = length(unique(data$subregion)),
                                                  name = "Paired")   
        
        gdp_hover <- 'Average GDP per cap for <b>%{x}:</b> %{y}<extra></extra>'
        
        fig <- plot_ly(
          data = data,
          x = ~subregion,
          y = ~avgGdpPercap,
          type = "bar",
          colors = chart_colours,
          color = ~subregion,
          hovertemplate = gdp_hover
        )
        
        fig <- fig %>% layout(
          xaxis = x_theme,
          yaxis = y_theme,
          legend = legend_theme
        )
        fig
      })
    }
  )
  
}