#########################################################################################################
# Name             : KNN
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classification and regression
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################

library(RTextTools)
library(caret)

##__________________________________________________________________________________________________________________________________________
# Split into test and train
ind <- sample(2,nrow(iris),replace=TRUE,prob=c(0.5,0.5))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

# Build Model
model_knn3 <- knn3(trainData[[5]]~., k=3, data=trainData)
model_knn3  

# Model get probability
Prob = predict(model_knn3, testData,type='class')

# print out matrix
confusionMatrix(table(testData[[5]],Prob))