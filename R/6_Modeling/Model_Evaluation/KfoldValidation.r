
Bias: Complexity of model ~ More restriction leads to high bias
Variance: error due to sampling of the training set. Model with high variance fits training set closely; less good at generalizing 


library(sqldf)
accs <- rep(0,10)
iris = sqldf("select * from iris order by random()")

for (i in 1:10) {
  # These indices indicate the interval of the test set
  indices <- (((i-1) * round((1/10)*nrow(iris))) + 1):((i*round((1/10) * nrow(iris))))
  
  # Exclude them from the train set
  train <- iris[-indices,]
  
  # Include them in the test set
  test <- iris[indices,]
  print(test)
  
  # A model is learned using each training set
  tree <- rpart(Species ~ ., train, method = "class")
  
  # Make a prediction on the test set using tree
  pred <- predict(tree, test, type = "class")
  
  # Assign the confusion matrix to conf
  conf <- table(test$Species, pred)
  
  # Assign the accuracy of this model to the ith index in accs
  accs[i] <- sum(diag(conf))/sum(conf)
}

# Print out the mean of accs
mean(accs)
print(accs)





 