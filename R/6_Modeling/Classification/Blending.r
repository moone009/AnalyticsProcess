
library(caret)

##______________________________________________________________________________________________________
# Test and Train
inTrain = createDataPartition(y=iris$Species,p=.3,list=FALSE)

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
system.time(model_NB <- train(training[,predictors], training[,'Species'], 
                              method='nb',
                              trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
pred_nb = predict(model_NB, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],pred_nb))




##______________________________________________________________________________________________________
# Setup training controls and grid
myControl <- trainControl(method='repeatedcv', number=3, returnResamp='none')

##______________________________________________________________________________________________________
# Run Model
system.time(model_C50 <- train(training[,predictors], training[,'Species'], 
                               method='C5.0',
                               trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
pred_c50 = predict(model_C50, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],pred_c50))




##______________________________________________________________________________________________________
# Run Model
system.time(model_LDA <- train(training[,predictors], training[,'Species'], 
                               method='lda',
                               trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
lda = predict(model_LDA, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],lda))





##______________________________________________________________________________________________________
# Run Model
system.time(model_LogitBoost <- train(training[,predictors], training[,'Species'], 
                               method='LogitBoost',
                               trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
LogitBoost = predict(model_LogitBoost, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],LogitBoost))


##______________________________________________________________________________________________________
# Run Model
system.time(model_rda <- train(training[,predictors], training[,'Species'], 
                               method='rda',
                               trControl=myControl))

##______________________________________________________________________________________________________
# Model Prediction
rda = predict(model_rda, testing[,predictors])

##______________________________________________________________________________________________________
# Model Results
confusionMatrix(table(testing[,'Species'],rda))








results <- data.frame(lda=lda,pred_c50=pred_c50,pred_nb=pred_nb,LogitBoost=LogitBoost,rda = rda)
results <- cbind(results,testing[,'Species'])
colnames(results)[6] <- 'actual'

model_vote <- function(x){
  
  #names(which(table(t(results[11,1:3])) == max(table(t(results[11,1:3])))))
  output <- names(which(table(t(x)) == max(table(t(x)))))
  return(output)
}

results$Vote <- apply(results[,c(1:5)],1,model_vote)
confusionMatrix(table(results[,'actual'],results[,'Vote']))


 