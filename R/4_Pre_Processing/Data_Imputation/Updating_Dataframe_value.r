###############################################################################################################################
# Name             : Updating_Dataframe_value
# Date             : 05-06-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to update a value in a dataframe
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150506            initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Simple example of how to update a value in a dataframe

# Remove iris incase you made changes to the structure previously 
rm(iris)
iris[iris$Sepal.Length > 5 & iris$Petal.Length >= 5.9 ,which(colnames(iris)=="Petal.Width")] = 8
subset(iris,Petal.Width == 8)

