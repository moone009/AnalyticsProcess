#########################################################################################################
# Name             : KNN Classifier
# Date             : 09-11-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classification and regression
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150911              initial
#########################################################################################################

## Note: This algorithm assumes normally distributed data.


KNNClassifier <- function(df,cols,Target,K,Scale = F){
  require(caret)
  
  inTrain = createDataPartition(y=df[,Target],p=.7,list=FALSE)
  training = df[inTrain,]
  testing = df[-inTrain,]
  
  # We need to set our training distance to 0 and setup an empty column to collect our test predictions
  training$distance = 0
  testing$Prediction = ''
  
  # Specifying the index of our distance column
  DistanceColIndex <- length(training)
  
  for(row in 1:nrow(testing)){
    
    # we loop through each column to sum up total distance
    for(i in 1:length(cols)){
      training[[DistanceColIndex]] = training[[DistanceColIndex]]  + ((training[[cols[i]]] - testing[[cols[i]]][row])^2)
    }
    
    # Sort our values by distance
    training = training[with(training, order(distance)), ]
    
    #We stating which value in our table equals the max value of the table values then extracting the name
    predicted_name <- names(which(table(head(training[Target],K)) == max(table(head(training[Target],K)))))

    # if we have a tie we will take top 1
    if(length(predicted_name) > 1){ predicted_name<- names(which(table(head(training[Target],1)) == max(table(head(training[Target],1)))))}
    
    testing$Prediction[row] =  paste('Predicted',predicted_name)
    
    # reset training distance to 0
    training$distance = 0
    
  }
  return(table(testing[[Target]],testing$Prediction))
  
}	








