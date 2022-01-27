#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)

data = read.csv(choose.files())

stat_data = data %>% 
  group_by(Region) %>% 
  summarise(Average = mean(Output), Median = median(Output)) %>% 
  arrange(desc(Average))


# Define UI for application that draws a histogram
ui = dashboardPage(
    # Header and Title
    dashboardHeader(
        title = "EvE Universe"),
    
    dashboardSidebar(
        sidebarMenu(
            menuItem("EvE Overview", tabName = "eve_oview", icon = icon("rocket")),
            menuItem("Averages", tabName = "avg", icon = icon("calculator"))
        )
    ),
        
    dashboardBody(
        tabItems(
            tabItem("eve_oview",
                box(
                  selectInput("region", "Regions:", unique(data$Region)), width = 12),
                box(
                  selectInput("resc", "Resources:", unique(data$Resource))),
                box(dataTableOutput("eve_resc"), width = 12)
                ),
            tabItem("avg",
                    fluidPage(
                      h1("Averages and Median Outputs"),
                      box(dataTableOutput("Averages"), width = 4)
                    ))
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
 dataInput = reactive({
    data %>% filter(Region == input$region & Resource == input$resc)
 })
 
 output$eve_resc =  renderDataTable(dataInput())

 
 output$Averages = renderDataTable(stat_data)

}

# Run the application 
shinyApp(ui = ui, server = server)
