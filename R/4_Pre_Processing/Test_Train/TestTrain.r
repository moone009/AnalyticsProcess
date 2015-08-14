###############################################################################################################################
# Name             : TestTrain
# Date             : 07-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to split into test and train
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150715             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages

library(caret)

##_____________________________________________________________________________________________________________________________
# Split into test and train using Caret Package

trainIndex <- createDataPartition(iris$Species, p = .6,
                                  list = FALSE,
                                  times = 1)
irisTrain <- iris[ trainIndex,]
irisTest  <- iris[-trainIndex,]

##_____________________________________________________________________________________________________________________________
# Split into test and train using sqldf Package

SplitPercent = .6
NumberRecords = .6*nrow(iris)

iris$index = rownames(iris)
query = paste("Select * from iris order by random() limit " ,NumberRecords,sep='')
irisTrain = sqldf(query) 

# index is a reserved word therefore we wrap it in brackets
query = paste("Select * from iris where [index] not in (select [index] from irisTrain)")
irisTest = sqldf(query) 