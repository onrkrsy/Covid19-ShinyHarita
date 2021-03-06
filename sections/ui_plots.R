body_plots <- dashboardBody(
  fluidRow(   column(uiOutput("selectedCountry"),width=12), width=12),
 
  fluidRow(
    fluidRow(
      fluidRow(
        box(
          title = "Vaka say�s�n�n zamana ba�l� de�i�imi",
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
          column( tags$div("*Aktif hasta say�s� ayn� g�n i�inde ki toplam say� ile iyile�en say� aras�ndaki fark ile bulunmaktad�r.",tags$br(),tags$br()),
                  width = 9,
                  style = "float: right; padding: 10px; margin-right: 50px"
          ),
          width = 6
        )
      ),
      fluidRow(
        box(
          title = "Kar��la�t�rma grafi�i (*Vaka say�s� en y�ksek 5 �lke ile se�ilen �lkenin kar��la�t�r�lmas�)",
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
              checkboxInput("checkbox_per100kEvolutionCountry100th", label = "N�fusa G�re", value = FALSE),
              width = 3,
              style = "float: right; padding: 10px; margin-right: 50px"
            )
          ),
          width = 12
        )
      ),
      fluidRow(
        box(
          title = "�lkelere g�re �kiye katlanma s�resi (Doubling Time) grafi�i",
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