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
library(caret)
require(doSNOW)
library(data.table)

x <- getURL("https://raw.githubusercontent.com/moone009/AnalyticsProcess/master/R/SampleData/Rpt.txt")
Rpt <- read.csv(text = x)
head(Rpt)

for(i in 1:8){
  Rpt <- rbind(Rpt,Rpt)
}
prettyNum(nrow(Rpt),big.mark=",",scientific=FALSE)

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
system.time(Rpt$StartHours <- apply(Rpt[4],1 ,StartHours))
system.time(Rpt$StopHours <- apply(Rpt[5],1 ,StopHours))
system.time(Rpt$Miles <- apply(Rpt[9],1 ,Miles))

head(Rpt)

##_____________________________________________________________________________________________________________________________
# Build Functions that we wish to vectorize and parralell

Rpt$ID = ''
X = 1
End  = 100000
system.time(for(i in 1:99){
  
  print(X)
  print(End)
  print('')
  
  Rpt$ID[X:End] = i
  X = X + 100000
  End = End + 100000
  
  
  if(End > nrow(Rpt)){End = nrow(Rpt)}
  if(End == nrow(Rpt)){print(i);print(X);print(End);Rpt$ID[X:End] = i+1;break}
})
table(Rpt$ID)

##_____________________________________________________________________________________________________________________________

cores <- 2
cl <- makeCluster(cores, type = "SOCK")
registerDoSNOW(cl)

system.time(data <- foreach(i=1:5,.combine = c,.packages='stringr') %dopar% 
{
  
  data = Rpt[Rpt$ID == i,]
  data$StartHours <- apply(data[4],1 ,StartHours)
   
  
})

##_____________________________________________________________________________________________________________________________

cores <- 6
cl <- makeCluster(cores, type = "SOCK")
registerDoSNOW(cl)

system.time(data <- foreach(i=1:9,
                            .combine=c , ## Two Seperate Lists for the two functions below
                            .packages='stringr') %dopar% 
{
  
  data = Rpt[Rpt$ID == i,]
  list(apply(data[4],1 ,StartHours),apply(data[9],1 ,Miles),apply(data[5],1 ,StopHours))
  
  
})

SeqStop <- as.numeric(tail(Rpt$ID,1))*3
IDs <- as.numeric(tail(Rpt$ID,1))

for(i in 1:IDs){
idx <- seq(1,SeqStop,by = 3)[i]
if(i == 1){Start_hours <- as.data.table(data[[idx]])}
if(i != 1){Start_hours <- rbind(Start_hours,as.data.table(data[[idx]]))}
}
for(i in 1:IDs){
  idx <- seq(2,SeqStop,by = 3)[i]
  if(i == 1){miles_cat <- as.data.table(data[[idx]])}
  if(i != 1){miles_cat <- rbind(miles_cat,as.data.table(data[[idx]]))}
}
for(i in 1:IDs){
  idx <- seq(3,SeqStop,by = 3)[i]
  if(i == 1){stop_hours <- as.data.table(data[[idx]])}
  if(i != 1){stop_hours <- rbind(stop_hours,as.data.table(data[[idx]]))}
}

colnames(stop_hours)<-'StopHours'
colnames(Start_hours)<-'StartHours'
colnames(miles_cat)<-'Miles'

Rpt <- cbind(Rpt,Start_hours,miles_cat,stop_hours)

stopCluster(cl)


