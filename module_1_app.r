library(shiny)
library(ggplot2)
library(rlang)  # For tidy evaluation

# Define the UI module
plot_UI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(
      inputId = ns("selected_col"),
      label = "Select column",
      choices = colnames(mtcars)
    ),
    plotOutput(ns("plot"))
  )
}

# Define the server module
plot_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlot({
      req(input$selected_col)  # Ensure a column is selected
      ggplot(mtcars, aes(x = !!sym(input$selected_col), y = mpg)) +
        geom_point()
    })
  })
}

# Main UI
ui <- fluidPage(
  plot_UI("module_1")
)

# Main server function
server <- function(input, output, session) {
  plot_server("module_1")
}

# Run the app
shinyApp(ui, server)
