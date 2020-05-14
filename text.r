library(shiny)
library(shinydashboard)
source("global.r")

ui <- dashboardPage(
  dashboardHeader(title = "Dynamic selectInput"),
  dashboardSidebar(
    sidebarMenu(
      menuItemOutput("menuitem")
    )
  ),
  dashboardBody(
    selectInput("heir1","Heirarchy1",c("NONE",unique(rnadata[['accsid']])),selected="NONE"),
    selectInput("heir2","Heirarchy2",unique(rnadata[['accsid']])),
    selectInput("heir3","Heirarchy3",unique(rnadata[['accsid']]))
  )
)

server <- function(input, output, session) {
  output$menuitem <- renderMenu({
    menuItem("Menu item", icon = icon("calendar"))
  })
  
  heirarchy<-unique(rnadata[['accsid']])
  
  observe({
    hei1<-input$heir1
    hei2<-input$heir2
    hei3<-input$heir3
    
    choice1<-c("NONE",setdiff(heirarchy,c(hei2,hei3)))
    choice2<-c("NONE",setdiff(heirarchy,c(hei1,hei3)))
    choice3<-c("NONE",setdiff(heirarchy,c(hei1,hei2)))
    
    updateSelectInput(session,"heir1",choices=choice1,selected=hei1)
    updateSelectInput(session,"heir2",choices=choice2,selected=hei2)
    updateSelectInput(session,"heir3",choices=choice3,selected=hei3)
    
  })
  
}

shinyApp(ui, server)