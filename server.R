library(shiny)
library(dplyr)
library(ggplot2)

options(scipen = 999)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  selected <- reactive({
    filter(suicide.data, sex == input$rb1 & generation == input$rb2 ) %>%
      mutate(suicide100 = as.numeric(suicides.100k.pop))
  })
  
  output$distPlot <- renderPlot({
    ggplot(selected(), aes(y=suicides_no, x=gdp_per_capita....)) + 
      geom_point(aes(col = age), size=4, alpha = 0.5) + geom_smooth(method = "lm", col = "red") + 
      #guides(colour = guide_legend(override.aes = list(size=10))) + 
      ggtitle("Suicide vs GDP") +
      xlab("GDP per capita") + ylab("Total Suicide Number") +
      theme(plot.title = element_text(hjust = 0.5, size = 18), 
            axis.title.x = element_text(size = 16), axis.title.y = element_text(size = 16), 
            legend.title = element_text(size = 14), 
            legend.text = element_text(size = 14))
  })
  
  output$distTable <- renderTable({
    with(selected(), 
      tibble(sex = input$rb1,
      generation = input$rb2, 
      mean.suicides = round(mean(suicides_no),2),
      mean.suicides.by.100kpop = round(mean(suicide100),2)) 
      )
      
  })
  
  output$distText1 <- renderPrint({
    with(selected(), print(paste0("The mean suicides of",  sep = " ", input$rb1, sep = " ", input$rb2, 
                                 sep = " ", "is", sep = " ", round(mean(suicides_no),2))))
  })
})
