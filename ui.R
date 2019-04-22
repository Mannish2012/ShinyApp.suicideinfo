library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Presenting suicide data by shiny and ggplot2"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    
    radioButtons("rb1", "Sex:", c(levels(suicide.data$sex))),
    radioButtons("rb2", "Generation:", c(levels(suicide.data$generation)))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      tableOutput("distTable")
      #textOutput("distText1")
      
    )
  )
)
