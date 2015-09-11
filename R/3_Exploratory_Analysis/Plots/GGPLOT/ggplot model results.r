#########################################################################################################
# Name             : ggplot model results
# Date             : 09-01-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Example of how visualize results
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150901             initial
#########################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages
library(caret)
library(ggplot2)

##_____________________________________________________________________________________________________________________________
# TrainingControl and Grid
myControl <- trainControl(method='repeatedcv', number=5, returnResamp='none')
gbmGrid <-  expand.grid(interaction.depth = c(1, 5, 9),
                        n.trees = (1:30)*15,
                        shrinkage = 0.1,
                        n.minobsinnode = c(1, 5, 9, 15, 20))

Target='Species'
predictors <- names(iris)[names(iris) != Target]

##_____________________________________________________________________________________________________________________________
## Initial Modeling
system.time(model_rpart <- train(iris[,predictors], iris[,Target],  method='rpart',trControl=myControl))
system.time(model_lda <- train(iris[,predictors], iris[,Target],  method='lda',trControl=myControl))
system.time(model_c50 <- train(iris[,predictors], iris[,Target],  method='C5.0', trControl=myControl))
system.time(model_rf <- train(iris[,predictors], iris[,Target],  method='rf', trControl=myControl,ntree = 1000))
system.time(model_GBM <- train(iris[,predictors], iris[,Target],  method='gbm', trControl=myControl,tuneGrid = gbmGrid))

# predictions              
model_rpart = predict(model_rpart, iris[,predictors])
model_lda = predict(model_lda, iris[,predictors])
model_c50 = predict(model_c50, iris[,predictors])
model_rf = predict(model_rf, iris[,predictors])
model_GBM = predict(model_GBM, iris[,predictors])

# Predictions Eval
model_rpart  = confusionMatrix(table(model_rpart ,iris[,Target]))
model_lda  = confusionMatrix(table(model_lda ,iris[,Target]))
model_c50  = confusionMatrix(table(model_c50 ,iris[,Target]))
model_rf  = confusionMatrix(table(model_rf ,iris[,Target]))
model_GBM  = confusionMatrix(table(model_GBM ,iris[,Target]))

##_____________________________________________________________________________________________________________________________
# build data frame
Accuracy <- rbind(model_rpart$overall[1:2],model_lda$overall[1:2],model_c50$overall[1:2],model_rf$overall[1:2],model_GBM$overall[1:2],c(1,.5))
Names <-rbind('Tree','LDA','C50','RF','GBM','Random Guessing')
Accuracy <-cbind(Names,Accuracy)
colnames(Accuracy)[1]='Model'
Accuracy = as.data.frame(Accuracy)

Accuracy$Accuracy = as.numeric(as.character(Accuracy$Accuracy))
Accuracy$Kappa= as.numeric(as.character(Accuracy$Kappa))

Accuracy$Accuracy = round(Accuracy$Accuracy,2)
Accuracy$Kappa = round(Accuracy$Kappa,2)

##_____________________________________________________________________________________________________________________________
# Plot Model Results Accuracy
qplot(Accuracy,Model, data = Accuracy, color = Model)+ geom_point( size =8)+ ggtitle("Model Results")
# Plot without Random Guessing Accuracy
qplot(Accuracy,Model, data =  Accuracy[1:5,], color = Model)+ geom_point( size =8)+ ggtitle("Model Results")

# Plot Model Results Kappa
qplot(Kappa,Model, data = Accuracy, color = Model)+ geom_point( size =8)+ ggtitle("Model Results")
# Plot without Random Guessing Kappa
qplot(Kappa,Model, data =  Accuracy[1:5,], color = Model)+ geom_point( size =8)+ ggtitle("Model Results")



