#########################################################################################################
# Name             : ExtractColumnsByDataType
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : My House
# Purpose          : Extract columns by data type
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################



mtcars$gear =as.factor(mtcars$gear)
mtcars$carb =as.factor(mtcars$carb)



NominalValues = names(unlist(
  lapply(
    lapply(mtcars,class),  
    function(x){if(x =='factor') x }
  )))

NominalValues = mtcars[,c(NominalValues)]


NumericValues = names(unlist(
  lapply(
    lapply(mtcars,class),  
    function(x){if(x =='numeric') x }
  )))

NumericValues = mtcars[,c(NumericValues)]

rm(mtcars)