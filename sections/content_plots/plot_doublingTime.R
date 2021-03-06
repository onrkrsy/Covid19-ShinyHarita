output$selectize_doublingTime_Country <- renderUI({
  selectizeInput(
    "selectize_doublingTime_Country",
    label    = "�lke Se�",
    choices  = unique(data_evolution$`Country/Region`),
    selected = rbind(top5_countries, input$selectedCountry),
    multiple = TRUE
  )
})

output$selectize_doublingTime_Variable <- renderUI({
  selectizeInput(
    "selectize_doublingTime_Variable",
    label    = "Durum Se�",
    choices  = list("Toplam Vaka" = "doublingTimeConfirmed", "�l�m" = "doublingTimeDeceased"),
    multiple = FALSE
  )
})

output$dayGrowthRate <- renderUI({
  selectizeInput(
    "dayGrowthRate",
    label    = "�kiye katlanma s�resi hesaplamada kullan�lacak g�n say�s�",
    choices  = list("3 G�n" = "3", "7 G�n" = "7",  "10 G�n" = "10",  "30 G�n" = "30"),
    multiple = FALSE
  )
})


output$plot_doublingTime <- renderPlotly({
  req(input$selectize_doublingTime_Country, input$selectize_doublingTime_Variable)
  daysGrowthRate <- as.numeric(input$dayGrowthRate)
  data           <- data_evolution %>%
    pivot_wider(id_cols = c(`Province/State`, `Country/Region`, date, Lat, Long), names_from = var, values_from = value) %>%
    filter(if (input$selectize_doublingTime_Variable == "doublingTimeConfirmed") (confirmed >= 100) else (deceased >= 10)) %>%
    filter(if (is.null(input$selectize_doublingTime_Country)) TRUE else `Country/Region` %in% input$selectize_doublingTime_Country) %>%
    group_by(`Country/Region`, date) %>%
    select(-recovered, -active) %>%
    summarise(
      confirmed = sum(confirmed, na.rm = T),
      deceased  = sum(deceased, na.rm = T)
    ) %>%
    arrange(date) %>%
    mutate(
      doublingTimeConfirmed = round(log(2) / log(1 + (((confirmed - lag(confirmed, daysGrowthRate)) / lag(confirmed, daysGrowthRate)) / daysGrowthRate)), 1),
      doublingTimeDeceased  = round(log(2) / log(1 + (((deceased - lag(deceased, daysGrowthRate)) / lag(deceased, daysGrowthRate)) / daysGrowthRate)), 1),
    ) %>%
    mutate("daysSince" = row_number()) %>%
    filter(!is.na(doublingTimeConfirmed) | !is.na(doublingTimeDeceased))

  p <- plot_ly(data = data, x = ~daysSince, y = data[[input$selectize_doublingTime_Variable]], color = ~`Country/Region`, type = 'scatter', mode = 'lines')%>%
    config(locale = "tr") 

  if (input$selectize_doublingTime_Variable == "doublingTimeConfirmed") {
    p <- layout(p,
      yaxis = list(title = "Toplam Vakan�n �kiye Katlanma S�resi"),
      xaxis = list(title = "# 100.Vakadan sonraki veriler")
    )
  } else {
    p <- layout(p,
      yaxis = list(title = "�l�mlerin �kiye Katlanma S�resi"),
      xaxis = list(title = "# 10.Vakadan sonraki veriler")
    )
  }

  return(p)
})
