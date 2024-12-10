compare_country_ui <- function(id) {
  ns <- NS(id)
  tagList(
    uiOutput(ns("content")),
    div(
      class = "row quarto_div",
      quarto_module_ui("quarto")
    )
  )
}


compare_country_server <- function(id, data, inputs) {
  moduleServer(
    id,
    # note the inclusion of the 'session' parameter to get module state information (namespace)
    function(input, output, session) {
      
      ns <- session$ns
      
      # Reactive to store your data with an appropriate bindCache
      country_list <- reactive({
        data()
      }) %>%
        bindCache(data())
      
      # ReactiveVals to store your selected countries
      first_country <- reactiveVal()
      second_country <- reactiveVal()
      
      # Reactive to store the names of your selected countries (for quarto)
      dl_country_list <- reactive({
        req(input$country_one, input$country_two)
        list(
          input$country_one, 
          input$country_two
        )
      })
      
      
      # Reactive to store the filtered iso_a2 codes
      filtered_countries <- reactive({
        
        sel_countries <- c(input$country_one, input$country_two)
        countries <- data() %>% filter (name_long %in% sel_countries)
        return(countries$iso_a2)
      })
      
      # Reactive to store the temperature data for your selected countries
      temperature_data <- reactive({
        req(filtered_countries())
        
        # when the filtered countries change, we fetch the records from the db using getCountries
        temp_data <- getCountries(filtered_countries(), inputs()$year)
        temp_data <- as.data.frame(temp_data)
        
        temp_data$avg_monthly_temp <- as.numeric(temp_data$avg_monthly_temp)
        
        return(temp_data)
      }) %>%
        bindCache(inputs()$year, filtered_countries())
      
      
      # observeEvents to update the first and second country reactives
      observeEvent(input$country_one, {
        country <- data() %>% filter(
          name_long %in% input$country_one
        )
        first_country(country)
      })
      
      observeEvent(input$country_two, {
        country <- data() %>% filter(
          name_long %in% input$country_two
        )
        second_country(country)
      })
      
      
      output$content <- renderUI ({
        req(country_list())
        
        # Create the layout for the module using bootstrap layout
        # The choices for the two country selectInputs should be all countries in country_list
        # For the two country selectInputs try using ifelse to check there is a second country available and set appropriate options as selected
        # Use output$countries to display the summary for both countries 
        # Create a selectInput to choose which plot to display (hint: choices = c("Average Monthly Temperature" = "avg_monthly_temp", "Population" = "pop", "Life Expectancy" = "lifeExp", "GDP Per cap" = "gdpPercap", "Population Density" = "popDensity", "Area km2" = "area_km2"))
        # Using uiOutput display the selected plot using output$data_output
        
        tagList(
          div(
            class = "row",
            div(
              class = "col-6",
              wellPanel(
                selectInput(
                  inputId = ns("country_one"),
                  label = "Country One:",
                  choices = country_list()$name_long,
                  selected = country_list()$name_long[1]
                )
              )
            ),
            div(
              class = "col-6",
              wellPanel(
                selectInput(
                  inputId = ns("country_two"),
                  label = "Country Two:",
                  choices = unique(country_list()$name_long),
                  selected = ifelse(length(country_list()$name_long) > 1,  country_list()$name_long[2], country_list()$name_long[1])
                )
              )
            )
            
          ),
          uiOutput(ns("countries")),
          div(
            class = "row",
            wellPanel(
              selectInput(
                inputId = ns("plot_select"),
                label = "Plot to compare: ",
                choices = c("Average Monthly Temperature" = "avg_monthly_temp", "Population" = "pop", "Life Expectancy" = "lifeExp", "GDP Per cap" = "gdpPercap", "Population Density" = "popDensity", "Area km2" = "area_km2")
              )
            )
          ),
          uiOutput(ns("data_output"))
        )
      })
      
      # Determine if the plot to de displayed is a line or bar plot
      output$data_output <- renderUI({
        if(input$plot_select == "avg_monthly_temp"){
          # Display a line plot
          ele <- plotlyOutput(ns("compare_line"))
        }else{
          # Display a bar plot
          ele <- plotlyOutput(ns("compare_bar"))
        }
        return(div(ele))
      })
      
      # For a bar plot
      output$compare_bar <- renderPlotly({
        
        if(first_country()$name_long != second_country()$name_long){
          country_data <- first_country()
          country_data[2, ] <- second_country() # Add a row with the second country
        }else{
          country_data <- first_country() # Only one country = one row
        }
        
        # To map the id to the label to display for the plot
        names_map <- c("pop" = "Population", "lifeExp" = "Life Expectancy", "gdpPercap" = "GDP Per cap", "popDensity" = "Population Density", "area_km2" = "Area km2")
        
        # Call the generate_compare_plot function, passing the country_data, plot_label (using the map), and plot_id
        fig <- generate_compare_plot(as.data.frame(country_data), plot_label = names_map[[input$plot_select]], plot_id = input$plot_select)
        
        return(fig)
      })
      
      # For a line plot
      output$compare_line <- renderPlotly({
        
        validate(need(nrow(temperature_data()) > 0, "Selected Country(ies) have no temperature data."))
        
        # Call the generate_temperature_plot function passing the temperature_data
        fig <- generate_temperature_plot(temperature_data())
        fig
      })
      
      # Using bootstrap layout create the summary row for the two countries
      # Display a summary for both countries using compare_country passing appropriate parameters
      output$countries <- renderUI({
        req(first_country())
        tagList(
          div(
            class = "row",
            div(
              class = "col-6",
              wellPanel(
                compare_country(first_country())
              )
            ),
            div(
              class = "col-6",
              wellPanel(
                compare_country(second_country())
              )
            )
          )
        )
      })
      
      return(dl_country_list) # For quarto
    }
  )
}