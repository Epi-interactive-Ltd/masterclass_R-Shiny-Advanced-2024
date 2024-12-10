
# in creating the filters UI, we have taken all UI elements from the sidebar
# and put them into this UI function inside a tagList.
# Note that when we create an input or output, we use the ns() function to apply
# the namespace around those ids.
filters_ui <- function(id) {
  
  # we have to create the namespace manually for our UI function.
  ns <- NS(id)
  
  tagList(
    h2("Filter:"),
    div(id = "region-container",
        selectInput(
          inputId = ns("region"),
          label = "Select Region:",
          choices = c("All", unique(world_data$region_un)),
          selected = "All",
          multiple = F
        ),
    ),
    div(id = "subregion-container",
        selectInput(
          inputId = ns("subregion"),
          label = "Select Subregion:",
          choices = NULL,
          multiple = F
        ),
    ),  
    div(id = "country-container",
        selectizeInput(
          inputId = ns("country"),
          label = "Select Country:",
          choices = NULL,
          multiple = T,
          selected = NULL,
          options = list(placeholder = "Select a country...")
        ),
    ),
    checkboxInput(
      inputId = ns("select_all"),
      label = "(De)Select all countries",
      value = F
    ),
    sliderInput(ns("gdp"), "GDP Per Capita", min = 0, step = 100,
                max = round(max(world_data$gdpPercap, na.rm = T), digits = -1) + 100,
                value = c(0, round(max(world_data$gdpPercap, na.rm = T), digits = -1) + 100)),
    
    sliderInput(ns("year"), "Year range for temperature data", min = 1995, step = 1,
                max = 2020,
                value = c(1995, 2020),
                sep = ""),
    # ensure that the button is disabled when the application first loads
    shinyjs::disabled(actionButton(ns("go"), "Go"))
  )
}


# Note that when we are using the existing inputs / outputs, we don't need to use
# the ns function. This is just when we are creating a new id, not referring to an existing id
# I.e. when we access from input$XXXX or output$XXXX, we don't need to use ns()

filters_server <- function(id) {
  
  moduleServer(
    id,
    function(input, output, session) {
      
      # instead of creating the namespace manually, we retrieve it from the session
      # moduleServer creates the namespace for us
      ns <- session$ns
      
      
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
      
      filter_values <- reactive({
        list(
          country = input$country,
          subregion = input$subregion,
          region = input$region,
          gdp = input$gdp,
          year = input$year
        )
      })
      
      
      all_valid_countries <- reactive({
        req(input$subregion, input$region)
        
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
        return(countries)
        
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
        countries <- all_valid_countries()
        updateSelectInput(inputId="country",
                          choices=c(unique(countries$name_long)))
        updateCheckboxInput(inputId="select_all",
                            value = F)
      })
      
      
      # Set up this observer to disable the "go" button when input$country is not ready
      observeEvent(input$country, {
        if(is.null(input$country)) {
          shinyjs::disable("go")
        } else {
          shinyjs::enable("go")
        }
      }, ignoreNULL = F)
      
      # Update the selected countries when select all is changed
      observeEvent(input$select_all, {
        
        countries <- all_valid_countries()
        if(input$select_all){
          
          
          updateSelectInput(inputId="country",
                            choices=c(unique(countries$name_long)),
                            selected = c(unique(countries$name_long)))
          
        }else{
          updateSelectInput(inputId="country",
                            choices=c(unique(countries$name_long)),
                            selected = "")
        }
      }, ignoreInit = T)
      
      
      # we return the filtered data out of the module so it can be used in other modules
      return(list(
        "filtered_data" = filtered_data, 
        "filter_inputs" = filter_values
      ))
    }
  )
  
}

