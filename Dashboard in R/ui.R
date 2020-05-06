library(shiny)
library(shinydashboard)
require(ggplot2)
library(plotly)

shinyUI(dashboardPage(title = "Dashboard sample" ,skin="green",
            dashboardHeader(title = "Dashboard sample",
            dropdownMenu(type ="message",
            messageItem(from="Finance update",message="we are on threashold"),
            messageItem(from="sales update",message="we are on threashold")
            ),
            dropdownMenu(type = "notifications",
            notificationItem(
                text="2 new tabs added to the dashboard",
                icon=icon("dashboard"),
                status = "success"
       )
    )
),
    dashboardSidebar(
       sidebarMenu(
        menuItem("Dashboard",tabName = "dashboard",icon=icon("dashboard")),
        menuSubItem("Dashboard sales",tabName = "finance")
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "dashboard",
            fluidRow(
                infoBox("sales Count",1244,icon=icon("thumbs-up"),color="green")
                    ),
            fluidRow(
                valueBox(15*80,"Bugdet 10 days",icon = icon("wallet"),color="red")
                    ),
            fluidRow(
                box(title = "Histogram of faithful",status = "primary",solidHeader = T,box(plotOutput("Hist"),width="100")
                    ),
                box(title = "control for header")
                    )
                                       
            ),
            tabItem(
                tabName = "finance",h1("Finance Dashboard"),
                plotlyOutput("plot"),
                verbatimTextOutput("event")
            ),
            tabItem(
                tabName = "sales",h1("Sales Dashboard"),
                plotlyOutput("salesOut")
            )
      
     )
     )
    )
)
