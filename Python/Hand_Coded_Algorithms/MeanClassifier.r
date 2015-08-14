#########################################################################################################
# Name             : Mean Classifier
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classification and regression
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################

## Note: This algorithm assumes normally distributed data.


MeanClassifier <- function(df,Target){
	## Split into test and train
	inTrain = createDataPartition(y=df[,Target],p=.7,list=FALSE)

	training = df[inTrain,]
	testing = df[-inTrain,]
	## Calculate Means
	training$mean = rowMeans(training[1:4])
	testing$mean = rowMeans(testing[1:4])
	testing$Prediction = ''
	
	## loop through calculate difference and assign predictions
	for(i in 1:nrow(testing)){   

	  training$Vals = abs(as.numeric(training$mean) - as.numeric(testing$mean[i]))
	  training = training[with(training, order(Vals)), ]
	  testing$Prediction[i] =  names(which(table(head(training[Target],5)) == max(table(head(training[Target],5)))))
	  
	  }
	  
	  return(table(testing[[Target]],testing$Prediction))
}

MeanClassifier(iris,'Species')




