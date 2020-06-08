output$selectize_casesByCountries_new <- renderUI({
  selectizeInput(
    "selectize_casesByCountries_new",
    label    = "Select Country",
    choices  = c("All", unique(data_evolution$`Country/Region`)),
    selected = "All"
  )
})
output$selectedCountry <- renderUI({
  selectizeInput(
    "selectedCountry",
    label    = "Ülke Deðiþtir",
    choices  = c(unique(data_evolution$`Country/Region`)),
    selected = "Turkey"
  )
})
output$case_evolution_new <- renderPlotly({
  req(input$selectedCountry)
  data <- data_evolution %>%
    filter(if (input$selectedCountry == "All") TRUE else `Country/Region` %in% input$selectedCountry) %>%
    group_by(date, var, `Country/Region`) %>%
    summarise(
      "value_new" = sum(value_new, na.rm = T)
    ) %>%
    as.data.frame() 
  
  
  p <- plot_ly(
    data,
    x     = ~date,
    y     = ~value_new,
    name  =  ifelse(data$var == "confirmed","Toplam",ifelse(data$var == "deceased","Ölüm",ifelse(data$var == "recovered","Ýyileþti",ifelse(data$var == "active","Aktif","")))),
    color =  ifelse(data$var == "confirmed","yellow",ifelse(data$var == "deceased","red",ifelse(data$var == "recovered","green",ifelse(data$var == "active","blue","")))),
    type  = 'scatter',
    mode  = 'lines') %>%
    layout(
      yaxis = list(title = "# Vakalar"),
      xaxis = list(title = "Tarih")
    )%>%
    config(locale = "tr") 
 
})