###############################################################################################################################
# Name             : VariableTransformationExample
# Date             : 07-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Example of how variable transformation improves results
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150715             initial
###############################################################################################################################
##_____________________________________________________________________________________________________________________________
# Definitions

# Regularization, in mathematics and statistics and particularly in the fields of machine learning and inverse problems, 
# refers to a process of introducing additional information in order to solve an ill-posed problem or to prevent overfitting.

# Centering Variables Normally, to center a variable, you would subtract the mean of all data points from each individual data point

##_____________________________________________________________________________________________________________________________
# Load Packages

library(caret)

##_____________________________________________________________________________________________________________________________
# Load Data

baseball = read.csv('F:\\Datasets\\Baseball\\Batting.csv',sep=",",header=T)
baseball[is.na(baseball)] <- 0
baseball$lgID = NULL
baseball$teamID = NULL
baseball$stint = NULL

##_____________________________________________________________________________________________________________________________
# Split into test and train

trainIndex <- createDataPartition(baseball$HR, p = .6,
                                  list = FALSE,
                                  times = 1)
baseballTrain <- baseball[ trainIndex,]
baseballTest  <- baseball[-trainIndex,]

baseballTrainProcessed = baseballTrain
baseballTestProcessed = baseballTest

baseballTrainPCA = baseballTrain
baseballTestPCA = baseballTest

baseballTrainBoxCox = baseballTrain
baseballTestBoxCox = baseballTest

##_____________________________________________________________________________________________________________________________
# build first model on original data

reg = lm(HR~AB+R+H+X2B+X3B+HR+RBI+SB+CS+BB+SO+IBB+HBP+SH+SF+GIDP,baseballTrain)
predictions = predict(reg,baseballTest)
OriginalData = sqrt(mean((mean(baseballTest$HR) - predictions)^2))

##_____________________________________________________________________________________________________________________________
# build second model on centered and scaled data

preProcValues <- preProcess(baseballTrainProcessed[3:19], method = c("center", "scale"))
baseballTrainProcessed[3:19] <- predict(preProcValues, baseballTrainProcessed[3:19])

preProcValues <- preProcess(baseballTestProcessed[3:19], method = c("center", "scale"))
baseballTestProcessed[3:19] <- predict(preProcValues, baseballTestProcessed[3:19])

reg = lm(HR~AB+R+H+X2B+X3B+HR+RBI+SB+CS+BB+SO+IBB+HBP+SH+SF+GIDP,baseballTrainProcessed)
predictions = predict(reg,baseballTestProcessed)
CenteredAndScaled = sqrt(mean((mean(baseballTestProcessed$HR) - predictions)^2))

##_____________________________________________________________________________________________________________________________
# build third model on PCA

preProcValues <- preProcess(baseballTrainPCA[3:19], method = c("pca"))
baseballTrainPCA[3:19] <- predict(preProcValues, baseballTrainPCA[3:19])

preProcValues <- preProcess(baseballTestPCA[3:19], method = c("pca"))
baseballTestPCA[3:19] <- predict(preProcValues, baseballTestPCA[3:19])

reg = lm(HR~AB+R+H+X2B+X3B+HR+RBI+SB+CS+BB+SO+IBB+HBP+SH+SF+GIDP,baseballTrainPCA)
predictions = predict(reg,baseballTestPCA)
PCA = sqrt(mean((mean(baseballTestPCA$HR) - predictions)^2))

##_____________________________________________________________________________________________________________________________
# output results
cbind(OriginalData,CenteredAndScaled,PCA)

