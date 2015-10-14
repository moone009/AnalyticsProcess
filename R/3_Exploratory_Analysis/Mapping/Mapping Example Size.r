#########################################################################################################
# Name             : Mapping Example.r
# Date             : 08-26-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : For Fun
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150826              initial
########################################################################################################


# load libraries
library(ggmap)
library(scales)
library(zipcode)
library(ggplot2)
library(dplyr)
library(plyr)
library(RCurl)

# Very useful: https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/ggmap/ggmapCheatsheet.pdf
# Very useful: http://stackoverflow.com/questions/30178954/dynamic-data-point-label-positioning-in-ggmap


##_____________________________________________________________________________________________________________________________

x <- getURL('https://raw.githubusercontent.com/moone009/AnalyticsProcess/master/R/SampleData/BasicMapping.csv')
df <- read.csv(text = x)

df$location =as.character(df$location)

# Get geographic locations and merge them into the data file
geoloc <- geocode(unique(df$location))
pos <- data.frame(location = unique(df$location), geoloc, stringsAsFactors = FALSE)
df <- merge(df, pos, by = "location", all = TRUE)

df = rbind(df,df,df,df,df)

# Summarise the data file
df = ddply(df, .(location, lon, lat), summarise, 
           countDisease = sum(ifelse(disease == "yes", 1, 0)),
           countTotal = length(location))
df <- unique(df)
##_____________________________________________________________________________________________________________________________
# basic map
map <- get_map(location = 'chicago,il', zoom = 9)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat)) 

ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countTotal)) +
  scale_size(range = c(1, 5))

##_____________________________________________________________________________________________________________________________
# WaterColor
map <- get_map(location = 'chicago,il', zoom = 9,maptype='watercolor')
df$label <- paste(df$location,'\nDisease Count:',df$countDisease)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countDisease)) +
  scale_size(range = c(5, 20)) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")  +
  geom_text(data = df, aes(x = lon, y = lat, fontface='bold',label = as.character(label)))

##_____________________________________________________________________________________________________________________________
# terrain
map <- get_map(location = 'chicago,il', zoom = 9,maptype='terrain')
df$label <- paste(df$location,'\nDisease Count:',df$countDisease)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countDisease)) +
  scale_size(range = c(5, 20)) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")  +
  geom_text(data = df, aes(x = lon, y = lat, fontface='bold',label = as.character(label)))

##_____________________________________________________________________________________________________________________________
# road map
map <- get_map(location = 'chicago,il', zoom = 9,maptype='roadmap')
df$label <- paste(df$location,'\nDisease Count:',df$countDisease)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countDisease)) +
  scale_size(range = c(5, 20)) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")  +
  geom_text(data = df, aes(x = lon, y = lat, fontface='bold',label = as.character(label)))



##_____________________________________________________________________________________________________________________________
# More points!

x <- getURL('https://raw.githubusercontent.com/moone009/AnalyticsProcess/master/R/SampleData/MapData.csv')
MapData <- read.csv(text = x)

##_____________________________________________________________________________________________________________________________
MapData$label <- paste(MapData$servzip,'Mtrs:',MapData$CT)
map <- get_map(location = 'milwaukee,wi', zoom = 12)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")

MapData$label <- paste(MapData$servzip,'\nMtrs:',MapData$CT)
map <- get_map(location = 'milwaukee,wi', zoom = 9)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue",high = "red", space = "Lab")

map <- get_map(location = 'milwaukee,wi', zoom = 9)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  #geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")

##_____________________________________________________________________________________________________________________________
# Plot ploygons
map <- get_map(location = 'milwaukee,wi', zoom = 8)
map <-  ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  #geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")
 
