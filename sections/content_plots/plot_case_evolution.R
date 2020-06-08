output$selectize_casesByCountries <- renderUI({
  selectizeInput(
    "caseEvolution_country",
    label    = "Select Countries",
    choices  = unique(data_evolution$`Country/Region`),
    selected = top5_countries,
    multiple = TRUE
  )
})

output$case_evolution <- renderPlotly({
  req(input$selectedCountry)
  data <- data_evolution %>%
    filter(if (input$selectedCountry == "All") TRUE else `Country/Region` %in% input$selectedCountry) %>%
    group_by(date, var, `Country/Region`) %>%
    summarise(
      "value" = sum(value, na.rm = T)
    ) %>%
    as.data.frame() 
 
  
  p <- plot_ly(
    data,
    x     = ~date,
    y     = ~value,
    name  =  ifelse(data$var == "confirmed","Toplam",ifelse(data$var == "deceased","Ölüm",ifelse(data$var == "recovered","Ýyileþti",ifelse(data$var == "active","Aktif","")))),
    color =  ifelse(data$var == "confirmed","yellow",ifelse(data$var == "deceased","red",ifelse(data$var == "recovered","green",ifelse(data$var == "active","blue","")))),
    type  = 'scatter',
    mode  = 'lines') %>%
    layout(
      yaxis = list(title = "# Vakalar"),
      xaxis = list(title = "Tarih")
    )%>%
    config(locale = "tr") 

  if (input$checkbox_logCaseEvolution) {
    p <- layout(p, yaxis = list(type = "log"))
  }

  return(p)
})
