#shiny allows you to create interactive apps in R

#shiny apps contained in a single script file called app.R

#app.R have three components
#ui - user interface object
#server - server function
#a call to the shinApp function

#-------------------------
#Preliminaries
library(shiny)
library(RColorBrewer)
library(shinythemes)
library(ggplot2)

d <- mpg
str(d)

ui <- fluidPage(
  
  #choose a theme
  theme=shinytheme("united"),
  
  #give our app a title
  titlePanel("Miles Per Gallon"),
  
  #Create a sidebar for inputs
  sidebarLayout(position="right",
                sidebarPanel(
                  h3("Choose your inputs"),
                  
                  #create our widgets for choosing inputs
                  selectInput("mpgtype","MPG Standard",c("Highway"="hwy","City"="cty")),
                  selectInput("variable","Variable",c("Manufacturer"="manufacturer","Year"="year","Fuel Type"="fl","Class"="class"))),
                mainPanel(
                  h3(textOutput("caption"),align="center"),
                  plotOutput("mpgPlot")
                )
  )
)

server <- function(input,output){
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

