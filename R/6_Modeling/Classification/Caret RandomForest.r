#########################################################################################################
# Name             : Caret RandomForest
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
# Read Data
df = read.csv('F:\\kddcup98-1.csv',sep=",",header=T)
df$TARGET_B = as.factor(df$TARGET_B)
##______________________________________________________________________________________________________
# Test and Train
inTrain = createDataPartition(y=df$TARGET_B,p=.7,list=FALSE)

training = df[inTrain,]
testing = df[-inTrain,]

##______________________________________________________________________________________________________
# Predictors
predictors <- names(training)[names(training) != 'TARGET_B']

##______________________________________________________________________________________________________
# Setup training controls and grid
myControl <- trainControl(method='repeatedcv', number=5, returnResamp='none')
newGrid = expand.grid(mtry = c(1,2,3,4,5,6))

require(doSNOW)
registerDoSNOW(makeCluster(7, type = "SOCK"))
getDoParWorkers()
getDoParName()
getDoParVersion()

##______________________________________________________________________________________________________
# Run Model
system.time(model_RF <- train(training[,predictors], training[,'TARGET_B'], 
                               method='rf',
                               preProcess = c("center","scale")  ,
                               trControl=myControl,
                               tuneGrid = newGrid))

##______________________________________________________________________________________________________
# Model Prediction
pred_rpart = predict(model_RF, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'TARGET_B'],pred_rpart))
ggplot(model_RF, metric = "Kappa")

# This shows the additional features (aka noise) actually make the model worst
ggplot(model_RF)






