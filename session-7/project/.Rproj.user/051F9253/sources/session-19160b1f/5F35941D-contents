# Result
shinyServer(function(input, output, session) {
  
  # Put the server credentials/authentication check here
  res_auth <- secure_server(check_credentials = check_credentials(
    'auth_db.sqlite',
    passphrase = Sys.getenv('AUTH_DB_KEY')
  ))
  
  output$auth_output <- renderPrint({
    reactiveValuesToList(res_auth)
  })
  
  
  # assign the filters_server module to a variable to keep the result
  filter_values <- filters_server("filters")
  
 
 
  # set up the servers for all of the pages
  nav_module_server("nav")
  chart_page_server("chart", filter_values$filtered_data)
  table_page_server("table", filter_values$filtered_data, filter_values$filter_inputs)
  temperature_data <- temperature_page_server("temperature", filter_values$filtered_data, filter_values$filter_inputs)
  dl_country_list <- compare_country_server("compareCountries", filter_values$filtered_data, filter_values$filter_inputs)
  view_downloads_page_server('viewDownloads')
  
  # quarto module requires the filtered data, filter inputs,and temperature data
  quarto_module_server("quarto", filter_values$filtered_data, filter_values$filter_inputs, temperature_data, dl_country_list)
  
  # we call the router server here to set up the pages and page changing functionality
  router_server(root_page = "chart")
  
})
