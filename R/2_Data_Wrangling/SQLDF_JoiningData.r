###############################################################################################################################
# Name             : SQLDF_JoiningData
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : How to Merge data together
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

# Note if you do not understand inner,outer,left,right, multicolumn joins then please refresh yourself before presenting data to any employee.
# Also, always good to check row count before and after
##_____________________________________________________________________________________________________________________________
# Load Packages

library(sqldf)

##_____________________________________________________________________________________________________________________________
# Create sample data; we set n to number of records we want created
n = 999
source('F:\\Analytics_Process\\R\\SampleData\\CreateSampleData.r')

##_____________________________________________________________________________________________________________________________

# Sqldf does not support right our outer joins 

# left join
## In this example I want all values from collections. 
sqldf("Select * from Collections left join CallCenter on Collections.CustomerID = CallCenter.CustomerID")

# Inner join
sqldf("Select * from Collections inner join Meter on Collections.MeterID = Meter.MeterID")
sqldf("Select * from Collections inner join CallCenter on Collections.CustomerID = CallCenter.CustomerID")

# Multi join
sqldf("Select * 
				from Collections 
				inner join Meter on Collections.MeterID = Meter.MeterID
				inner join CallCenter on Collections.CustomerID = CallCenter.CustomerID")

# Conditions
sqldf("Select * 
				from Collections 
				inner join Meter on Collections.MeterID = Meter.MeterID
				inner join CallCenter on Collections.CustomerID = CallCenter.CustomerID
				Where CallType = 'Billing'")
                   
