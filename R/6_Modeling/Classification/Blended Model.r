#########################################################################################################
# Name             : Blended Model
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : My House
# Purpose          : Classify hazard score
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################
library(caret)

df = read.csv('F:/kddcup98-1.csv',sep=",",header=T) 
df$TARGET_B = as.factor(df$TARGET_B)
##______________________________________________________________________________________________________

# Scale Data
df[,c(2:21)] = scale(df[,c(2:21)])

##______________________________________________________________________________________________________
# Test and Train
Target = 'TARGET_B'

#randomly order data
df = df[sample(nrow(df)),]

# shuffle and split the data into three parts
df <- df[sample(nrow(df)),]
split <- floor(nrow(df)/3)
ensembleData <- df[0:split,]
blenderData <- df[(split+1):(split*2),]
testingData <- df[(split*2+1):nrow(df),]


##______________________________________________________________________________________________________
## Modeling Setup

require(doSNOW)
registerDoSNOW(makeCluster(7, type = "SOCK"))
getDoParWorkers()
getDoParName()
getDoParVersion()


myControl <- trainControl(method='repeatedcv', number=5, returnResamp='none')
gbmGrid <-  expand.grid(interaction.depth = c(1, 5, 9),
                        n.trees = (1:30)*15,
                        shrinkage = 0.1)

# The models we try are: RandomForest, GBM, NN, LogitBoost
predictors <- names(ensembleData)[names(ensembleData) != Target]

##______________________________________________________________________________________________________
## Initial Modeling
system.time(model_rpart <- train(ensembleData[,predictors], ensembleData[,Target], method='rpart', trControl=myControl))
system.time(model_lda <- train(ensembleData[,predictors], ensembleData[,Target], method='lda', trControl=myControl))
system.time(model_c50 <- train(ensembleData[,predictors], ensembleData[,Target], method='C5.0', trControl=myControl))
system.time(model_rf <- train(ensembleData[,predictors], ensembleData[,Target], method='rf', trControl=myControl,ntree = 1000))
system.time(model_GBM <- train(ensembleData[,predictors], ensembleData[,Target], method='gbm', trControl=myControl,tuneGrid = gbmGrid))
system.time(model_AdaBag <- train(ensembleData[,predictors], ensembleData[,Target], method='AdaBag', trControl=myControl))
system.time(model_LogitBoost <- train(ensembleData[,predictors], ensembleData[,Target], method='LogitBoost', trControl=myControl))

# Blender data
blenderData$pred_rpart = predict(model_rpart, blenderData[,predictors])
blenderData$pred_lda = predict(model_lda, blenderData[,predictors])
blenderData$pred_c50 = predict(model_c50, blenderData[,predictors])
blenderData$pred_rf = predict(model_rf, blenderData[,predictors])
blenderData$pred_GBM = predict(model_GBM, blenderData[,predictors])
blenderData$pred_AdaBag = predict(model_AdaBag, blenderData[,predictors])
blenderData$pred_LogitBoost = predict(model_LogitBoost, blenderData[,predictors])

# testind data (we are predicting on the testing data however)
testingData$pred_rpart = predict(model_rpart, testingData[,predictors])
testingData$pred_lda = predict(model_lda, testingData[,predictors])
testingData$pred_c50 = predict(model_c50, testingData[,predictors])
testingData$pred_rf = predict(model_rf, testingData[,predictors])
testingData$pred_GBM = predict(model_GBM, testingData[,predictors])
testingData$pred_AdaBag = predict(model_AdaBag, testingData[,predictors])
testingData$pred_LogitBoost = predict(model_LogitBoost, testingData[,predictors])

# Model Prediction
pred_rpart = predict(model_rpart, testing[,predictors])
pred_lda = predict(model_lda, testing[,predictors])
pred_c50 = predict(model_c50, testing[,predictors])
pred_rf = predict(model_rf, testing[,predictors])
pred_GBM = predict(model_GBM, testing[,predictors])
pred_AdaBag = predict(model_AdaBag, testing[,predictors])
pred_LogitBoost = predict(model_LogitBoost, testing[,predictors])

confusionMatrix(table(pred_rpart,testing[,Target]))
confusionMatrix(table(pred_lda,testing[,Target]))
confusionMatrix(table(pred_c50,testing[,Target]))
confusionMatrix(table(pred_rf,testing[,Target]))
confusionMatrix(table(pred_GBM,testing[,Target]))
confusionMatrix(table(pred_AdaBag,testing[,Target]))
confusionMatrix(table(pred_LogitBoost,testing[,Target]))

##______________________________________________________________________________________________________
## Blend Results together

# run a final model to blend all the probabilities together
predictors <- names(blenderData)[names(blenderData) != Target]
final_blender_model <- train(blenderData[,predictors], blenderData[,Target], method='rf', trControl=myControl)

# See final prediction and AUC of blended ensemble
preds <- predict(object=final_blender_model, testingData[,predictors])
confusionMatrix(table(testingData[,Target],preds))


