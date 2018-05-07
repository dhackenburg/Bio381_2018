# Shiny example
#2 May 2018
#DMH

#Shiny allows you to create interactive apps in R

#shiny apps are contained in a single script called app.R
#script lives in its own directort
#app can be run with runApp("directory")

#app.R has three components:
#ui - user interface object
#server - server function
#a call to the shinyApp function

#Preliminaries
library(shiny)
library(RColorBrewer)
library(shinythemes)
library(ggplot2)

#load mpg dataset
d <- mpg
str(d)

#build our user interface
#controls the layout and appearance of the app
#fluidpage, fixedpage, navbarpage, or fluidRow or fluidColumn

ui <- fluidPage(
  
  #choose a shiny theme
  theme=shinytheme("united"),
  
  #give our app a title
  titlePanel("Miles Per Gallon"),
  
  #Create a sidebar for inpus
  sidebarLayout(position="right",
                sidebarPanel(
                  #Give the it a name
                  h3("Choose your inputs"),
                  #create widgets for choosing inputs
                  
                  selectInput("mpgtype","MPG Standard",
                              c("Highway"="hwy","City"="city")),
                  selectInput("variable","Variable:",
                              c("Manufacturer"="manufacturer",
                                "Year"="year",
                                "Fuel Type"="fl",
                                "Class"="class"))),
                mainPanel(
                  h3(textOutput("caption"),
                     align="center"),
                  plotOutput("mpgPlot")
                )
  )
)
  
server <- function(input,output){
  #a reactive expression uses the widget inputs to reutrn a value
  #updates value whenever widget changes
  formulaText <- reactive({
    if (input$mpgtype=="hwy")
      paste("hwy~",input$variable)
    else
      paste("cty~",input$variable)
  })
  output$caption <- renderText({formulaText()})
  output$mpgPlot <- renderPlot({
    par(mar=c(6,6,0,0))
    boxplot(as.formula(formulaText()),data=d,las=2,col=brewer.pal(n=8,name="Set2"),pch=19,xlab="",ylab="")
    mtext(input$variable,side=1,line=5,font=2)
    mtext(c("(mpg)",input$mpgtype),side=2,line=3:4,font=2)
  })
}

shinyApp(ui,server)