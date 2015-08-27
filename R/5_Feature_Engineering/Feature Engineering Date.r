###############################################################################################################################
# Name             : Feature Engineering Date
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : How to drive more value from your data
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

library(lubridate)
##_____________________________________________________________________________________________________________________________
# Sample Data

data=as.data.frame(list(ID=1:55,
                   variable=rnorm(55,50,15)))

#This function will generate a uniform sample of dates from 
#within a designated start and end date:
rand.date=function(start.day,end.day,data){   
  size=dim(data)[1]    
  days=seq.Date(as.Date(start.day),as.Date(end.day),by="day")  
  pick.day=runif(size,1,length(days))  
  date=days[pick.day]  
}

#This will create a new column within your data frame called date:
data$date=rand.date("2013-01-01","2014-02-28",data)

##_____________________________________________________________________________________________________________________________
# Sample Data

Engineer_data <- function(df,col,holiday){
	data = df
	data[paste(col,'_mon',sep='')] = month(data[[col]])
	data[paste(col,'_year',sep='')] = year(data[[col]])
	data[paste(col,'_day',sep='')] = day(data[[col]])
	data[paste(col,'_quarter',sep='')] = quarter(data[[col]])
	data[paste(col,'_week',sep='')] = week(data[[col]])

	# Major Holidays
	# within 7 days of Christmas, Easter, 4th July, Memorial Day, Labor Day, New Years Eve, Thanks Giving
	
	if(holiday == T){
			Holiday <- function(x,month = 12,day = 25){ 
			Y = as.numeric(x - as.Date(paste(year(data[[col]]),'-',month,'-',day,sep='')))   
			if(Y <= 0 & Y >= -7){1}else{0}
		}
	 
		data[paste(col,'_Christmas',sep='')] =  sapply(data[[col]],Holiday,month=12,day=25)       
		data[paste(col,'_Independence',sep='')] =  sapply(data[[col]],Holiday,month='07',day='04')       
		data[paste(col,'_Easter',sep='')] =  sapply(data[[col]],Holiday,month='07',day='04')       
		data[paste(col,'_Memorial',sep='')] =  sapply(data[[col]],Holiday,month='07',day='04')       
		data[paste(col,'_NYE',sep='')] =  sapply(data[[col]],Holiday,month='07',day='04')       
		data[paste(col,'_ThanksGiving',sep='')] =  sapply(data[[col]],Holiday,month='07',day='04')       
	}
	return(data)
}
# Execute function
data = Engineer_data(data,'date',F)



















