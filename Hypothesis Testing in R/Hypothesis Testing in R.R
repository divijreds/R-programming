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
    titlePanel("HYPOTHESIS TESTING!!!"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("test_type",
                        "Select Type",
                        c("One Sample Z-test" = "One Sample Z-test","Two Sample Z-test" = "Two Sample Z-test","One Sample T-test" = "One Sample T-test","Two Sample T-test" = "Two Sample T-test","Paired T-test" = "Paired T-test","ChiSquare Test" = "ChiSquare test"
                        )),
            br(),
            fileInput("file1","Choose CSV File",
                      multiple = FALSE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")
            )
        ),
        # Show a plot of the generated distribution
        mainPanel(
         tableOutput("divij1"),
         verbatimTextOutput("divij2")
        )
)

)

# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- reactive(read.csv(input$file1$datapath))
    
    output$divij2 <- renderPrint({
        x <- df()$Strength
        y <- df()$Data
        if(input$test_type == "One Sample Z-test")
            prop.test(x = 95, n = 160, p = 0.5, 
                      correct = FALSE)
        else if(input$test_type == "Two Sample Z-test")
            prop.test(x = c(490, 400), n = c(500, 500))
        else if(input$test_type == "One Sample T-test")
            t.test(x)
        else if(input$test_type == "Two Sample T-test")
            t.test(x,y)
        else if(input$test_type == "Paired T-test")
            t.test(x,y,paired = TRUE)
        else if(input$test_type == "ChiSquare test")
            chisq.test(x,y)
    })
    output$divij1 <- renderTable({
        df()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
