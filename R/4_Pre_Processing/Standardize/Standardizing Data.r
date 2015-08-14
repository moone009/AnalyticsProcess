###############################################################################################################################
# Name             : Standardizing Data
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : How to standardize data
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

library(caret)
##_____________________________________________________________________________________________________________________________
# split in to test and train
set.seed(1234)

idxs <- sample(1:nrow(iris),as.integer(0.7*nrow(iris)))
trainIris <- iris[idxs,]
testIris <- iris[-idxs,]
 
## A 3-nearest neighbours model with no normalization
iris_pred <- knn(train = trainIris[,c(1:4)], test = testIris[,c(1:4)], cl = trainIris$Species, k=3)

## The resulting confusion matrix
table(testIris[,'Species'],iris_pred)
  
  
##_____________________________________________________________________________________________________________________________
# Z score standardize
iris[c(1,2,3,4)]= scale(iris[c(1,2,3,4)])

set.seed(1234)

idxs <- sample(1:nrow(iris),as.integer(0.7*nrow(iris)))
trainIris <- iris[idxs,]
testIris <- iris[-idxs,]
 
# A 3-nearest neighbours model with no normalization
iris_pred <- knn(train = trainIris[,c(1:4)], test = testIris[,c(1:4)], cl = trainIris$Species, k=3)

# The resulting confusion matrix
table(testIris[,'Species'],iris_pred)

# Remove object
rm(iris)

##_____________________________________________________________________________________________________________________________
# Mean-Centering
iris[c(1,2,3,4)]= scale(iris[c(1,2,3,4)],scale = FALSE)

set.seed(1234)

idxs <- sample(1:nrow(iris),as.integer(0.7*nrow(iris)))
trainIris <- iris[idxs,]
testIris <- iris[-idxs,]
 
# A 3-nearest neighbours model with no normalization
iris_pred <- knn(train = trainIris[,c(1:4)], test = testIris[,c(1:4)], cl = trainIris$Species, k=3)

# The resulting confusion matrix
table(testIris[,'Species'],iris_pred)

# Remove object
rm(iris)

##_____________________________________________________________________________________________________________________________
# Normalize
normalize <- function(x) {
	num <- x - min(x)
	denom <- max(x) - min(x)
	return (num/denom)
}
iris[c(1,2,3,4)]= normalize(iris[c(1,2,3,4)])

set.seed(1234)

idxs <- sample(1:nrow(iris),as.integer(0.7*nrow(iris)))
trainIris <- iris[idxs,]
testIris <- iris[-idxs,]
 
# A 3-nearest neighbours model with no normalization
iris_pred <- knn(train = trainIris[,c(1:4)], test = testIris[,c(1:4)], cl = trainIris$Species, k=3)

# The resulting confusion matrix
table(testIris[,'Species'],iris_pred)

# Remove object
rm(iris)


