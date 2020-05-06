#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
# Define UI for application that draws a histogram
ui <- fluidPage(
            textInput("name","Name",""),
            textInput("enroll_no","Enrollment No",""),
            textInput("branch","Branch",""),
            passwordInput("pass","Password"),
            checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
            sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
            actionButton("submit", label = "test"),
            verbatimTextOutput("ab"),
            verbatimTextOutput("ac")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    con <- DBI::dbConnect(RMySQL::MySQL(), user="root", password="", server="localhost", dbname="test")
    
    aa <- eventReactive(input$submit,{
        name <- input$name
        enroll_no <- input$enroll_no
        branch <- input$branch
        a <- sprintf("INSERT into r_form VALUES(\'%s\',\'%s\',\'%s\')",name,enroll_no,branch)
        DBI::dbSendQuery(con, a)
        DBI::dbDisconnect(con)
    })
    
    output$ab <- renderText({
        aa()
    })
    
    bb <- eventReactive(input$submit,{
        con <- DBI::dbConnect(RMySQL::MySQL(), user="root", password="", server="localhost", dbname="test")
        tableData <- DBI::dbGetQuery(con,"SELECT * FROM r_form")
        print(tableData)
        DBI::dbDisconnect(con)
    })
    
    output$ac <- renderPrint({
        bb()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
