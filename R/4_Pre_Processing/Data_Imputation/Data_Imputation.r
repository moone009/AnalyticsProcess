###############################################################################################################################
# Name             : Data_Imputation
# Date             : 04-12-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Example of how to impute values (mean,median)
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150412             initial
###############################################################################################################################
 
##_____________________________________________________________________________________________________________________________
# Example of how to impute missing values with the mean and median

# remove airquality incase you previously changed the structure of the dataframe
rm(airquality)
airquality[is.na(airquality)] <- median(airquality$Ozone,na.rm=TRUE)

rm(airquality)
airquality[is.na(airquality)] <- mean(airquality$Ozone,na.rm=TRUE)