#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(car)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Two Way Anova"),
    
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
            verbatimTextOutput("divij3")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    df <- reactive(read.csv(input$file1$datapath))
    
    output$divij2 <- renderPrint({
        weight <- df()$weight
        group <- df()$group
        abc <- aov(weight~group)
        Anova(abc, type = "III")
    })
    
    output$divij1 <- renderTable({
        df()
    })
    
    output$divij3 <- renderPrint({
        weight <- df()$weight
        group <- df()$group
        bartlett.test(weight~group,PlantGrowth)
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
