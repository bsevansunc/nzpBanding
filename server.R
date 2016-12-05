library(shiny)
library(dplyr)
library(tidyr)
library(leaflet)


netPoints <- data.frame(
  pt = c(6,4,5,7,8,9,10,11,12,13,14),
  ptType = c(rep('net', 3), 'banding', rep('net', 7)),
  ptName = c('visitorCenter2', 'visitorCenter1','sloth1',
             'bStationElephant', 'elephant1', 'amerTrail1',
             'smbc2', 'smbc3','smbc4', 'vet1', 'smbc1'),
  long = c(-77.05437,-77.05498,-77.05482,-77.05103,-77.05055,-77.04972,
           -77.04756, -77.04752,-77.04765,-77.04846,-77.04744),
  lat = c(38.93101,38.93030,38.92976,38.93131,38.93048,38.92928,
          38.92617,38.9262,38.92627,38.92723,38.92599)
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