server <- function(input, output) {
  sourceDirectory("sections", recursive = TRUE)
  
  # Trigger 
  dataLoadingTrigger <- reactiveTimer(36000000)
  
  observeEvent(dataLoadingTrigger, {
    updateData()
  })
  
  observe({
    data <- data_atDate(input$timeSlider)
  })
}