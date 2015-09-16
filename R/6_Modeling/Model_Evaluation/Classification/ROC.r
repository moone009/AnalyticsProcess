
library(sqldf)
library(ROCR)

test <- data.frame(id = c(1,  1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
                   pred = c(0.9,  0.9,	0.9,	0.8,	0.8,	0.8,	0.6,	0.6,	0.6,	0.6,	0.6,	0.45,	0.45,	0.45,	0.45,	0.5,	0.6,	0.7,	0.5,	0.3,	0.75,	0.3,	0.7,	0.3,	0.3,	0.3,	0.3,	0.3))

sqldf("select * from test order by pred")

pred <- prediction(test$pred,test$id)
perf <- performance(pred, "tpr", "fpr")

plot(perf)
abline(.0,1,col="blue",lty=3)
points(.416,1, col = "red")
text(.65,.95,  "In order to classify 100% of our targets correctly we must accept missclassifying 41%")

points(.333,.687, col = "green")
text(.55,.65,  "In order to classify 68% of our targets correctly we must accept missclassifying 37%")

points(.25,.375, col = "blue")
text(.46,.33,  "In order to classify 37% of our targets correctly we must accept missclassifying 25%")



TP <- sqldf("select * from test where id = 1 and pred >= .45")
PosCT <- table(test$id)[2]
nrow(TP)/as.numeric(PosCT)

FP <- sqldf("select * from test where id = 0 and pred >= .45")
FalseCT <- table(test$id)[1]
nrow(FP)/as.numeric(FalseCT)


TP <- sqldf("select * from test where id = 1 and pred >= .7")
PosCT <- table(test$id)[2]
nrow(TP)/as.numeric(PosCT)

FP <- sqldf("select * from test where id = 0 and pred >= .7")
FalseCT <- table(test$id)[1]
nrow(FP)/as.numeric(FalseCT)

TP <- sqldf("select * from test where id = 1 and pred >= .6")
PosCT <- table(test$id)[2]
nrow(TP)/as.numeric(PosCT)

FP <- sqldf("select * from test where id = 0 and pred >= .6")
FalseCT <- table(test$id)[1]
nrow(FP)/as.numeric(FalseCT)

test <- data.frame(id = c(1,  1,  1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
                   pred = c(0.9,  0.9,	0.9,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.8,	0.5,	0.6,	0.7,	0.5,	0.3,	0.75,	0.3,	0.7,	0.3,	0.3,	0.3,	0.3,	0.3))


sqldf("select * from test order by pred")

pred <- prediction(test$pred,test$id)
perf <- performance(pred, "tpr", "fpr")

plot(perf)
points(.416,1, col = "red")

TP <- sqldf("select * from test where id = 1 and pred >= .5")
PosCT <- table(test$id)[2]
nrow(TP)/as.numeric(PosCT)

FP <- sqldf("select * from test where id = 0 and pred >= .5")
FalseCT <- table(test$id)[1]
nrow(FP)/as.numeric(FalseCT)




test <- data.frame(id = c(1,  1,  1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
                   pred = c(0.55,  0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.55,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45))

sqldf("select * from test order by pred")

pred <- prediction(test$pred,test$id)
perf <- performance(pred, "tpr", "fpr")

plot(perf)


test <- data.frame(id = c(1,  1,  1,  1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
                   pred = c(0.7,  0.7,	0.7,	0.6,	0.6,	0.6,	0.55,	0.55,	0.55,	0.55,	0.45,	0.45,	0.45,	0.55,	0.55,	0.55,	0.6,	0.6,	0.6,	0.6,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45,	0.45))


sqldf("select * from test order by pred")

pred <- prediction(test$pred,test$id)
perf <- performance(pred, "tpr", "fpr")

plot(perf)
points(.333,.812, col = "red")
text(.5523,.77,  "In order to classify 81% of our targets correctly we must accept missclassifying 33%")

TP <- sqldf("select * from test where id = 1 and pred >= .5")
PosCT <- table(test$id)[2]
nrow(TP)/as.numeric(PosCT)

FP <- sqldf("select * from test where id = 0 and pred >= .5")
FalseCT <- table(test$id)[1]
nrow(FP)/as.numeric(FalseCT)





















