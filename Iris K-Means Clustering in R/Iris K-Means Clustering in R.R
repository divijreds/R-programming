#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

palette(c("#E41A1C","#377EB8","#4DAF4A","#984EA3",
          "#FF7F00","#FFFF33","#A65628","#F781BF","#999999"))
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    # titlePanel("IRIS K-MEAN CLUSTERING"),
    
    headerPanel("IRIS K-MEAN CLUSTERING"),
    
    # Sidebar with a slider input for number of bins 
sidebarLayout(
    sidebarPanel(
            selectInput('xcol',
                        'X variable',
                        names(iris)),
            selectInput('ycol',
                        'Y variable',
                        names(iris),
                        selected=names(iris)[[2]]),
            numericInput('clusters','Cluster count',
                         3,
                         min = 1,
                         max = 9)
),
        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot1")
        )
    )
)
# Define server logic required to draw a histogram
server <- function(input, output) {

    selectedData <- reactive({
        iris[,c(input$xcol,input$ycol)]
    })
    
    clusters <- reactive({
        kmeans(selectedData(),input$clusters)
    })
    
    output$plot1 <- renderPlot({
        par(mar=c(5.1,4.1,0,1))
        plot(selectedData(),
            col=clusters()$cluster,
            pch=20,cex=3)
        points(clusters()$centers,pch=4,cex=4,lwd=4)
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
