###############################################################################################################################
# Name             : Bagging
# Date             : 09-28-2015
# Author           : Christopher M
# Dept             : Dakota State University
# Purpose          : Examples of how to build bagging model
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    Chmooney      20150928             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load libraries and data
library(rpart)
data("GlaucomaM", package = "TH.data")
source('F:\\Analytics_Process\\R\\6_Modeling\\Model_Evaluation\\Classification\\Confusion Matrix Example.r')

##_____________________________________________________________________________________________________________________________
# Create trees and bootstrapsamples
trees <- vector(mode = "list", length =25)
n <- nrow(GlaucomaM)
bootsamples <- rmultinom(length(trees), n, rep(1, n)/n)

mod <-rpart(Class ~ ., data = GlaucomaM,control =rpart.control(xval = 0))

classprob <- predict(mod,newdata = GlaucomaM)
avg <- rowMeans(classprob, na.rm = TRUE)
predictions <- factor(ifelse(avg > 0.5, "glaucoma",
                             "normal"))
predtab <- table(predictions, GlaucomaM$Class)
SimpleTree <- predtab

##_____________________________________________________________________________________________________________________________

for(boots in 1:length(trees)){
  
  # Convert bootsamples to datafame
  Replicate <- as.data.frame(bootsamples[, boots])
  colnames(Replicate) <- c('Obs')
  
  # Bind data to original dataset
  ModelData <-cbind(GlaucomaM,Replicate)
  
  # Remove any observations of 0
  ModelData <- subset(ModelData, Obs >0)
  
  # Create empty data frame to run model against
  TestingData <-data.frame()
  
  #Temp list for output
  li <- c()
  
  for(x in 1:length(table(ModelData$Obs))){
    
    # subset data based upon observation
    NumberofObs <-  as.numeric(names(table(ModelData$Obs)[x]))
    TmpData <- subset(ModelData, Obs == NumberofObs)
    
    li <- c(li,paste(names(table(ModelData$Obs)[x]),":",table(ModelData$Obs)[x]))
    
    # if obs >1 then we will loop through binding multiple copies
    if(NumberofObs > 1){
        for(i in 1:NumberofObs){
          TestingData <-rbind(TestingData,TmpData)
        }
    }else{TestingData <-rbind(TestingData,TmpData)}
    
  }
  
  # We are using 1:length of our original dataset because we do not want the obs variable
  mod <- rpart(Class ~ ., data = TestingData[,c(1:length(GlaucomaM))],
               control = rpart.control(xval = 0))
  
  # Update our tree list to this specific model
  trees[[boots]] <- mod
  
  
  print(paste('created tree number:',boots,'with',nrow(TestingData),'observations'))
  print(li)
  cat("\n")
}


##_____________________________________________________________________________________________________________________________

table(sapply(trees, function(x) as.character(x$frame$var[1])))


classprob <- matrix(0, nrow = n, ncol = length(trees))
for (i in 1:length(trees)) {
  classprob[,i] <- predict(trees[[i]],
                           newdata = GlaucomaM)[,1]
  classprob[bootsamples[,i] > 0,i] <- NA
}

##_____________________________________________________________________________________________________________________________

avg <- rowMeans(classprob, na.rm = TRUE)
predictions <- factor(ifelse(avg > 0.5, "glaucoma",
                             "normal"))
predtab <- table(predictions, GlaucomaM$Class)
predtab
SimpleTree
cf_matrix(predtab)
cf_matrix(SimpleTree)

round(predtab[1,1] /colSums(predtab)[1] * 100)
round(predtab[2,2] /colSums(predtab)[2] * 100)
