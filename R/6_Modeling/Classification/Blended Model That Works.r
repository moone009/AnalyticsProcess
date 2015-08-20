
I am working on a stacked classifiation model predicting a target of three classes

I have my three sets: ensemble, blended, and test

I then created 10 models using my ensebmle data. All models are with a few percent accuracy of eachother. Recall and Precision is fairly close as well.

Then I run the models on the blended and test: ex; blended$Tree = predict(....) and Test$Tree = predict(....)

Then I train a final model on the blended dataset and run the model on my test. 

source('F:\\Analytics_Process\\R\\Custom_Functions\\DummyCode.r')
set.seed(342345)
library(caret)
library(sqldf)

##______________________________________________________________________________________________________
## Load Data
df = read.csv('F:/AdultDataset.csv',sep=",",header=T)
df = DummyCode(df,c('workclass','education','marital.status','occupation','relationship','race','sex'))
colnames(df) = gsub(' ','',colnames(df))
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

##______________________________________________________________________________________________________
## Drop zero variance cols
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
#df <- df[sample(nrow(df)),]
#split <- floor(nrow(df)/2)
#ensembleData <- df[0:split,]
#blenderData <- df[(split+1):(split+(split*.5)),]
#testingData <- df[(nrow(ensembleData) + nrow(blenderData)+1):nrow(df),]

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
                        shrinkage = 0.1,
                        n.minobsinnode = c(1, 5, 9, 15, 20))

# The models we try are: RandomForest, GBM, NN, LogitBoost
predictors <- names(ensembleData)[names(ensembleData) != Target]

##______________________________________________________________________________________________________
## Initial Modeling
system.time(model_rpart <- train(ensembleData[,predictors], ensembleData[,Target],  method='rpart',trControl=myControl))
system.time(model_lda <- train(ensembleData[,predictors], ensembleData[,Target],  method='lda',trControl=myControl))
system.time(model_c50 <- train(ensembleData[,predictors], ensembleData[,Target],  method='C5.0', trControl=myControl))
system.time(model_rf <- train(ensembleData[,predictors], ensembleData[,Target],  method='rf', trControl=myControl,ntree = 1000))
system.time(model_GBM <- train(ensembleData[,predictors], ensembleData[,Target],  method='gbm', trControl=myControl,tuneGrid = gbmGrid))

system.time(model_nnet <- train(ensembleData[,predictors], ensembleData[,Target], 
                                method='nnet',    
                                tuneLength = 7,
                                trace = FALSE,
                                maxit = 500,
                                trControl=myControl))

system.time(model_LogitBoost <- train(ensembleData[,predictors], ensembleData[,Target], method='LogitBoost', trControl=myControl))
system.time(model_bayesglm <- train(ensembleData[,predictors], ensembleData[,Target], method='bayesglm', trControl=myControl))
system.time(model_glmboost <- train(ensembleData[,predictors], ensembleData[,Target], method='glmboost', trControl=myControl))
system.time(model_elm <- train(ensembleData[,predictors], ensembleData[,Target], method='elm', trControl=myControl))
system.time(model_gpls <- train(ensembleData[,predictors], ensembleData[,Target], method='gpls', trControl=myControl))
system.time(model_ctree2 <- train(ensembleData[,predictors], ensembleData[,Target], method='ctree2', trControl=myControl))
system.time(model_nodeHarvest <- train(ensembleData[,predictors], ensembleData[,Target], method='nodeHarvest', trControl=myControl))
system.time(model_rotationForest <- train(ensembleData[,predictors], ensembleData[,Target], method='rotationForest', trControl=myControl))
system.time(model_svmPoly <- train(ensembleData[,predictors], ensembleData[,Target], method='svmPoly', trControl=myControl))
system.time(model_treebag <- train(ensembleData[,predictors], ensembleData[,Target], method='treebag', trControl=myControl))

# Blender data
blenderData$pred_ctree2 = predict(model_ctree2, blenderData[,predictors])
blenderData$pred_nodeHarvest = predict(model_nodeHarvest, blenderData[,predictors])
blenderData$pred_rotationForest = predict(model_rotationForest, blenderData[,predictors])
blenderData$pred_svmPoly = predict(model_svmPoly, blenderData[,predictors])
blenderData$pred_treebag = predict(model_treebag, blenderData[,predictors])
blenderData$pred_rpart = predict(model_rpart, blenderData[,predictors])
blenderData$pred_lda = predict(model_lda, blenderData[,predictors])
blenderData$pred_c50 = predict(model_c50, blenderData[,predictors])
blenderData$pred_rf = predict(model_rf, blenderData[,predictors])
blenderData$pred_GBM = predict(model_GBM, blenderData[,predictors])
blenderData$pred_nnet = predict(model_nnet, blenderData[,predictors])
blenderData$pred_LogitBoost = predict(model_LogitBoost, blenderData[,predictors])
blenderData$pred_bayesglm = predict(model_bayesglm, blenderData[,predictors])
blenderData$pred_GPLS = predict(model_gpls, blenderData[,predictors])
blenderData$pred_glmboost = predict(model_glmboost, blenderData[,predictors])
blenderData$pred_elm = predict(model_elm, blenderData[,predictors])
# testind data (we are predicting on the testing data however)
testingData$pred_rpart = predict(model_rpart, testingData[,predictors])
testingData$pred_lda = predict(model_lda, testingData[,predictors])
testingData$pred_c50 = predict(model_c50, testingData[,predictors])
testingData$pred_rf = predict(model_rf, testingData[,predictors])
testingData$pred_GBM = predict(model_GBM, testingData[,predictors])
testingData$pred_nnet = predict(model_nnet, testingData[,predictors])
testingData$pred_LogitBoost = predict(model_LogitBoost, testingData[,predictors])
testingData$pred_bayesglm = predict(model_bayesglm, testingData[,predictors])
testingData$pred_GPLS = predict(model_gpls, testingData[,predictors])
testingData$pred_glmboost = predict(model_glmboost, testingData[,predictors])
testingData$pred_ctree2 = predict(model_ctree2, testingData[,predictors])
testingData$pred_nodeHarvest = predict(model_nodeHarvest, testingData[,predictors])
testingData$pred_rotationForest = predict(model_rotationForest, testingData[,predictors])
testingData$pred_svmPoly = predict(model_svmPoly, testingData[,predictors])
testingData$pred_treebag = predict(model_treebag, testingData[,predictors])
testingData$pred_elm = predict(model_elm, testingData[,predictors])


