library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function(input, output) {
            
    air <- readRDS("data.Rda")
    
    airPM10 <- air %>% select(City, PM10_ann_avg, PM10_air_quality, lat, lng, PM10col)
    airPM10 <- airPM10 %>% filter(!is.na(PM10col))
    
    airNO2 <- air %>% select(City, NO2_ann_avg, NO2_air_quality, lat, lng, NO2col)
    airNO2 <- airNO2 %>% filter(!is.na(NO2col))
    
    airSO2 <- air %>% select(City, SO2_ann_avg, SO2_air_quality, lat, lng, SO2col)
    airSO2 <- airSO2 %>% filter(!is.na(SO2col))
    
    output$airplot <- renderLeaflet({
        if(input$select == "PM10"){
                airPM10 %>% leaflet() %>%
                    addTiles() %>%
                    addCircleMarkers(color = airPM10$PM10col,
                                     popup = paste(airPM10$City, '<br>', "PM10 Avg:",
                                                  airPM10$PM10_ann_avg)) %>%
                    addLegend(labels = c("Critical", "High", "Moderate","Low"),
                              colors = c("red","orange","yellow","green"))
        }

        else if(input$select == 2){
                airNO2 %>% leaflet() %>%
                    addTiles() %>%
                    addCircleMarkers(color = airNO2$NO2col,
                                     popup = paste(airNO2$City, '<br>', "NO2 Avg:",
                                                   airNO2$NO2_ann_avg)) %>%
                    addLegend(labels = c("Critical", "High", "Moderate","Low"),
                              colors = c("red","orange","yellow","green"))
        }

        else if(input$select == 3) {
                airSO2 %>% leaflet() %>%
                    addTiles() %>%
                    addCircleMarkers(color = airSO2$SO2col,
                                     popup = paste(airSO2$City, '<br>', "SO2 Avg:",
                                                   airSO2$SO2_ann_avg)) %>%
                    addLegend(labels = c("Critical", "High", "Moderate","Low"),
                              colors = c("red","orange","yellow","green"))

        }
    })
})
