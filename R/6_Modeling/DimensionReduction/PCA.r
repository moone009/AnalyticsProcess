#########################################################################################################
# Name             : PCA
# Date             : 03-15-2016
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Dimension Reduction 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20160315              initial
#########################################################################################################

library(caret)
library(AppliedPredictiveModeling)

##______________________________________________________________________________________________________
preProcValues <- preProcess(iris[,c(1:4)], method = c("BoxCox", "center", 
                                                      "scale", "pca"))
trainTransformed <- predict(preProcValues, iris)
qplot(PC1, PC2, data=trainTransformed, color=Species)

##______________________________________________________________________________________________________
preProcValues <- preProcess(diamonds[,c(1,5:10)], method = c("BoxCox", "center", 
                                                      "scale", "pca"))
trainTransformed <- predict(preProcValues, diamonds)
qplot(PC1, PC2, data=trainTransformed, color=color)




