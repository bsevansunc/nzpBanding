library(shiny)
library(dplyr)
library(tidyr)
library(leaflet)


netPoints <- data.frame(
  pt = c(6,4,5,7,8,9),
  ptType = c(rep('net', 3), 'banding', 'net', 'net'),
  ptName = c('visitorCenter2', 'visitorCenter1','sloth1',
             'bStationElephant', 'elephant1', 'amerTrail1'),
  long = c(-77.05437,-77.05498,-77.05482,-77.05103,-77.05055,-77.04972),
  lat = c(38.93101,38.93030,38.92976,38.93131,38.93048,38.92928)
)

function(input, output) {
  # Set color pallete:
  
  pal <- colorFactor(c("navy", "red"), domain = c("net", "banding"))
  
  # Generate map:
  map <- leaflet(data = netPoints) %>%
    addTiles() %>%
    addCircleMarkers(~long, ~lat,
                     radius = ~ifelse(ptType == 'net', 6, 10),
                     col = ~pal(ptType),
                     stroke = FALSE,
                     fillOpacity = 0.8,
                     popup = ~as.character(ptName))
  output$zooMap <- renderLeaflet(map)
}