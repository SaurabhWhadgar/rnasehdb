rm(list = ls())
library(shiny)
runApp(list(
  ui = bootstrapPage(
    selectInput('data', 'Data', c('mtcars', 'iris')),
    selectInput('Cols', 'Columns', "")
  ),
  server = function(input, output,session){
    
    outVar <- reactive({
      mydata <- get(input$data)
    # mydata[,2]
      names(mydata)
    })
    observe({
      updateSelectInput(session,"Cols",choices = outVar()
      )})
  }
))
