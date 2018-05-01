install.packages("leaflet")
library(leaflet)
leaflet() %>%
  addTiles() %>%
  addMarkers(lat=44.79815, lng=-73.1504,label="St. Albans Bay", labelOptions = labelOptions(noHide = T))
my_map
