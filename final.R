library(leaflet)
library(readr)
library(dplyr)

data<-read.csv("C:/Users/Ju/Downloads/Dataset_imagelab - Dataset.csv")

map_data <- data %>%
  mutate(
    long = as.numeric(longitude),
    lat = as.numeric(latitude)
  )

leaflet() %>% addProviderTiles("CartoDB", group = "Light") %>% 
  addTiles(group = "Map") %>%
  setView(lng = 5.3, lat = 52.1, zoom = 8) %>%
  addMarkers(data = map_data, 
             lng = ~long,
             lat = ~lat,
             label = ~specific_location,
             popup = ~paste0(sep = "<br/>",
                             "<img src = '", data$image_link, "'width = 100>",
                             "<div>",
                             data$type,
                             "<div>",
                             "<b><a href='", data$beeldbank_link, "'>More information</a></b>"),
             clusterOptions = markerClusterOptions(spiderfyDistanceMultiplier=1,
                                                   maxClusterRadius = 40,
                                                   disableClusteringAtZoom = 14)) %>%
  addLayersControl(baseGroups = c("Light","Map"))                                               

