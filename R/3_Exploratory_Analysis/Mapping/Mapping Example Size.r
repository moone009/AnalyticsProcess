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




library(ggmap)
library(scales)
library(zipcode)
library(ggplot2)
library(dplyr)
library(plyr)

df <- read.table(header = TRUE, text = "
subjectid   location           disease
12          'Naperville,il'         yes
15          'Chicago,IL'          no
13          'Lake Forest,IL'  yes
85          'Lake Forest,IL'  yes
46          'Naperville,il'         yes
569         'Chicago,IL'          yes
825         'Lake Forest,IL'  yes
685         'Naperville,il'         no
54          'Lake Forest,IL'  no
214         'Naperville,il'         no
214         'Orland Park,il'         no
214         'Orland Park,il'         no
214         'Downers Grove,il'         no
214         'Downers Grove,il'         no
214         'Downers Grove,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
125         'Lake Forest,IL'  yes
569         'Chicago,IL'          no", stringsAsFactors = FALSE)

# Get geographic locations and merge them into the data file
geoloc <- geocode(unique(df$location))
pos <- data.frame(location = unique(df$location), geoloc, stringsAsFactors = FALSE)
df <- merge(df, pos, by = "location", all = TRUE)

df = rbind(df,df,df,df,df)

# Summarise the data file
df = ddply(df, .(location, lon, lat), summarise, 
           countDisease = sum(ifelse(disease == "yes", 1, 0)),
           countTotal = length(location))

map <- get_map(location = 'chicago,il', zoom = 9)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat,size = 50)) 


ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countTotal)) +
  scale_size(range = c(1, 5))


ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countTotal)) +
  scale_size(range = c(1, 5)) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")





library(RCurl)
x <- getURL('https://raw.githubusercontent.com/moone009/AnalyticsProcess/master/R/SampleData/MapData.csv')
MapData <- read.csv(text = x)

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





























