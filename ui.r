library(shiny)
library(shinydashboard)
source("global.r")

ui <- dashboardPage(skin = "purple",
                    dashboardHeader(title = "RNasesHDB",
                                    dropdownMenu(type = "notifications",icon = icon("question-circle"),
                                      badgeStatus = NULL,headerText = "See also:",
                                      
                                      ## Notification item   
                                      
                                      notificationItem("About Project", icon = icon("file"),
                                                       href = "http://shiny.rstudio.com/"),
                                      notificationItem("IBAB", icon = icon("file"),
                                                       href = "https://ibab.ac.in") 
                                      ), #dropdown notification close 
                                    
                                    dropdownMenu(
                                      type = "messages", #icon = icon("question-circle"),
                                      badgeStatus = NULL, headerText = "See also:",
                                      messageItem(from = "Admin",message = "RNasesH database is Reday to use."))
                    ),# dropdown notification messages close
                    
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Home", tabName = "dashboard", icon = icon("dashboard")),
                        menuItem("Cluster", tabName = "cluster", selected = TRUE, icon = icon("th")),
                        menuItem("Download", tabName = "download", icon = icon("th")),
                        menuSubItem("Sequences", tabName = "seq", href = NULL, newtab = TRUE,
                                    icon = shiny::icon("angle-double-right"), selected = NULL),
                        menuSubItem("ALL", tabName = "all", href = NULL, newtab = TRUE,
                                    icon = shiny::icon("angle-double-right"), selected = NULL)
                    ) # sidebarMenu close
                    ),#dashboardsidebar close
                    
                    
                    dashboardBody(
                      tabItems(
                        # First tab content
                        tabItem(tabName = "dashboard",
fluidRow(
                                  infoBox("Type of Cluster",12,
                                  icon = icon("list")),
                                  infoBox("Number of Organism",5383,
                                          icon = icon("signal", lib = "glyphicon")),
                                  infoBox("Workdone","40%",
                                          icon = icon("thumbs-up", lib = "glyphicon"))
                                  #infoBoxOutput("seq_num")
                                  # infoBoxOutput("prgressBox")
                                ),

                        
 fluidRow(
                          box(title="Search By", collapsible = TRUE, status="success", solidHeader=TRUE, width=6,  
                           selectInput("query", "Search By",
                                c(AccesionID = "accsid",
                                  Organism = "taxname",Genus ="genus", ClusterType="clusttype",ClusterName="clustname" ))),
                          
                          box(title="Select", collapsible = TRUE, status="warning", solidHeader=TRUE, width=6, 
                              # Only show this panel if the query is accsid
                              conditionalPanel(
                                condition = "input.query == 'accsid'",
                                      selectInput(inputId = 'accsid',
                                              label = 'Enter Accession ID',
                                              choices = unique(rnadata[['accsid']]))),
                              
                                # Only show this panel if the query is accsid
                                conditionalPanel(
                                  condition = "input.query == 'taxname'",
                                  selectInput(inputId = 'taxname',
                                              label = 'Enter Organism Name',
                                              choices = unique(rnadata[['taxname']]))),

                              
                              conditionalPanel(
                                condition = "input.query == 'clusttype'",
                                selectInput(inputId = 'clusttype',
                                            label = 'Enter Cluster Type',
                                            choices = unique(rnadata[['clusttype']]))),
                              
                              conditionalPanel(
                                condition = "input.query == 'genus'",
                                selectInput(inputId = 'genus',
                                            label = 'Enter Genus Name',
                                            choices = unique(rnadata[['genus']]))),
                              
                              conditionalPanel(
                                condition = "input.query == 'clustname'",
                                selectInput(inputId = 'clustname',
                                            label = 'Enter Cluster Name',
                                            choices = unique(rnadata[['clustname']])))
 )),

fluidRow(                                  
  box(title="Search Result", collapsible = TRUE, status="success", solidHeader=TRUE,width=12, footer = "Expression of each mirna in different stage
                      of B Cell", DT::dataTableOutput("search")))),

#fluidRow(                                  
 # box(title="Result", collapsible = TRUE, status="success", solidHeader=TRUE,width=12,# footer = textOutput(count),
   #                   DT::dataTableOutput("hot3")))            
#fluidRow(box(title="Result", collapsible = TRUE, status="success", solidHeader=TRUE,width=12,textOutput(count)))
                      



  # First tab content
  tabItem(tabName = "cluster",
          fluidRow(
            box(title="Search Cluster Type", collapsible = TRUE, status="success", solidHeader=TRUE, width=4,
                          selectInput(inputId = 'query_clusttype',
                          label = 'Enter Cluster Type',
                          choices = unique(rnadata[['clusttype']]))),

          # box(title="Select Cluster Name", collapsible = TRUE, status="warning", solidHeader=TRUE, width=4, 
          #     # Only show this panel if the query is accsid
          #       selectInput(inputId = 'query_clustname',
          #                   label = 'Enter Cluster Name',
          #                   choices = "")),
          # 
          box(title="Search Cluster Type", collapsible = TRUE, status="success", solidHeader=TRUE, width=4,
                        selectInput(inputId = 'query_clustname',
                        label = 'Enter Cluster Type',
                        choices = "")),

          
          box(title="Select Genus", collapsible = TRUE, status="warning", solidHeader=TRUE, width=4, 
              # Only show this panel if the query is accsid
              selectInput(inputId = 'query_genusname',
                          label = 'Enter Genus Name',
                          choices = "")),
          
          box(title="Select Organism ", collapsible = TRUE, status="warning", solidHeader=TRUE, width=12, 
              # Only show this panel if the query is accsid
              selectInput(inputId = 'query_taxname',
                          label = 'Enter Organism Name',
                          choices = "")
          )
          
          
          ),
          fluidRow(
            box(title="Search Cluster Type", collapsible = TRUE, status="success", solidHeader=TRUE, width=12,
                DT::dataTableOutput("query_table"))),
          uiOutput('clustchoice')
          
)),


tags$footer(HTML('<p><center>Institute of Bioinformatics And Applied Biotechnology<center><p>'), align = "center", style = "
              position:absolute;
              bottom:-25px;
              width:100%;
              height:50px;   /* Height of the footer */
              color: white;
              padding: 0px;
              background-color: black;
              z-index: 1000;")

                    
)
)