###############################################################################################################################
# Name             : RandomForest Number of Trees
# Date             : 07-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to choose ideal number of trees
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150715             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages
library(caret)
library(e1071)
library(randomForest)

##_____________________________________________________________________________________________________________________________
# Split into test and train using Caret Package
df <- read.csv('F:\\Analytics_Process\\R\\SampleData\\Adult.csv',sep=',',header=T)

target <- 'Income'
  
trainIndex <- createDataPartition(df$Income, p = .4,
                                  list = FALSE,
                                  times = 1)
Train <- df[ trainIndex,]
Test  <- df[-trainIndex,]


results <- data.frame()
trees <-seq(0,500,25)

for(i in 2:length(trees)){
  
  print(i)
  
  formula <- as.formula(paste(target,"~."))
  
  fit <- randomForest(formula,   data=Train,ntree=trees[i])
  
  predictions <- predict(fit,Test)
  Matrix <- confusionMatrix(predictions,Test$Income)
  
  results <- rbind(results,data.frame(fit$ntree,Matrix$overall[1]))
  
}

colnames(results)<- c('Trees','Accuracy')


ggplot(data=results, aes(x=Trees, y=Accuracy, group=1)) + 
  geom_line(colour="red", linetype="dashed", size=1.5) + 
  geom_point(colour="red", size=4, shape=21, fill="white") +
  geom_text(aes(label=Trees),hjust=0,size = 7, vjust=0)

ggplot(results, aes(x=Trees, y = Accuracy,fill=Trees)) + geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90))+coord_cartesian(ylim = c(min(results$Accuracy),max(results$Accuracy)))

ggplot(results, aes(x=Trees, y = Accuracy,fill=as.factor(Trees))) + geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90))+coord_cartesian(ylim = c(min(results$Accuracy),max(results$Accuracy)))+
  geom_text(aes(label=Trees),hjust=0,size = 7, position = position_dodge(0.75), vjust=-.65,hjust=0)


round(max(results$Accuracy)-min(results$Accuracy),3)


