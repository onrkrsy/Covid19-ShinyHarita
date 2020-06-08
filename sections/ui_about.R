body_about <- dashboardBody(
  fluidRow(
    fluidRow(
      column(
        box(
          title = div("Hakkýnda", style = "padding-left: 20px", class = "h2"),
          column(
        
            h3("Veriler"), 
            tags$div(
              tags$span(tags$b("Covid 19 verileri:"), tags$a(href = "https://github.com/CSSEGISandData/COVID-19",
                "Johns Hopkins CSSE")),
              tags$br(),
              tags$span(tags$b("Nüfus Verileri:"), tags$a(href = "https://data.worldbank.org/indicator/SP.POP.TOTL",
                "The World Bank"))
            ), 
            width = 12,
            style = "padding-left: 20px; padding-right: 20px; padding-bottom: 40px; margin-top: -15px;"
          ),
          width = 12,
        ),
        width = 12,
        style = "padding: 15px"
      )
    )
  )
)


page_about <- dashboardPage(
  title   = "About",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_about
)