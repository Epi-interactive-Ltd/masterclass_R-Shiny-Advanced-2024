# Result
shinyServer(function(input, output) {
  
  filtered_data <- eventReactive(input$go, {
    req(input$country)
      
    data <- world_data %>% filter(
      name_long %in% input$country
    )
      
    data <- data %>%
      filter(between(gdpPercap, input$gdp[1], input$gdp[2]))
    
    validate(need(nrow(data) > 0, "Not enough data available for specified filters"))
    
    return(data)
  })
  

# update select inputs ----------------------------------------------------

  
  
  observeEvent(input$region, {
    
    if(input$region != "All") {
      sub_regions <- world_data %>% filter(
        region_un %in% input$region
      ) %>% select(subregion)
    } else {
      sub_regions <- world_data %>% select(subregion)
    }
    
    updateSelectInput(inputId="subregion",
                      choices=c("All", unique(sub_regions$subregion))
    )
  })
  
  observeEvent(list(input$region, input$subregion), {
    if(input$subregion != "All") {
      countries <- world_data %>% filter(
        subregion %in% input$subregion
      ) %>% select(name_long)
    } else {
      if(input$region != "All") {
        countries <- world_data %>% filter(
          region_un %in% input$region
        ) %>% select(name_long)
      } else {
        countries <- world_data %>% select(name_long)
      }
    }
    
    updateSelectInput(inputId="country",
                      choices=c(unique(countries$name_long)))
  })
  
  
  # Set up this observer to disable the "go" button when input$country is not ready
  observeEvent(input$country, {
    if(is.null(input$country)) {
      shinyjs::disable("go")
    } else {
      shinyjs::enable("go")
    }
  }, ignoreNULL = F)
  

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
  

# Table stuff -------------------------------------------------------------

  
  output$table <- renderDataTable({ 
    
    data <- filtered_data() %>% 
      mutate(
        life_exp_status = as.character(lifeExp >= 65)
      ) %>%
      select(
      "Region" = "region_un",
      "Subregion" = "subregion",
      "Country" = "name_long",
      "Life Expectancy" = "lifeExp",
      "GDP Per Capita" = "gdpPercap",
      "life_exp_status"
      )
    
    datatable(
      data,
      rownames = FALSE,
      escape = F,
      selection = "none",
      options = list(
        scrollX = T,
        dom = "ltpi",
        order = list(list(4, "asc")),
        columnDefs = list(list(visible=FALSE, targets=c(5)))
      )
    ) %>%
      formatStyle(
        'life_exp_status',
        target = 'row',
        backgroundColor = styleEqual(levels = "FALSE", values = 'orange')
      )
  })
  

# Summary outputs ---------------------------------------------------------

  
  output$data_summary <- renderUI({
    tagList(
      tags$h4("World data unfiltered"),
      tags$ul(
        tags$li(sprintf("Number of rows: %s", nrow(world_data))),
        tags$li(sprintf("Total Area: %.2f sq. km", sum(world_data$area_km2))),
        tags$li(sprintf("Total Population: %f", sum(world_data$pop, na.rm = T)))
      )
    )
  })
  
  
  output$filter_summary <- renderUI({
    tagList(
      tags$h4("World data filtered"),
      tags$ul(
        tags$li(sprintf("Filters: %s, %s, (%s)", input$region, input$subregion, 
                        paste(input$country, sep = ",", collapse = ","))),
        tags$li(sprintf("Number of rows: %s", nrow(filtered_data()))),
        tags$li(sprintf("Total Area: %.2f sq. km", sum(filtered_data()$area_km2))),
        tags$li(sprintf("Total Population: %.2f", sum(filtered_data()$pop, na.rm = T)))
      )
    )
  })
  
})
