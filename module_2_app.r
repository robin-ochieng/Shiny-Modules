library(shiny)
library(dplyr)
library(DT)
library(ggplot2)

# UI for the module
table_UI <- function(id, dataset) {
  ns <- NS(id)
  tagList(
    checkboxInput(
      inputId = ns("summary"),
      label = "Show summary",
      value = FALSE
    ),
    selectInput(
      inputId = ns("summary_column"),
      label = "Summary based on:",
      choices = colnames(dataset)
    ),
    DTOutput(ns("table"))
  )
}

# Server logic for the module
table_server <- function(id, dataset) {
  moduleServer(id, function(input, output, session) {
    table_data <- reactive({
      if (input$summary) {
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

# Main application code
ui <- fluidPage(
  table_UI("diamonds", diamonds),
  table_UI("mtcars", mtcars)
)

server <- function(input, output, session) {
  table_server("diamonds", diamonds)
  table_server("mtcars", mtcars)
}

# Run the application
shinyApp(ui, server)
