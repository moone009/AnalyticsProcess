###############################################################################################################################
# Name             : Apply_Family
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
# Load function for creating sample data

LargeDataset <- function(rows){ 
  LargeDataset = iris
  for(i in 1:200){
  LargeDataset = rbind(LargeDataset,LargeDataset)
  if(nrow(LargeDataset) > rows){break}
  }
  print(nrow(LargeDataset))
  
  return(LargeDataset)
}

###############################################################################################################################
## Apply is used for applying functions over entire columns or rows. 
##
###############################################################################################################################

# Applying to invidual rows
Output =  apply(iris[1:4],1 ,sum)
tail(cbind(iris,Output),10)

Output =  apply(iris[1:4],1 ,mean)
tail(cbind(iris,Output),10)

ValueGreaterThanTwo =  function(x){ if (min(x) >= 2){'More than 2'} else {'Less than 2'}}
Output = apply(iris[1:4],1 ,ValueGreaterThanTwo)
Output = cbind(iris,Output)
Output[97:105,]

# Applying to columns
Sum = apply(iris[1:4],2 ,sum) 
Min = apply(iris[1:4],2 ,min)
Max = apply(iris[1:4],2 ,max)
SD = apply(iris[1:4],2 ,sd)
Mean = apply(iris[1:4],2 ,mean)
t(cbind(Sum,Min,Max,SD,Mean))

apply(iris[1:2],1:2,function(x) 10 * x)
apply(iris[1:2],1,function(x) 10 * x)
apply(iris[1:2],2,function(x) 10 * x)


###############################################################################################################################
## LApply is used for for manipulating data frames and lists. This is the function that you should 
## become most familiar with. 
###############################################################################################################################
# Apply functions to dataframe columns
# Best practice to convert column to a list using [[]]

# Create a function then apply it over a column
df = LargeDataset(5000000)
UselessGrouping =  function(x){if (x >= 6){'More than 6'} else {'Less than 6'}}
system.time(df[[1]] <- lapply(df[[1]],UselessGrouping))

# Convert back to data frame using unlist
df$Sepal.Length = unlist(df$Sepal.Length)

# You can also apply the functions anonamously similar to lambda functions
rm(iris)
iris[[1]] = lapply(iris[[1]], function(x){if (x >= 6){'More than 6'} else {'Less than 6'}})
head(iris)
rm(iris)

###############################################################################################################################
## SApply is used for for manipulating data frames and lists. This is the function that you should 
## become most familiar with. 
###############################################################################################################################

# Create a function then apply it over a column
df = LargeDataset(5000000)
UselessGrouping =  function(x){if (x >= 6){'More than 6'} else {'Less than 6'}}
system.time(df[[1]] <- sapply(df[[1]],UselessGrouping))



###############################################################################################################################
## TApply is used for 
##
###############################################################################################################################

tapply(iris[[1]], iris[[5]], mean)
tapply(iris[[1]], iris[[5]], length) # essentially counting
tapply(iris[[1]], iris[[5]], sum)






