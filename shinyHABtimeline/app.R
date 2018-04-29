#shinyHABtimeline
#29 April 2018
# DMH

library(shiny)
library(timevis)

#Copy from last timeline
timedata <- read.csv("timeline_example.csv", header=TRUE,sep=",")
groups <- data.frame(
  id=c("N","SP","NP","LP","TMDL"),
  content=c("News","State Policy","National Policy","Local Policy","TMDL"),
  style=c("background-color:lightblue;","background-color:plum;","background-color:pink;","background-color:khaki;","background-color:coral;"))


ui <- fluidPage(
  headerPanel('History of Cyanobacteria Blooms in St. Albans Bay'),
  sidebarPanel(  
    h3("Add item:"),
    textInput("addText", tags$h4("Add content:"),"content"),
    selectInput("Group",tags$h4("Choose Group:"),c("News"="N","State Policy"="SP","National Policy"="NP","Local Policy"="LP","TMDL"="TMDL")),
    dateInput("addDate", tags$h4("Input Date"), "2016-01-15"),
    actionButton("addBtn", "Add")),
  mainPanel(timevisOutput("timeline"))
)


server <- function(input, output, session) {
  output$timeline <- renderTimevis({
    timevis(timedata,groups=groups,
            options=list(editable=TRUE,verticalScroll=TRUE,
                         horizontalScroll=TRUE,moveable=TRUE,
                         zoomCtrl=TRUE,maxHeight="500px"))})
    observeEvent(input$addBtn, {
      addItem("timeline",
              data = list(
                content = input$addText,
                start = input$addDate,
                group = input$Group))
      })
}

shinyApp(ui = ui, server = server)