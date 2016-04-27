library(class)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iristraining <- iris[ind==1, 1:4]
iristest <- iris[ind==2, 1:4]

iristrainLabels <- iris[ind==1, 5]
iristestLabels <- iris[ind==2, 5]

results <- data.frame()
for(i in 1:100){
iris_pred <- knn(train = iristraining, test = iristest, cl = iristrainLabels, k=i)
tmp <- data.frame(k = i,acc = mean(iris_pred == iristestLabels))
results <-rbind(tmp,results)
}

require(caret)
data(GermanCredit)

GermanCredit$Amount = scale(GermanCredit$Amount)
GermanCredit$Duration = scale(GermanCredit$Duration)
GermanCredit$Age = scale(GermanCredit$Age)

ind <- sample(2, nrow(GermanCredit), replace=TRUE, prob=c(0.67, 0.33))
train <- GermanCredit[ind==1, -c(which(colnames(GermanCredit)=='Class'))]
test <- GermanCredit[ind==2, -c(which(colnames(GermanCredit)=='Class'))]

trainlbls <- GermanCredit[ind==1,  which(colnames(GermanCredit)=='Class')]
testlbls <- GermanCredit[ind==2, which(colnames(GermanCredit)=='Class')]

results <- data.frame()
for(i in 1:30){
  pred <- knn(train = train, test = test, cl = trainlbls, k=i)
  tmp <- data.frame(k = i,acc = mean(pred == testlbls))
  results <-rbind(tmp,results)
}



