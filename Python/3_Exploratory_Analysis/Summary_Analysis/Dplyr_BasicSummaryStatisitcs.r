###############################################################################################################################
# Name             : Dplyr_BasicSummaryStatisitcs
# Date             : 06-11-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to compute summary Statisitcs
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150611             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages

library(dplyr)

##_____________________________________________________________________________________________________________________________
# 

# Stats by all records
Stats =  mtcars %>% summarise(Mean=mean( mpg),Min=min( mpg),Max=max( mpg), Median=median( mpg), Std=sd( mpg),Total = sum( mpg))

# Stats grouped by a single variables
Stats =  mtcars %>% 
group_by(gear)%>% 
summarise(Mean=mean( mpg),Min=min( mpg),Max=max( mpg), Median=median( mpg), Std=sd( mpg),Total = sum( mpg))

# Stats grouped by a multiple variables
Stats =  mtcars %>% 
group_by(gear,cyl)%>% 
summarise(Mean=mean( mpg),Min=min( mpg),Max=max( mpg), Median=median( mpg), Std=sd( mpg),Total = sum( mpg))

# Stats filtered by a variable and grouped
Stats =  mtcars %>%  
  filter(cyl>= 6) %>% 
  group_by(gear)%>% 
  summarise(Mean=mean( mpg),Min=min( mpg),Max=max( mpg), Median=median( mpg), Std=sd( mpg),Total = sum( mpg))
 