#########################################################################################################
# Name             : Finding Optimal K
# Date             : 09-12-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Post Model Analysis
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150912              initial
#########################################################################################################

source('F:\\Analytics_Process\\R\\Hand_Coded_Algorithms\\KNNClassifier.r')


# Example smarket
library(ISLR)
df = Smarket
cols = c(2:8)
Target = 'Direction'

odd_numbers <- (1:6)*2 - 1
Acc <- c()
K <- c()
for(x in 1:5){
  print(paste('outerloop',x))
  for(k in 1:length(odd_numbers)){
    print(paste('innerloop',k))
    k = odd_numbers[k]
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
  scale_x_continuous(breaks=odd_numbers)+
  theme(text = element_text(size=20))+
  ggtitle(paste('Average based up on',x, 'runs'))

 