library(leaflet)
library(shiny)
shinyUI(fluidPage(
    
  titlePanel("Air Pollution in India (2010)"),
  
  sidebarLayout(
    sidebarPanel(
       selectInput("select", "Select Air Pollutant", 
                   c("PM10" = "PM10", "NO2" = 2, "SO2" = 3), selected = "PM10")
    ),
    mainPanel(
        h3("All averages in micro gram/m3"),
       leafletOutput("airplot")
    )
  )
))