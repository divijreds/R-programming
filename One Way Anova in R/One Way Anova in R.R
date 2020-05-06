#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("One Way Anova"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            fileInput("file1","Choose CSV File",
                      multiple = FALSE,
                      accept = c("text/csv",
                                 "text/comma-seperated-values,text/plain",
                                 ".csv")
            )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("divij1"),
            verbatimTextOutput("divij2"),
            verbatimTextOutput("divij3"),
            plotOutput("divij4")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    df <- reactive(read.csv(input$file1$datapath))
    
    output$divij2 <- renderPrint({
        Mileage <- df()$Mileage
        Brands <- df()$Brands
        abc <- aov(Mileage~Brands)
        summary(abc)
    })
    
    output$divij1 <- renderTable({
        df()
    })

    output$divij3 <- renderPrint({
        Mileage <- df()$Mileage
        Brands <- df()$Brands
        abc <- aov(Mileage~Brands)
        summary(abc)
        TukeyHSD(abc, conf.level = 0.99)
    })
    
    output$divij4 <- renderPlot({
        Mileage <- df()$Mileage
        Brands <- df()$Brands
        abc <- aov(Mileage~Brands)
        plot(TukeyHSD(abc,conf.level = 0.99),las=1, col = "red")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
