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

# Urls
https://dash.geocod.io/usage
https://dash.geocod.io/apikey

# Load libraries
library(jsonlite)
library(RCurl)
library(foreign)

# Load trim function
trim.trailing <- function (x) sub("\\s+$", "", x)


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
# Process File

# Api key provided from geocod.io
api_key='c3e5e217b01e6d7056c129e37d1a1a63da510d0'

asq <- subset(asq,servcity =='MILWAUKEE')


for(i in 1625:2500){
  
    print(i)
  
    addr <- paste(
                  trim.trailing(gsub('  ','',asq[[6]][i])),
                  trim.trailing(gsub('  ','',asq[[2]][i])),
                  gsub(' ','',asq[[3]][i]),
                  sep=' ')
    addr <- gsub(' ','+',addr)
    addr <- gsub('#','',addr)
    
    api <- paste('https://api.geocod.io/v1/geocode?q=',addr,'&api_key=',api_key,sep='')

    dfe = fromJSON(api)
  
  
    if(length(dfe$results) > 0 ){
      
      dfe = dfe$results[1,]
      #Lat
      asq[[7]][i] <-  dfe$location[1]
      #long
      asq[[8]][i] <-  dfe$location[2]
    }
    if(length(dfe$results) == 0){
        #Lat
        asq[[7]][i] <-  0
        #long
        asq[[8]][i] <- 0
    }
}












