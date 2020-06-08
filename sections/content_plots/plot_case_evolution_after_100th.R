output$selectize_casesByCountriesAfter100th <- renderUI({
  
  selectizeInput(
    "caseEvolution_countryAfter100th",
    label    = "Ülke Seç",
    choices  = unique(data_evolution$`Country/Region`),
    selected = rbind(top5_countries, input$selectedCountry),
    multiple = TRUE
  )
})

output$selectize_casesSince100th <- renderUI({
  selectizeInput(
    "caseEvolution_var100th",
    label    = "Durum Seç",
    choices  = list("Toplam" = "confirmed", "Ölüm" = "deceased", "Ýyileþen" = "recovered"),
    multiple = FALSE
  )
})

output$case_evolution_after100 <- renderPlotly({
  req(!is.null(input$checkbox_per100kEvolutionCountry100th), input$caseEvolution_var100th)
  data <- data_evolution %>%
    arrange(date) %>%
    filter(if (input$caseEvolution_var100th == "confirmed") (value >= 100 & var == "confirmed") else if  (input$caseEvolution_var100th == "recovered") (value >= 100 & var == "recovered") else (value >= 10 & var == "deceased")) %>%
    group_by(`Country/Region`, population, date) %>%
    filter(if (is.null(input$caseEvolution_countryAfter100th)) TRUE else `Country/Region` %in% input$caseEvolution_countryAfter100th) %>%
    summarise(value = sum(value, na.rm = T)) %>%
    mutate("daysSince" = row_number()) %>%
    ungroup()

  if (input$checkbox_per100kEvolutionCountry100th) {
    data$value <- data$value / data$population * 100000
  }

  p <- plot_ly(data = data, x = ~daysSince, y = ~value, color = ~`Country/Region`, type = 'scatter', mode = 'lines')%>%
    config(locale = "tr") 

  if (input$caseEvolution_var100th == "confirmed") {
    p <- layout(p,
      yaxis = list(title = "# Toplam Vaka"),
      xaxis = list(title = "# 100. Vakadan sonraki veriler")
    )
  }
  else if (input$caseEvolution_var100th == "recovered") {
    p <- layout(p,
                yaxis = list(title = "# Ýyileþen Vaka"),
                xaxis = list(title = "# 100. Vakadan sonraki veriler")
    )
  }
  else {
    p <- layout(p,
      yaxis = list(title = "# Ölümler"),
      xaxis = list(title = "# 10. Vakadan sonraki veriler")
    )
  }
  if (input$checkbox_logCaseEvolution100th) {
    p <- layout(p, yaxis = list(type = "log"))
  }
  if (input$checkbox_per100kEvolutionCountry100th) {
    p <- layout(p, yaxis = list(title = "#Nüfuslara göre her 100,000 deki vaka sayýsý"))
  }

  return(p)
})
