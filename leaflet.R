install.packages("leaflet") 
install.packages("maps")
library(leaflet)
library(maps)
library(TeachingDemos)
library(ggplot2)
char2seed("Professor Looney")
dF <- read.csv("leafletData30.csv.csv")
dF2 <- read.csv("leafletData500.csv.csv")
cities <- read.csv("cities.csv.csv")

#leaflet() creates#addTiles() adds mapping data from "open street map"
# %>%: "piping notation" takes an output and adds onto the next command
# as the first argument, and reassign it to the variable
# create a simple map
my_map <- leaflet() %>% 
  addTiles()
my_map

#adding different types of maps ono my_map
map <- my_map %>%
  addMarkers(lat-44.4764,lng=73.1955,popup="Bio381 Classroom")
map

df <- data.frame(lat=runif(20, min=44.4770,max=44.4793),lng=runif(20,min=-73.18788,max=73.18788))
head(df)

df %>%
  leaflet() %>%
  addTo;es() %>%
  addMarkers()

mapStates <- map("state, fill=TRUE,plot=FALSE)
leaflet(data=mapStates) %>%
addTiles() %>%
addPolygons(fillColor=topo.colors(10
