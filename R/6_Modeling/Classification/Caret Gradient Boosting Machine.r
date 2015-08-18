#########################################################################################################
# Name             : Caret Gradient Boosting Machine
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
gbmGrid <-  expand.grid(interaction.depth = c(1, 3, 5, 9),
                        n.trees = (1:30)*10,
                        shrinkage = 0.1)

##______________________________________________________________________________________________________
# Run Model
system.time(model_GBM <- train(training[,predictors], training[,'Species'], 
                               method='gbm',
                               trControl=myControl,
                               tuneGrid = gbmGrid))


##______________________________________________________________________________________________________
# Model Prediction
pred_rpart = predict(model_GBM, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],pred_rpart))













