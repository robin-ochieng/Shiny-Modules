library(shiny)

# moduleUI.R
# Define the UI for the input module
inputModuleUI <- function(id) {
  ns <- NS(id)
  tagList(
    textInput(ns("text"), "Enter text:"),
    actionButton(ns("submit"), "Submit")
  )
}

# moduleServer.R
inputModule <- function(input, output, session) {
  # Create a reactive value to store the input text
  text_val <- reactiveVal()
  
  observeEvent(input$submit, {
    text_val(input$text)  # Set the reactive value on button click
  })
  
  # Return a list containing the reactive function
  return(list(
    getText = text_val  # This is a reactive expression function
  ))
}

ui <- fluidPage(
  # Use the module UI
  inputModuleUI("textModule1"),
  verbatimTextOutput("displayText")
)

server <- function(input, output, session) {
  # Call the module server function and store the returned values
  text_output <- inputModule("textModule1")
  
  # Use the returned reactive value in the main app
  output$displayText <- renderText({
    # Ensure getText is called correctly as a function
    if (is.null(text_output$getText())) {
      "Nothing entered yet."
    } else {
      paste("You entered:", text_output$getText())
    }
  })
}

# Run the Shiny app
shinyApp(ui, server)
