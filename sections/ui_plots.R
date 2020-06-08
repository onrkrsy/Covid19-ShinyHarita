body_plots <- dashboardBody(
  fluidRow(   column(uiOutput("selectedCountry"),width=12), width=12),
 
  fluidRow(
    fluidRow(
      fluidRow(
        box(
          title = "Vaka sayýsýnýn zamana baðlý deðiþimi",
          plotlyOutput("case_evolution"),
          column( checkboxInput("checkbox_logCaseEvolution", label = "Logaritmik", value = FALSE),
            width = 3,
            style = "float: right; padding: 10px; margin-right: 50px"
          ),
          width = 6
        ),
        box(
          title = "Yeni Vakalar",
          plotlyOutput("case_evolution_new"),
          column( tags$div("*Aktif hasta sayýsý ayný gün içinde ki toplam sayý ile iyileþen sayý arasýndaki fark ile bulunmaktadýr.",tags$br(),tags$br()),
                  width = 9,
                  style = "float: right; padding: 10px; margin-right: 50px"
          ),
          width = 6
        )
      ),
      fluidRow(
        box(
          title = "Karþýlaþtýrma grafiði (*Vaka sayýsý en yüksek 5 ülke ile seçilen ülkenin karþýlaþtýrýlmasý)",
          plotlyOutput("case_evolution_after100"),
          fluidRow(
            column(
              uiOutput("selectize_casesByCountriesAfter100th"),
              width = 3,
            ),
            column(
              uiOutput("selectize_casesSince100th"),
              width = 3
            ),
            column(
              checkboxInput("checkbox_logCaseEvolution100th", label = "Logaritmik", value = FALSE),
              checkboxInput("checkbox_per100kEvolutionCountry100th", label = "Nüfusa Göre", value = FALSE),
              width = 3,
              style = "float: right; padding: 10px; margin-right: 50px"
            )
          ),
          width = 12
        )
      ),
      fluidRow(
        box(
          title = "Ülkelere göre Ýkiye katlanma süresi (Doubling Time) grafiði",
          plotlyOutput("plot_doublingTime"),
          fluidRow(
            column(
              uiOutput("selectize_doublingTime_Country"),
              width = 3,
            ),
            column(
              uiOutput("selectize_doublingTime_Variable"),
              width = 3,
            ),
            column(width = 3),
            column(uiOutput("dayGrowthRate"),
              div("",
                style = "padding-top: 15px;"),
              width = 3
            )
          ),
          width = 12
        )
      )
    )
  )
)

page_plots <- dashboardPage(
  title   = "Plots",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_plots
)