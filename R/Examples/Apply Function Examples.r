###############################################################################################################################
# Name             : Apply Function Examples
# Date             : 07-11-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to utilize the apply functions
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593       20150711             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# load libraries and data
library(RCurl)
library(stringr)

x <- getURL("https://raw.githubusercontent.com/moone009/AnalyticsProcess/master/R/SampleData/Rpt.txt")
Rpt <- read.csv(text = x)
head(Rpt)

##_____________________________________________________________________________________________________________________________
# Build Functions that we wish to vectorize
StartHours <- function(x){if(as.numeric(paste(str_pad(as.numeric(substr(x,12,13)),2, pad = "0"),
                                              str_pad(as.numeric(substr(x,15,16)),2, pad = "0"),
                                              sep='')) < 630 ){T} else {F}}

StopHours <- function(x){if(as.numeric(paste(str_pad(as.numeric(substr(x,12,13)),2, pad = "0"),
                                             str_pad(as.numeric(substr(x,15,16)),2, pad = "0"),
                                             sep='')) > 1730 ){T} else {F}}
Miles <- function(x){
                      if(x < 30 ){ {'Low'}
                        }else {if(x > 30 && x < 150){ {'Medium'}
                        }else { {'High'}
                        }
                      }
                    }



# 1 = Rows 2 = Columns
Rpt$StartHours <- apply(Rpt[4],1 ,StartHours)
Rpt$StopHours <- apply(Rpt[5],1 ,StopHours)
Rpt$Miles <- apply(Rpt[9],1 ,Miles)

head(Rpt)





