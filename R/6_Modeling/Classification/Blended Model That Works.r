

source('F:\\Analytics_Process\\R\\Custom_Functions\\DummyCode.r')
library(caret)

##______________________________________________________________________________________________________
## Load Data
df = read.csv('F:/AdultDataset.csv',sep=",",header=T)
df = DummyCode(df,c('workclass','education','marital.status','occupation','relationship','race','sex'))

colnames(df)[which(colnames(df) =='occupation- ?')]= 'occupation-unknown'
colnames(df)[which(colnames(df) =='workclass- ?')] ='workclass-unknown'


df$workclass = NULL
df$education = NULL
df$marital.status  = NULL
df$occupation = NULL
df$relationship = NULL
df$race = NULL
df$sex = NULL
df$native.country = NULL

nzv <- nearZeroVar(df)
print(dim(df))
df <- df[, -nzv]
print(dim(df))

##______________________________________________________________________________________________________
## Define our Target
df$Income = as.factor(df$Income)
Target = 'Income'

##______________________________________________________________________________________________________
## Split Into Ensemble, Blender and Test

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

# TrainingControl and Grid
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

system.time(model_elm <- train(ensembleData[,predictors], ensembleData[,Target], method='elm', trControl=myControl))
system.time(model_knn <- train(ensembleData[,predictors], ensembleData[,Target], method='rknnBel'))
system.time(model_qdat <- train(ensembleData[,predictors], ensembleData[,Target], method='qda', trControl=myControl))

system.time(model_blackboost <- train(ensembleData[,predictors], ensembleData[,Target],
                                      method='blackboost',
                                      trControl=myControl,
                                      preProc = c("center", "scale")))

system.time(model_nnet <- train(ensembleData[,predictors], ensembleData[,Target],
                                      method='nnet',
                                      tuneLength = 7,
                                      trace = FALSE,
                                      maxit = 100,
                                      trControl=myControl))


## In train.default(ensembleData[, predictors], ensembleData[, Target],  :missing values found in aggregated results

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
blenderData$pred_elm = predict(model_elm, blenderData[,predictors])


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
pred_model_elm = predict(model_elm, testingData[,predictors])


Bayes = confusionMatrix(table(pred_model_bayesglm,testingData[,Target]))
RDA = confusionMatrix(table(pred_model_rda,testingData[,Target]))
glmboost = confusionMatrix(table(pred_model_glmboost,testingData[,Target]))
Rpart = confusionMatrix(table(pred_rpart,testingData[,Target]))
LDA = confusionMatrix(table(pred_lda,testingData[,Target]))
C50 = confusionMatrix(table(pred_c50,testingData[,Target]))
RF = confusionMatrix(table(pred_rf,testingData[,Target]))
GBM = confusionMatrix(table(pred_GBM,testingData[,Target]))
Ada = confusionMatrix(table(pred_AdaBag,testingData[,Target]))
LogiBoost =confusionMatrix(table(pred_LogitBoost,testingData[,Target]))
Elm =confusionMatrix(table(pred_model_elm,testingData[,Target]))

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


options(scipen=999)
BAYES = round(Bayes$overall,4)
RDA = round(RDA$overall,4)
GLMBOOST = round(glmboost$overall,4)
RPART = round(Rpart$overall,4)
LDA = round(LDA$overall,4)
C50 = round(C50$overall,4)
RF = round(RF$overall,4)
GBM = round(GBM$overall,4)
ADA = round(Ada$overall,4)
LOGIBOOST = round(LogiBoost$overall,4)
Elm = round(Elm$overall,4)

## Drop RDA because they do not predict well enough
blenderData$pred_RDA= NULL
testingData$pred_RDA= NULL

##______________________________________________________________________________________________________
## Blend Results together

# run a final model to blend all the probabilities together
predictors <- names(blenderData)[names(blenderData) != Target]
final_blender_model <- train(blenderData[,predictors], blenderData[,Target], method='gbm', trControl=myControl,tuneGrid = gbmGrid)

# See final prediction and AUC of blended ensemble
preds <- predict(object=final_blender_model, testingData[,predictors])
BlendedModel = confusionMatrix(table(preds,testingData[,Target]))
BlendedModel = round(BlendedModel$overall,4)
Models = as.data.frame(rbind(BAYES,RDA,GLMBOOST,RPART,LDA,C50,RF,GBM,ADA,LOGIBOOST,BlendedModel))
Models$Model = rownames(Models)
sqldf("Select * from Models order by Accuracy")
pred_GBM  <=50K  >50K
<=50K     7752   932
>50K       515  1656

preds     <=50K  >50K
<=50K     7747   895
>50K       520  1693

##______________________________________________________________________________________________________
## This model is not fitting well do to noise
source('F:\\Analytics_Process\\R\\Custom_Functions\\Function_randomForest Imp.r')
Vales =  rfImp(blenderData,'TARGET_B',3)
#Previous Score with all Variables: 0.5721








