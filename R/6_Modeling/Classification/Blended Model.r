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

rm(list=ls()) 
gc()

library(caret)
source('F:\\Analytics_Process\\R\\Custom_Functions\\DummyCode.r')

df = read.csv('F:/kddcup98.csv',sep=",",header=T)

df$DemMedHomeValue = gsub(' ','',as.character(df$DemMedHomeValue))
df$DemMedHomeValue = gsub('\\$','',as.character(df$DemMedHomeValue))
df$DemMedHomeValue = gsub(',','',as.character(df$DemMedHomeValue))

df$DemMedHomeValue = as.numeric(df$DemMedHomeValue)

df$DemMedIncome = gsub(' ','',as.character(df$DemMedIncome))
df$DemMedIncome = gsub('\\$','',as.character(df$DemMedIncome))
df$DemMedIncome = gsub(',','',as.character(df$DemMedIncome))

df$DemMedIncome = as.numeric(df$DemMedIncome)

df$TARGET_B = as.factor(df$TARGET_B)

df = DummyCode(df,c('DemGender','DemHomeOwner','StatusCat96NK'))
df$DemGender = NULL
df$DemHomeOwner = NULL
df$StatusCat96NK = NULL

df[is.na(df)] <- 0
df$TARGET_D = NULL
df$ID = NULL
##______________________________________________________________________________________________________

# Scale Data
#df[,c(2:21)] = scale(df[,c(2:21)])
# RandomForest Selected Vars 
#Vars = c('TARGET_B','DemMedHomeValue','GiftAvgAll','DemPctVeterans','DemMedIncome','DemCluster','GiftAvg36','GiftTimeFirst','PromCntAll','GiftTimeLast','PromCnt36','PromCntCardAll')
#df = df[,c(Vars)]

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


smp_size <- floor(0.65 * nrow(df))
train_ind <- sample(seq_len(nrow(df)), size = smp_size)
ensembleData <- df[train_ind, ]
blenderData1 <- df[-train_ind, ]

smp_size <- floor(0.5 * nrow(blenderData1))
train_ind <- sample(seq_len(nrow(blenderData1)), size = smp_size)
blenderData <- blenderData1[train_ind, ]
testingData <- blenderData1[-train_ind, ]

nrow(ensembleData)+nrow(testingData)+nrow(blenderData)

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
system.time(model_rpart <- train(ensembleData[,predictors], ensembleData[,Target], method='rpart',trControl=myControl))
system.time(model_lda <- train(ensembleData[,predictors], ensembleData[,Target], method='lda',trControl=myControl))
system.time(model_c50 <- train(ensembleData[,predictors], ensembleData[,Target], method='C5.0', trControl=myControl))
system.time(model_rf <- train(ensembleData[,predictors], ensembleData[,Target], method='rf', trControl=myControl,ntree = 1000))
system.time(model_GBM <- train(ensembleData[,predictors], ensembleData[,Target], method='gbm', trControl=myControl,tuneGrid = gbmGrid))
system.time(model_AdaBag <- train(ensembleData[,predictors], ensembleData[,Target], method='nnet', trControl=myControl))
system.time(model_LogitBoost <- train(ensembleData[,predictors], ensembleData[,Target], method='LogitBoost', trControl=myControl))

system.time(model_bayesglm <- train(ensembleData[,predictors], ensembleData[,Target], method='bayesglm', trControl=myControl))
system.time(model_rda <- train(ensembleData[,predictors], ensembleData[,Target], method='rda', trControl=myControl))
system.time(model_glmboost <- train(ensembleData[,predictors], ensembleData[,Target], method='glmboost', trControl=myControl))

# Blender data
blenderData$pred_rpart = predict(model_rpart, blenderData[,predictors])
blenderData$pred_lda = predict(model_lda, blenderData[,predictors])
blenderData$pred_c50 = predict(model_c50, blenderData[,predictors])
blenderData$pred_rf = predict(model_rf, blenderData[,predictors])
blenderData$pred_GBM = predict(model_GBM, blenderData[,predictors])
blenderData$pred_AdaBag = predict(model_AdaBag, blenderData[,predictors])
blenderData$pred_LogitBoost = predict(model_LogitBoost, blenderData[,predictors])
blenderData$pred_bayesglm = predict(model_bayesglm, blenderData[,predictors])
blenderData$pred_RDA = predict(model_rda, blenderData[,predictors])
blenderData$pred_glmboost = predict(model_glmboost, blenderData[,predictors])


# Model Prediction
pred_rpart = predict(model_rpart, testingData[,predictors])
pred_lda = predict(model_lda, testingData[,predictors])
pred_c50 = predict(model_c50, testingData[,predictors])
pred_rf = predict(model_rf, testingData[,predictors])
pred_GBM = predict(model_GBM, testingData[,predictors])
pred_AdaBag = predict(model_AdaBag, testingData[,predictors])
pred_LogitBoost = predict(model_LogitBoost, testingData[,predictors])
pred_model_rda = predict(model_rda, testingData[,predictors])
pred_model_bayesglm = predict(model_bayesglm, testingData[,predictors])
pred_model_glmboost = predict(model_glmboost, testingData[,predictors])


confusionMatrix(table(pred_model_bayesglm,testingData[,Target]))
confusionMatrix(table(pred_model_rda,testingData[,Target]))
confusionMatrix(table(pred_model_glmboost,testingData[,Target]))
confusionMatrix(table(pred_rpart,testingData[,Target]))
confusionMatrix(table(pred_lda,testingData[,Target]))
confusionMatrix(table(pred_c50,testingData[,Target]))
confusionMatrix(table(pred_rf,testingData[,Target]))
confusionMatrix(table(pred_GBM,testingData[,Target]))
confusionMatrix(table(pred_AdaBag,testingData[,Target]))
confusionMatrix(table(pred_LogitBoost,testingData[,Target]))

# testind data (we are predicting on the testing data however)
testingData$pred_rpart = predict(model_rpart, testingData[,predictors])
testingData$pred_lda = predict(model_lda, testingData[,predictors])
testingData$pred_c50 = predict(model_c50, testingData[,predictors])
testingData$pred_rf = predict(model_rf, testingData[,predictors])
testingData$pred_GBM = predict(model_GBM, testingData[,predictors])
testingData$pred_AdaBag = predict(model_AdaBag, testingData[,predictors])
testingData$pred_LogitBoost = predict(model_LogitBoost, testingData[,predictors])
testingData$pred_bayesglm = predict(model_bayesglm, testingData[,predictors])
testingData$pred_RDA = predict(model_rda, testingData[,predictors])
testingData$pred_glmboost = predict(model_glmboost, testingData[,predictors])



##______________________________________________________________________________________________________
## Blend Results together

# run a final model to blend all the probabilities together
predictors <- names(blenderData)[names(blenderData) != Target]
final_blender_model <- train(blenderData[,predictors], blenderData[,Target], method='gbm', trControl=myControl,tuneGrid = gbmGrid)

# See final prediction and AUC of blended ensemble
preds <- predict(object=final_blender_model, testingData[,predictors])
confusionMatrix(table(testingData[,Target],preds))

##______________________________________________________________________________________________________
## This model is not fitting well do to noise
source('F:\\Analytics_Process\\R\\Custom_Functions\\Function_randomForest Imp.r')
Vales =  rfImp(blenderData,'TARGET_B',3)
#Previous Score with all Variables: 0.5721


 






