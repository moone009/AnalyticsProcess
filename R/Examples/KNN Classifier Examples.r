#########################################################################################################
# Name             : KNN Classifier Examples
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

# Load function
source('F:\\Analytics_Process\\R\\Hand_Coded_Algorithms\\KNNClassifier.r')

##_____________________________________________________________________________________________________________________________
# Example iris
df = iris
cols = c(1,2,3,4)
Target = 'Species'

Acc <- c()
K <- c()
for(x in 1:20){
  print(x)
  for(k in 1:6){
    tbl <- KNNClassifier(df,cols,Target,k)
    accuracy <- 0
    for(i in 1:sqrt(length(tbl))){
      accuracy <- accuracy+tbl[,i][i]
      if(i == sqrt(length(tbl))){accuracy <- round(as.numeric(accuracy/sum(colSums(tbl))),2)}
    }
    Acc <- c(accuracy,Acc)
    K <- c(k,K)
  }
}

plt <- cbind(K,Acc)
plt <- as.data.frame(plt)
library(sqldf)
plt <- sqldf("Select K,avg(Acc) as AccAverage from plt group by K")


# Prepare plot
p <- ggplot(plt, aes(x=K, y=AccAverage))
p + geom_line()+
  geom_point(size = 5,color = 'blue')+
  scale_x_continuous(breaks=1:nrow(plt))+
  ggtitle(paste('Average based up on',x, 'runs'))

##_____________________________________________________________________________________________________________________________
# Example mtcars

df = mtcars
df$cyl = as.factor(df$cyl)
cols = c(1,3:11)
Target = 'cyl'

Acc <- c()
K <- c()
for(x in 1:10){
  print(x)
  for(k in 1:5){
    tbl <- KNNClassifier(df,cols,Target,k)
    accuracy <- 0
    for(i in 1:sqrt(length(tbl))){
      accuracy <- accuracy+tbl[,i][i]
      if(i == sqrt(length(tbl))){accuracy <- round(as.numeric(accuracy/sum(colSums(tbl))),2)}
    }
    Acc <- c(accuracy,Acc)
    K <- c(k,K)
  }
}

plt <- cbind(K,Acc)
plt <- as.data.frame(plt)
library(sqldf)
plt <- sqldf("Select K,avg(Acc) as AccAverage from plt group by K")

# Prepare plot
p <- ggplot(plt, aes(x=K, y=AccAverage))
p + geom_line()+
  geom_point(size = 5,color = 'blue')+
  scale_x_continuous(breaks=1:nrow(plt))+
  ggtitle(paste('Average based up on',x, 'runs'))



##_____________________________________________________________________________________________________________________________
# Example smarket
library(ISLR)
df = Smarket
cols = c(2:8)
Target = 'Direction'

Acc <- c()
K <- c()
for(x in 1:5){
  print(x)
  for(k in 1:5){
    tbl <- KNNClassifier(df,cols,Target,k)
    accuracy <- 0
    for(i in 1:sqrt(length(tbl))){
      accuracy <- accuracy+tbl[,i][i]
      if(i == sqrt(length(tbl))){accuracy <- round(as.numeric(accuracy/sum(colSums(tbl))),2)}
    }
    Acc <- c(accuracy,Acc)
    K <- c(k,K)
  }
}

plt <- cbind(K,Acc)
plt <- as.data.frame(plt)
library(sqldf)
plt <- sqldf("Select K,avg(Acc) as AccAverage from plt group by K")

# Prepare plot
p <- ggplot(plt, aes(x=K, y=AccAverage))
p + geom_line()+
  geom_point(size = 5,color = 'blue')+
  scale_x_continuous(breaks=1:nrow(plt))+
  ggtitle(paste('Average based up on',x, 'runs'))



tbl <- KNNClassifier(df,cols,Target,k)
accuracy <- 0
recall <- c()
precision <- c()

for(i in 1:sqrt(length(tbl))){
  
  accuracy <- accuracy+tbl[,i][i]
  
  recall <- c(tbl[,i][i]/colSums(tbl)[i],recall)
  
  precision <- c(tbl[,i][i]/rowSums(tbl)[i],precision)
  
  if(i == sqrt(length(tbl))){
    accuracy <- round(as.numeric(accuracy/sum(colSums(tbl))),2)
    
  }
}
Model_Results <- list(Acc =accuracy,Recall=recall, Precision= precision)
cbind(tbl,precision,recall,Acc)

Recall: Percent correctly classified. Ex recall of 90% means I correctly classified 90% of the targets while 10% I missclassified as different target.

Precision: Percent classified as another target. Ex precision of 88% out of the total population classified as X 12% should have been classified as Y.





