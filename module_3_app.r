library(shiny)
library(DT)
library(dplyr)
data(diamonds, package = "ggplot2")

# UI for the table module
table_UI <- function(id, dataset) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("summary_column"),
      label = "Summary based on:",
      choices = colnames(dataset)
    ),
    DTOutput(ns("table"))
  )
}

# Server function for the table module
table_server <- function(id, dataset, summary) {
  moduleServer(id, function(input, output, session) {
    table_data <- reactive({
      if (summary()) {
        data <- dataset %>%
          group_by(!!sym(input$summary_column)) %>%
          summarise(counts = n())
      } else {
        data <- dataset
      }
      data
    })
    
    output$table <- renderDT({
      datatable(table_data())
    })
  })
}

# Main application UI
ui <- fluidPage(
  checkboxInput("summary", "Show summary", value = FALSE),
  table_UI("mtcars", mtcars),
  table_UI("diamonds", diamonds),
  table_UI("CO2", CO2)
)

# Main server function
server <- function(input, output, session) {
  summary_reactive <- reactive({ input$summary })
  
  table_server("mtcars", mtcars, summary_reactive)
  table_server("diamonds", diamonds, summary_reactive)
  table_server("CO2", CO2, summary_reactive)
}

# Run the Shiny app
shinyApp(ui, server)
