# Result
shinyServer(function(input, output, session) {
  
  # assign the filters_server module to a variable to keep the result
  filtered_data <- filters_server("filters")
 
  # set up the servers for all of the pages
  nav_module_server("nav")
  chart_page_server("chart", filtered_data)
  table_page_server("table", filtered_data)
  temperature_page_server("temperature", filtered_data)
  
  # we call the router server here to set up the pages and page changing functionality
  router_server(root_page = "chart")
  
})