Longitude<-c(-87.754893 , -88.049413,-88.389103,-88.818616,-88.733693,-88.744947,-89.097159,-88.954165,-87.810976)
Latitude<-c(43.612874,43.610172,43.566405,43.394579,43.156775,42.970414 ,42.737608,42.501638 ,42.496822 )
mydata<-as.data.frame(cbind(Longitude,Latitude))
points<-mydata
# we select - 1 because once we map in pairs. IE once we have the last record there is nothing for that record to map to
for(i in 1:nrow(mydata)-1){
latlon <-  head(mydata,2)
map <-  map + geom_polygon(data=latlon,aes(x=Longitude,y=Latitude),alpha=0.1,size = 1,colour="green",fill="green")
mydata = mydata[-1,]
print(i)
}

# Here we take the median because otherwise the size will not show correctly
map + geom_point(data = points, aes(x = Longitude, y = Latitude,size = median(MapData$CT)))
map + geom_point(data = points, aes(x = Longitude, y = Latitude))+ scale_size_continuous(range = c(2,6))




##_____________________________________________________________________________________________________________________________
# Plot ploygons from google kml file
library(maptools)

map <- get_map(location = 'Appleton,wi', zoom = 9)
map <-  ggmap(map) + geom_point(data = MapData, 
                                aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 15))+   
  #geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")


googlemaplayer <- getKMLcoordinates(kmlfile="F:\\Untitled layer.kml", ignoreAltitude=T)

lat <-c()
lon <-c()

for(i in 1:length(googlemaplayer)){
  lon <-c(lon,googlemaplayer[[i]][1])
  lat <-c(lat,googlemaplayer[[i]][2])
  if(i == length(googlemaplayer)){mydata<-as.data.frame(cbind(lon,lat))}
}
points<-mydata
Lst <- head(mydata,1)
# we select - 1 because once we map in pairs. IE once we have the last record there is nothing for that record to map to
Stop <- nrow(mydata)-1
for(i in 1:Stop){
  
  latlon <-  head(mydata,2)
  map <-  map + geom_polygon(data=latlon,aes(x=lon,y=lat),alpha=0.1,size = 1,colour="green",fill="green")
  mydata = mydata[-1,]
  
    if(i == Stop){
      mydata <-rbind(mydata,Lst)
      print(mydata)
      map <-  map + geom_polygon(data=mydata,aes(x=lon,y=lat),alpha=0.1,size = 1,colour="green",fill="green")
    }
  print(i)
  
}
map + geom_point(data = points, aes(x = lon, y = lat,size = median(MapData$CT)))




##_____________________________________________________________________________________________________________________________
# Plot ploygons from google kml file from multiple files


map <- get_map(location = 'Milwaukee,wi', zoom = 7)
map <-  ggmap(map) + geom_point(data = MapData, 
                                aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 15))+   
  #geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")

files =c('Untitled layer','Wisconsin Service Territory')
for(f in 1:length(files)){
  googlemaplayer <- getKMLcoordinates(kmlfile=paste("F:\\",files[f],".kml",sep=''), ignoreAltitude=T)
  
  lat <-c()
  lon <-c()
  
  for(i in 1:length(googlemaplayer)){
    lon <-c(lon,googlemaplayer[[i]][1])
    lat <-c(lat,googlemaplayer[[i]][2])
    if(i == length(googlemaplayer)){mydata<-as.data.frame(cbind(lon,lat))}
  }
  points<-mydata
  Lst <- head(mydata,1)
  # we select - 1 because once we map in pairs. IE once we have the last record there is nothing for that record to map to
  Stop <- nrow(mydata)-1
  for(i in 1:Stop){
    
    latlon <-  head(mydata,2)
    map <-  map + geom_polygon(data=latlon,aes(x=lon,y=lat),alpha=0.1,size = 1,colour="green",fill="green")
    mydata = mydata[-1,]
    
    if(i == Stop){
      mydata <-rbind(mydata,Lst)
      print(mydata)
      map <-  map + geom_polygon(data=mydata,aes(x=lon,y=lat),alpha=0.1,size = 1,colour="green",fill="green")
    }
    print(i)
    
  }
  map <- map + geom_point(data = points, aes(x = lon, y = lat,size = median(MapData$CT)))
  
}



map + geom_point(data = points, aes(x = lon, y = lat,size = median(MapData$CT)))

















