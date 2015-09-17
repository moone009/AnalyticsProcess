
MeanClassifier <- function(df,colls,Target){
  ## Split into test and train
  inTrain = createDataPartition(y=df[,Target],p=.7,list=FALSE)
  
  training = df[inTrain,]
  testing = df[-inTrain,]
  ## Calculate Means
  training$mean = rowMeans(training[colls])
  testing$mean = rowMeans(testing[colls])
  testing$Prediction = ''
  
  ## loop through calculate difference and assign predictions
  for(i in 1:nrow(testing)){   
    
    training$Vals = abs(as.numeric(training$mean) - as.numeric(testing$mean[i]))
    training = training[with(training, order(Vals)), ]
    #here we saying wich value in our table equals the max value of the table values then extracting the name
    testing$Prediction[i] =  names(which(table(head(training[Target],5)) == max(table(head(training[Target],5)))))
    
  }
  
  return(table(testing[[Target]],testing$Prediction))
}





