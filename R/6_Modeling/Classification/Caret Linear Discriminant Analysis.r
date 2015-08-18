#########################################################################################################
# Name             : Caret Linear Discriminant Analysis
# Date             : 08-18-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classification 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150818              initial
#########################################################################################################

library(caret)


##______________________________________________________________________________________________________
# Test and Train
inTrain = createDataPartition(y=iris$Species,p=.7,list=FALSE)

training = iris[inTrain,]
testing = iris[-inTrain,]

##______________________________________________________________________________________________________
# Predictors
predictors <- names(training)[names(training) != 'Species']

##______________________________________________________________________________________________________
# Setup training controls and grid
myControl <- trainControl(method='repeatedcv', number=5, returnResamp='none')

##______________________________________________________________________________________________________
# Run Model
system.time(model_LDA <- train(training[,predictors], training[,'Species'], 
                               method='lda',
                               trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
pred_rpart = predict(model_LDA, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],pred_rpart))
