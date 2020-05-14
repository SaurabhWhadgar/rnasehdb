library(shiny)
library(DT)
library(dplyr)
source("global.r")
server <- function(input, output, session) { 
  
  
 # output$seq_num <- renderInfoBox({
    #infoBox("Total Sequences", paste0(4000,"+ Number of sequences uploaded"), icon=icon("list"), color="teal",fill = TRUE)})
    
   # tax_result<- DT::renderDataTable(
    # rnadata[rnadata$taxname==input$taxname,],escape=FALSE,server = FALSE,options = list(scrollX = TRUE))
    
    output$search <- DT::renderDataTable({
      if(input$query == "accsid"){
        datatable(rnadata[rnadata$accsid==input$accsid,],escape=FALSE,options = list(scrollX = TRUE))
      }
      
      else if(input$query == "taxname"){
        datatable(rnadata[rnadata$taxname==input$taxname,],escape=FALSE,options = list(scrollX = TRUE))
      }   
      
      else if(input$query == "genus"){
        datatable(rnadata[rnadata$genus==input$genus,],escape=FALSE,options = list(scrollX = TRUE))
      } 
      
      else if(input$query == "clusttype"){
        datatable(rnadata[rnadata$clusttype==input$clusttype,],escape=FALSE,options = list(scrollX = TRUE))
      } 
      else if(input$query == "clustname"){
        datatable(rnadata[rnadata$clustname==input$clustname,],escape=FALSE,options = list(scrollX = TRUE))
      } 
    }) 
  
    
#     uiOutput('columns')
#    
# server = function(input, output){
#   output$columns <- renderUI({
#     mydata <- get(input$data)
#     selectInput('columns2', 'Columns', names(mydata))
   
    
    output$clustchoice <-  renderUI({
    selectInput("query_clustname",choices =rnadata[rnadata$clusttype,15 ])})
#   }
#     
    # 
    clustchoice <-reactive({
      rnadata[rnadata$clusttype==input$query_clusttype,15]
      #rnadata$clustname
    })
    observe({
      updateSelectInput(session,"query_clustname",choices = clustchoice())
    })

    genuschoice <-reactive({
      rnadata[rnadata$clustname==input$query_clustname,5]
      #rnadata$clustname
    })
    observe({
      updateSelectInput(session,"query_genusname",choices = genuschoice())
    }) 
    
   taxchoice <-reactive({
      rnadata[rnadata$genus==input$query_genusname,3]
      #rnadata$clustname
    })
    observe({
      updateSelectInput(session,"query_taxname",choices = taxchoice())
      
    }) 
    
    observe({
      output$query_table<- DT::renderDataTable(rnadata[which(rnadata$taxname == input$query_taxname & rnadata$clustname==input$query_clustname & rnadata$clusttype==input$query_clusttype ),],server = FALSE,options = list(scrollX = TRUE))
    })
    # output$query_table <- reactive({
    #   DT::renderDataTable(session,rnadata[rnadata$taxname == input$query_taxname,],server = FALSE,options = list(scrollX = TRUE))})
   
    
    
    # outVar <- reactive({
    #   mydata <- get(input$query_clusttype)
    #   #names(mydata)
    # })
    # observe({
    #   updateSelectInput(session, "Cols",choices = outVar()
    #   )})
    
    # rt1<-reactive({
    #   out1=data.frame(rnadata[rnadata$clustname==input$clustname,],escape=FALSE,options = list(scrollX = TRUE))
    #   })
    # 
    # output$hot3 <-DT::renderDataTable(
    #  rt1())
    # 
    # output$count <-renderText(dim(out1))
  
}



