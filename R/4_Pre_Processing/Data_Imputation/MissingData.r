###############################################################################################################################
# Name             : MissingData
# Date             : 09-09-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : View Missing Data in data frame
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593       20150915             initial
###############################################################################################################################


##_____________________________________________________________________________________________________________________________
# Create sample data

df = mtcars
df$carb = as.factor(df$carb)
df$am = as.character(df$am)

df$TestDate=as.Date(sapply(
  as.Date(seq(ISOdate(2012,1,1), by = "day", length.out = nrow(df))) 
  ,function(x)  x+sample(1:100, 1)) , origin="1970-01-01")

df$Update=as.Date(sapply(
  as.Date(seq(ISOdate(2012,1,1), by = "day", length.out = nrow(df))) 
  ,function(x)  x+sample(1:100, 1)) , origin="1970-01-01")

df[df$mpg > 21  ,which(colnames(df)=="hp")] = NA
df[df$qsec > 20  ,which(colnames(df)=="wt")] = NA


##_____________________________________________________________________________________________________________________________
# Execute Function

TotalMissing <-sapply(df, function(x) sum(is.na(x)))
TotalMissingPer <-round(sapply(df, function(x) sum(is.na(x)))/nrow(df),3)

TotalMissing <-as.data.frame(rbind(TotalMissing,TotalMissingPer))
TotalMissing[, c(which(TotalMissing[1,] >0))]
