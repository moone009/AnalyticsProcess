#########################################################################################################
# Name             : Generate Random Dates
# Date             : 08-26-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Usually used for testing
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150826              initial
#########################################################################################################


##_____________________________________________________________________________________________________________________________
# Instantiate Function
RandomDate <- function(StartDate,EndDate,Qty){
  
  require('zoo')
  StartDate = as.Date(StartDate)
  EndDate = as.Date(EndDate)
  Max = as.numeric(EndDate-StartDate)
  
  li = c()
  
  for(i in 1:Qty){
    Range = sample(1:Max, 1)
    li=c(li,as.Date(StartDate+Range))
  }
  
  return(as.Date(li))
}



date_range = RandomDate('2014-01-03','2015-01-03',5)

 