#########################################################################################################
# Name             : ROC Curve
# Date             : 20151222
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Training
# Called by        : 
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20151222              initial
#########################################################################################################


## Load Libraries
library(ROCR)
library(ggplot2)
library(caret)

## Load Data
mydata <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
mydata$rank = as.factor(mydata$rank)

##_____________________________________________________________________________________________________________________________
# Split into test and train using Caret Package

trainIndex <- createDataPartition(mydata$admit, p = .6,
                                  list = FALSE,
                                  times = 1)
Train <- mydata[ trainIndex,]
Test  <- mydata[-trainIndex,]

##_____________________________________________________________________________________________________________________________
# Model

mylogit <- glm(admit ~ gre + gpa + rank, data = Train, family = "binomial")

preds <- predict(mylogit, newdata = Test, type = "response")

Test = cbind(Test,preds)
##_____________________________________________________________________________________________________________________________
# Setup RO Curve

preds <- prediction(preds,Test$admit)
perf <- performance(preds, "tpr", "fpr")

auc <- performance(preds, measure = "auc")
auc <- auc@y.values[[1]]

roc.data <- data.frame(fpr=unlist(perf@x.values),
                       tpr=unlist(perf@y.values),
                       model="GLM")

plt<- ggplot(roc.data, aes(x=fpr, ymin=0, ymax=tpr)) +
  geom_ribbon(alpha=0.2) +
  geom_line(aes(y=tpr)) +
  geom_abline(intercept = 0.00, colour = "blue", size = 2)+
  ggtitle(paste0("ROC Curve w/ AUC=", round(auc,2)))+
  theme(
    axis.title=element_text(size=16,face="bold"),
    title =element_text(size=16, face='bold')
  )
plt

colors <- c('blue','green','red','black','blueviolet','hotpink','orange')
probabilites <- c(.3,.4,.5,.6,.7,.8,.9)
position <- rev(seq(.08, .2, 0.02))
TRates <- c()
FRates <- c()


for(i in 1:length(probabilites)){
  
  TPF <- nrow(subset(Test,preds >= probabilites[i] & admit == 1))/as.numeric( table(Test$admit)[2])
  NPF <- nrow(subset(Test,preds >= probabilites[i] & admit == 0))/as.numeric(table(Test$admit)[1])
  
  TRates <- c(TRates,TPF)
  FRates <- c(FRates,NPF)
  
  plt <-  plt + geom_point(x= NPF ,y = TPF, colour= colors[i],size = 6) 
  
}

leg <- c()
TRates<- round(TRates,2)
FRates <- round(FRates,2)

for(i in 1:length(probabilites)){
  if(TRates[i]==0){TRates[i]<-'0.00'}
  if(FRates[i]==0){FRates[i]<-'0.00'}
  
  leg <- c(paste('Prob:',probabilites[i],'TP:',TRates[i],'FP:',FRates[i]),leg)
}
colors<- rev(colors)
for(i in 1:length(leg)){
  plt <- plt + geom_point(x= .83 ,y =position[i], colour= colors[i],size = 6)
}

plt <- plt + geom_text(aes(x= .9 ,y = .2,label =leg[1]))
plt <- plt + geom_text(aes(x= .9 ,y = .18,label =leg[2]))
plt <- plt + geom_text(aes(x= .9 ,y = .16,label =leg[3]))
plt <- plt + geom_text(aes(x= .9 ,y = .14,label =leg[4]))
plt <- plt + geom_text(aes(x= .9 ,y = .12,label =leg[5]))
plt <- plt + geom_text(aes(x= .9 ,y = .1,label =leg[6]))
plt <- plt + geom_text(aes(x= .9 ,y = .08,label =leg[7]))
plt
