#########################################################################################################
# Name             : Random Forest Var Selection Output
# Date             : 06-24-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classify hazard score
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150624              initial
#########################################################################################################

# Load required libraries
library(ggplot2)
library(lubridate)
library(randomForest)


rfImp <- function(df,target,returnval){
  
  # Extract predictors
  predictors <- names(df)[names(df) != target]
  
  # Train a model across all the training data and plot the variable importance
  model_rf <- randomForest(df[,predictors], df[,target], ntree=500, importance=TRUE)
  
  # Export Variable importance
  dat = varImp(model_rf, type=2)
  
  # Convert to frame
  featureImportance <- data.frame(dat[1])
  featureImportance$Var = rownames(featureImportance)
  rownames(featureImportance) <- 1:nrow(featureImportance)
  featureImportance$Var = as.character(featureImportance$Var)
  
  ## Var Plot
  featureImportance = sqldf("select * from featureImportance order by Overall desc limit 20")
  plt = ggplot(featureImportance, aes(x=reorder(Var, order(Overall, decreasing = F)), y=Overall)) +
          geom_bar(stat="identity", fill="#E8AFAF") +
          coord_flip() + 
          theme_light(base_size=20) +
          xlab("Variable") +
          ylab("Importance") + 
          ggtitle("Random Forest Feature Importance") +
          theme(plot.title=element_text(size=18))
        
  # Select top twenty variables
  featureImportanceVals = sqldf("select Var, Overall from featureImportance order by Overall desc limit 20")
  featureImportance = sqldf("select Var from featureImportance order by Overall desc limit 20")
  
  RfSelectedVariables = c()
  for(x in 1:nrow(featureImportance))
    {
      RfSelectedVariables = c(RfSelectedVariables , c=featureImportance[[1]][x])    
    }

 
 if(returnval == 1){
 print('Limited to top twenty variables')
 return(featureImportanceVals)
  }
 if(returnval == 2){
   return(RfSelectedVariables)
 }
 if(returnval == 3){
   return(plt)
 }
}

rfImp(iris,'Species',3)


 