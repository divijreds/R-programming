#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("MULTIPLE LINEAR REGRESSION!!!"),
    
    # Show a plot of the generated distribution
    mainPanel(
        verbatimTextOutput("divij1"),
        verbatimTextOutput("divij2")
    )
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$divij2 <- renderPrint({
        data("marketing", package = "datarium")
        model1 <- lm(sales ~ youtube + facebook + newspaper, data = marketing)
        summary(model1)$coefficient
    })
    
    output$divij1 <- renderPrint({
        data("marketing", package = "datarium")
        model1 <- lm(sales ~ youtube + facebook + newspaper, data = marketing)
        summary(model1)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
