#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggpubr)
# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Data visualization in R!"),
    
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("divij1"),
            plotOutput("divij2"),
            plotOutput("divij3"),
            verbatimTextOutput("divij4")
        )
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- reactive(read.csv(input$file1$datapath))
    
    output$divij1 <- renderPlot({
        x <- c(13,3,9,6,3,1)
        y <- c("GATE","MANAGEMENT","DATA SCIENCE","PROGRAMMING","MATHEMATICS","OTHERS")
        pct <- round(x/sum(x)*100)
        y <- paste(y, pct)
        y <- paste(y,"%",sep="")
        pie(x,labels=y,col=rainbow(length(y)),
            main="Pie Chart of Subjects")
    })
    output$divij2 <- renderPlot({
        Marks <- data.frame(
            a = c("Sem 1","Sem 2","Sem 3","Sem 4"),
            b = c(7.6,8.0,7.7,7.8))
        ggbarplot(Marks,x="a",y="b",
                  fill = "cyan", 
                  xlab = "Semester", ylab = "SGPA",
                  x.text.angle = 45 
        )
    })
    output$divij3 <- renderPlot({
        Marks <- data.frame(
            a = c("Sem 1","Sem 2","Sem 3","Sem 4"),
            b = c(7.6,8.0,7.7,7.8))
        boxplot(Marks$b)
    })
    
    output$divij4 <- renderPrint({
      print("Conclusion")
        br()
        print("1.) PIE CHART: From the Pie Chart, we conclude that the maximum subjects offered are of GATE, So the student can pursue his Career into Computer Science Engineering followed by Data Science")
        print("2.) BAR GRAPH: From the Bar Graph, we can have an estimate about the student's performance in each Semester")
        print("3.) BOX PLOT: From the Box Plot, we see that the Median is in the middle, so we can say that the data is Symmetric")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
