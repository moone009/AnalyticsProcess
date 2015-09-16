


library(sqldf)
library(ROCR)

test <- data.frame(id = c(1,  1,  1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
                   pred = c(0.9,  0.9,	0.9,	0.8,	0.8,	0.8,	0.6,	0.6,	0.6,	0.6,	0.6,	0.45,	0.45,	0.45,	0.45,	0.5,	0.6,	0.7,	0.5,	0.3,	0.75,	0.3,	0.7,	0.3,	0.3,	0.3,	0.3,	0.3))

pred <- prediction(test$pred,test$id)
perf <- performance(pred, "tpr", "fpr")


probabilites <- c(.3,.4,.5,.6,.7,.8,.9)
TRates <- c()
FRates <- c()

colors <- c('blue','green','red','black','grey','hotpink','orange')
plot(perf)
abline(.0,1,col="blue",lty=3)

for(i in 1:length(probabilites)){
TPF <- nrow(subset(test,pred >= probabilites[i] & id == 1))/as.numeric( table(test$id)[2])

NPF <- nrow(subset(test,pred >= probabilites[i] & id == 0))/as.numeric( table(test$id)[1])

TRates <- c(TRates,TPF)
FRates <- c(FRates,NPF)

points(NPF,TPF, col = colors[i],lwd=5)
text(NPF+.02,TPF,probabilites[i],font=2)
}
leg <- c()
for(i in 1:length(probabilites)){
  leg <- c(paste('Prob:',probabilites[i],'TP:',round(TRates[i],2),'FP:',round(FRates[i],2)),leg)
}

title(main='ROC')
legend(x=.55,y=.25,
       legend= leg,
       col=rev(c('blue','green','red','black','grey','hotpink','orange')),
       cex=.8,
       lwd=2,
       bty = "n")











library(caret)

ggplot(newdata3, aes(x = gre, y = PredictedProb)) + geom_ribbon(aes(ymin = LL,
ymax = UL, fill = rank), alpha = 0.2) + geom_line(aes(colour = rank),
size = 1)


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

plot(perf)
abline(.0,1,col="blue",lty=3)
##_____________________________________________________________________________________________________________________________
# Evaluate Curve

colors <- c('blue','green','red','black','grey','hotpink','orange')
probabilites <- c(.3,.4,.5,.6,.7,.8,.9)
TRates <- c()
FRates <- c()


for(i in 1:length(probabilites)){
  TPF <- nrow(subset(Test,preds >= probabilites[i] & admit == 1))/as.numeric( table(Test$admit)[2])
  
  NPF <- nrow(subset(Test,preds >= probabilites[i] & admit == 0))/as.numeric(table(Test$admit)[1])
  
  TRates <- c(TRates,TPF)
  FRates <- c(FRates,NPF)
  
  points(NPF,TPF, col = colors[i],lwd=5)
  text(NPF+.02,TPF,probabilites[i],font=2)
}
leg <- c()
for(i in 1:length(probabilites)){
  leg <- c(paste('Prob:',probabilites[i],'TP:',round(TRates[i],2),'FP:',round(FRates[i],2)),leg)
}

title(main='ROC')
legend(x=.55,y=.25,
       legend= leg,
       col=rev(c('blue','green','red','black','grey','hotpink','orange')),
       cex=.8,
       lwd=2,
       bty = "n")









