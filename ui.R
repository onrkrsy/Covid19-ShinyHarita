
library("shinydashboard")

#if(!require(shinythemes)) install.packages("shinythemes", repos = "http://cran.us.r-project.org")
library("shinythemes")
source("sections/ui_overview.R", local = TRUE)
source("sections/ui_plots.R", local = TRUE)
source("sections/ui_about.R", local = TRUE)

ui <- fluidPage(
  title = "COVID-19 Takip",theme = shinytheme("flatly"),
 
  tags$style(type = "text/css", ".container-fluid {padding-left: 0px; padding-right: 0px !important;}"),
  tags$style(type = "text/css", ".navbar {margin-bottom: 0px;}"),
  tags$style(type = "text/css", ".content {padding: 0px;}"),
  tags$style(type = "text/css", ".row {margin-left: 0px; margin-right: 0px;}"),
  tags$style(HTML(".col-sm-12 { padding: 5px; margin-bottom: -15px; }")),
  tags$style(HTML(".col-sm-6 { padding: 5px; margin-bottom: -15px; }")),
  navbarPage(
    title       = div("COVID-19 Takip - Grafikler", style = "padding-left: 10px"),
    collapsible = TRUE,
    fluid       = TRUE,

    tabPanel("Dünya'da Durum", page_overview, value = "page-overview"),
    tabPanel("Grafikler", page_plots, value = "page-plots"),
 
    tabPanel("Hakkında", page_about, value = "page-about"),
 
    tags$script(HTML("var header = $('.navbar > .container-fluid');
    header.append('');
    ")
    )
  )
)