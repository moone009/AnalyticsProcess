#########################################################################################################
# Name             : KNN
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Regression
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################

library(RTextTools)
library(caret)


##__________________________________________________________________________________________________________________________________________
# Split into test and train
ind <- sample(2,nrow(mtcars),replace=TRUE,prob=c(0.5,0.5))
trainData <- mtcars[ind==1,]
testData <- mtcars[ind==2,]

# Build Model
fit <- knnreg(trainData[,c(2,3,4,5,6,7,8,9,10,11)], trainData[,c(1)], k = 3)

# Model get probability
Predictions = predict(fit, testData[,c(2,3,4,5,6,7,8,9,10,11)])

# Calculate Root Mean Squared Error
RMSE <- sqrt(mean((testData[[1]]-Predictions)^2))
print(RMSE)






