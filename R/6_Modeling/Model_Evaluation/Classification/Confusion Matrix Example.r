#########################################################################################################
# Name             : Confusion Matrix Example
# Date             : 09-12-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Post Model Analysis
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150912              initial
#########################################################################################################


# Required Package for multinomial logit
library(nnet)
library(caret)


##_____________________________________________________________________________________________________________________________
# init function

cf_matrix <- function(tbl){
  
  # Set vars
  accuracy <- 0
  recall <- c()
  precision <- c()
  
  for(i in 1:sqrt(length(tbl))){
    
    accuracy <- accuracy+tbl[,i][i]
    
    recall <- c(recall,tbl[,i][i]/colSums(tbl)[i])
    
    precision <- c(precision,tbl[,i][i]/rowSums(tbl)[i])
    
    if(i == sqrt(length(tbl))){
      accuracy <- round(as.numeric(accuracy/sum(colSums(tbl))),2)
    }
  }
  
  # Wrap suppress warning because accuracy will repeat which is what I want
  Results <-  suppressWarnings(cbind(tbl,Precision = round(precision,2),Recall =  round(recall,2),Accuracy =accuracy))
  return(Results)
  
}


##_____________________________________________________________________________________________________________________________
# Load Data
df <- read.csv('http://archive.ics.uci.edu/ml/machine-learning-databases/zoo/zoo.data')

colnames(df)    <- c('name',
                    'hair',
                    'feathers',
                    'eggs',
                    'milk',
                    'airborne',
                    'aquatic',
                    'predator',
                    'toothed',
                    'backbone',
                    'breathes',
                    'venomous',
                    'fins',
                    'legs',
                    'tail',
                    'domestic',
                    'catsize',
                    'type')
df$name = NULL
##_____________________________________________________________________________________________________________________________
# Test and Train
trainIndex <- createDataPartition(df$type, p = .3,
                                  list = FALSE,
                                  times = 1)
Train <- df[ trainIndex,]
Test  <- df[-trainIndex,]

##_____________________________________________________________________________________________________________________________
# Model
model <- multinom(type ~ ., data = Train)

predictions <- predict(model,Test)

xtab <- table(predictions, Test[['type']])

##_____________________________________________________________________________________________________________________________
# Model Analysis
cf_matrix(xtab)


