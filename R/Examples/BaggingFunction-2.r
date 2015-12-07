library(plyr)
library(rpart)
require(nnet)

sample(iris$Species, size = 30, replace = TRUE)
df = iris[sample(nrow(iris), 50,replace = TRUE), ]


bootModel <- function(df,Class,NumberOfModels){
  print(Class)
  trees <- vector(mode = "list", length =NumberOfModels)
  n <- nrow(df)
  bootsamples <- rmultinom(length(trees), n, rep(1, n)/n)
  
  for(boots in 1:length(trees)){
    
    # Convert bootsamples to datafame
    TestingData <- df[sample(nrow(df), 50,replace = TRUE), ]
    
    # We are using 1:length of our original dataset because we do not want the obs variable
    formula <- as.formula(paste(Class," ~ ."))
    mod <-  rpart(formula, data = TestingData,control = rpart.control(xval = 0))
    # mod <-  multinom(formula, data = TestingData)

    # Update our tree list to this specific model
    trees[[boots]] <- mod
    
    print(paste('created tree number:',boots,'with',nrow(TestingData),'observations'))
    collection<-c('[.]1','[.]2','[.]3','[.]4','[.]5','[.]6','[.]7','[.]8','[.]9')
    TestingData$ID <- rownames(TestingData)
    for(i in 1:length(collection)){TestingData$ID <-gsub(collection[i],'',TestingData$ID)}
    print(table(count(TestingData, 'ID')$freq))
    cat("\n")
  }
  
  return(trees)
  
}

##_____________________________________________________________________________________________________________________________

df <- iris
trees <- bootModel(df,'Species',25)


data <- data.frame(id = 1:150)
for (i in 1:length(trees)) {
  tmp <- as.data.frame(predict(trees[[i]], newdata = df))
  data = cbind(data,tmp)
}

data$SetosaMean <- rowMeans(data[,c(which(colnames(data)=='setosa'))])
data$versicolorMean <- rowMeans(data[,c(which(colnames(data)=='versicolor'))])
data$virginicaMean <- rowMeans(data[,c(which(colnames(data)=='virginica'))])

for(i in 1:nrow(data)){
  
  idx <- which(data[,c(grep("Mean", names(data)))][i,] == max(data[,c(grep("Mean", names(data)))][i,]))
  class <- names(data[,c(grep("Mean", names(data)))])[idx]  
  data$Class[i] <- gsub("Mean","",class)
}

predtab <- table(df$Species, data$Class)
cf_matrix(predtab)


         