# Model Prediction
pred_rpart = predict(model_rpart, testingData[,predictors])
pred_lda = predict(model_lda, testingData[,predictors])
pred_c50 = predict(model_c50, testingData[,predictors])
pred_rf = predict(model_rf, testingData[,predictors])
pred_GBM = predict(model_GBM, testingData[,predictors])
pred_nnet = predict(model_nnet, testingData[,predictors])
pred_LogitBoost = predict(model_LogitBoost, testingData[,predictors])
pred_model_gpls = predict(model_gpls, testingData[,predictors])
pred_model_bayesglm = predict(model_bayesglm, testingData[,predictors])
pred_model_glmboost = predict(model_glmboost, testingData[,predictors])
pred_model_elm = predict(model_elm, testingData[,predictors])
pred_model_ctree2 = predict(model_ctree2, testingData[,predictors])
pred_model_nodeHarvest = predict(model_nodeHarvest, testingData[,predictors])
pred_model_rotationForest = predict(model_rotationForest, testingData[,predictors])
pred_model_svmPoly = predict(model_svmPoly, testingData[,predictors])
pred_model_treebag = predict(model_treebag, testingData[,predictors])

# Predictions Eval
CTREE2 = confusionMatrix(table(pred_model_ctree2,testingData[,Target]))
NODEHARVEST = confusionMatrix(table(pred_model_nodeHarvest,testingData[,Target]))
ROTATIONFOREST = confusionMatrix(table(pred_model_rotationForest,testingData[,Target]))
SVMPOLY = confusionMatrix(table(pred_model_svmPoly,testingData[,Target]))
TREEBAG = confusionMatrix(table(pred_model_treebag,testingData[,Target]))
Bayes = confusionMatrix(table(pred_model_bayesglm,testingData[,Target]))
GPLS = confusionMatrix(table(pred_model_gpls,testingData[,Target]))
glmboost = confusionMatrix(table(pred_model_glmboost,testingData[,Target]))
Rpart = confusionMatrix(table(pred_rpart,testingData[,Target]))
LDA = confusionMatrix(table(pred_lda,testingData[,Target]))
C50 = confusionMatrix(table(pred_c50,testingData[,Target]))
RF = confusionMatrix(table(pred_rf,testingData[,Target]))
GBM = confusionMatrix(table(pred_GBM,testingData[,Target]))
NNET = confusionMatrix(table(pred_nnet,testingData[,Target]))
LogiBoost =confusionMatrix(table(pred_LogitBoost,testingData[,Target]))
Elm =confusionMatrix(table(pred_model_elm,testingData[,Target]))


options(scipen=999)
BAYES = round(Bayes$overall,4)
GPLS = round(GPLS$overall,4)
GLMBOOST = round(glmboost$overall,4)
RPART = round(Rpart$overall,4)
LDA = round(LDA$overall,4)
C50 = round(C50$overall,4)
RF = round(RF$overall,4)
GBM = round(GBM$overall,4)
NNET = round(NNET$overall,4)
LOGIBOOST = round(LogiBoost$overall,4)
Elm = round(Elm$overall,4)
CTREE2 = round(CTREE2$overall,4)
NODEHARVEST = round(NODEHARVEST$overall,4)
ROTATIONFOREST = round(ROTATIONFOREST$overall,4)
SVMPOLY = round(SVMPOLY$overall,4)
TREEBAG = round(TREEBAG$overall,4)

##______________________________________________________________________________________________________
## Blend Results together

# run a final model to blend all the probabilities together
predictors <- names(blenderData)[names(blenderData) != Target]
final_blender_model <- train(blenderData[,predictors], blenderData[,Target], method='gbm', trControl=myControl,tuneGrid = gbmGrid)

# See final prediction and AUC of blended ensemble
preds <- predict(object=final_blender_model, testingData[,predictors])
BlendedModel = confusionMatrix(table(preds,testingData[,Target]))
BlendedModel = round(BlendedModel$overall,4)
Models = as.data.frame(rbind(BAYES,GPLS,GLMBOOST,RPART,LDA,C50,RF,Elm,GBM,NNET,LOGIBOOST,BlendedModel,CTREE2,NODEHARVEST,ROTATIONFOREST,SVMPOLY,TREEBAG))
Models$Model = rownames(Models)
sqldf("Select * from Models order by Accuracy")


##______________________________________________________________________________________________________
## This model is not fitting well do to noise
source('F:\\Analytics_Process\\R\\Custom_Functions\\Function_randomForest Imp.r')
Vales =  rfImp(blenderData,'Income',3)
#Previous Score with all Variables: 0.5721






