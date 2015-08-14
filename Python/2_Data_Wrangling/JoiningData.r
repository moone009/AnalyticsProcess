###############################################################################################################################
# Name             : JoiningData
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
# Create sample data; we set n to number of records we want created
n = 999
source('F:\\Analytics_Process\\R\\SampleData\\CreateSampleData.r')

##_____________________________________________________________________________________________________________________________

# left join
## In this example I want all values from collections. 
merge(Collections, CallCenter, by = "CustomerID",all.x = T)

# right join
## In this example I want all values from CallCenter. 
merge(Collections, CallCenter, by = "CustomerID",all.y = T)

# inner join
merge(Collections, Meter, by = "MeterID")
merge(Collections, CallCenter, by = "CustomerID")

# outer join
merge(Collections, CallCenter, by = "CustomerID",all.x = T,all.y = T)

 