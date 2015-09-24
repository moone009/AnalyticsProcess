#########################################################################################################
# Name             : qplot examples
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
library(foreign)

##_____________________________________________________________________________________________________________________________
# Read and format SPSS File
asq <- read.spss('J:\\DATA\\CS\\Research_Data_Files\\PC Extract Files\\2015 SPSS Files\\PC Extract September 2015 - sorted.sav', 
                 to.data.frame=T)
asq <- asq[,c(1,12,13,14,39,11)]
asq$servaddr <- gsub('  ','',asq$servaddr)
asq$servaddr <- gsub('  ','',asq$servaddr)
asq$servcity <- gsub('  ','',asq$servcity)

asq$Lat <- ''
asq$Lon <- ''

asq$Lat <- as.numeric(asq$Lat)
asq$Lon <- as.numeric(asq$Lon)

##_____________________________________________________________________________________________________________________________
# GEO Code 2500 addresses

for(i in 1:3500){
 print(i)
 latlong <-  geocode(paste(asq[[6]][i],",",asq[[2]][i],",",asq[[3]][i]))
 
 #Lat
 asq[[7]][i] <- latlong[[2]][1]
 #long
 asq[[8]][i] <- latlong[[1]][1]

}

##_____________________________________________________________________________________________________________________________
# Join addresses to metering data
test = head(asq,2870)
test$Lat <- vapply(test$Lat, paste, collapse = "", character(1L))
test$Lon <- vapply(test$Lon, paste, collapse = "", character(1L))
test$premise <- as.integer(as.character(test$premise))
test$Lat <- as.numeric(as.character(test$Lat))
test$Lon <- as.numeric(as.character(test$Lon))

test = sqldf("select
              * 
              from test 
              inner join df on test.premise = df.id_prem")
colnames(test)[43] = 'CommName'
 
##_____________________________________________________________________________________________________________________________
# plot lat lon

map <- get_map(location = 'Milwaukee,WI', zoom = 11)
mapPoints = ggmap(map) +  geom_point(aes(x = Lon, y = Lat, color = CommName), data = test, alpha = .8,size = 4)
mapPoints

##_____________________________________________________________________________________________________________________________
# plot lat lon

a<- sqldf("Select * from test where Purchase_year > 2010 ")
a$Purchase_year ="Greater Than 2010"

b<-sqldf("Select * from test where Purchase_year > 2004 and Purchase_Year < 2010")
b$Purchase_year ="2004-2010"

c<- sqldf("Select * from test where Purchase_year <2004 ")
c$Purchase_year ="Less Than 2004"

testing = rbind(a,b,c)

mapPoints = ggmap(map) +  geom_point(aes(x = Lon, y = Lat, color = Purchase_year), data = testing, alpha = .8,size = 4)
mapPoints + theme(legend.text=element_text(size=20),legend.title=element_text(size=25))
