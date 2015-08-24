


library(caret)


df = iris
df[[1]] = cut(iris[[1]],3)
df[[2]] = cut(iris[[2]],3)
df[[3]] = cut(iris[[3]],3)
df[[4]] = cut(iris[[4]],3)


##_____________________________________________________________________________________________________________________________
# Split into test and train using Caret Package

trainIndex <- createDataPartition(df$Species, p = .6,
                                  list = FALSE,
                                  times = 1)
irisTrain <- df[ trainIndex,]
irisTest  <- df[-trainIndex,]

##_____________________________________________________________________________________________________________________________
Target = 'Species'
PriorProb = prop.table(table(irisTrain[[Target]]))

Cols = which(colnames(irisTrain) != Target)
Probabilities = data.frame()

for(i in 1:length(Cols)){
  
  TempDataFrame = table(irisTrain[[Target]],irisTrain[[Cols[i]]])
  TempDataFrame[1,] =  TempDataFrame[1,]/30
  TempDataFrame[2,]= TempDataFrame[2,]/30
  TempDataFrame[3,]= TempDataFrame[3,]/30
  
  if(nrow(Probabilities) <1){
    colnames(TempDataFrame) =  paste(colnames(irisTrain)[Cols[i]],colnames(TempDataFrame),sep='-' )
    Probabilities = TempDataFrame
    
  }
  else if(nrow(Probabilities) > 1){
    colnames(TempDataFrame) =  paste(colnames(irisTrain)[Cols[i]],colnames(TempDataFrame),sep='-' )
    Probabilities = cbind(Probabilities,TempDataFrame)
  }
  
}
Probabilities = as.data.frame(Probabilities)
##_____________________________________________________________________________________________________________________________


irisTest$Pred = ''
for(i in 1:nrow(irisTest)){
SL = paste('Sepal.Length-',irisTest[[1]][i],sep='')
SW = paste('Sepal.Width-',irisTest[[2]][i],sep='')
PL = paste('Petal.Length-',irisTest[[3]][i],sep='')
PW = paste('Petal.Width-',irisTest[[4]][i],sep='')
print(paste(SL,SW,PL,PW))

setosa = Probabilities[1,][which(colnames(Probabilities) == SL)]*
  Probabilities[1,][which(colnames(Probabilities) == SW)]*
  Probabilities[1,][which(colnames(Probabilities) == PL)]*
  Probabilities[1,][which(colnames(Probabilities) == PW)]* PriorProb[1]

versicolor =Probabilities[2,][which(colnames(Probabilities) == SL)]*
  Probabilities[2,][which(colnames(Probabilities) == SW)]*
  Probabilities[2,][which(colnames(Probabilities) == PL)]*
  Probabilities[2,][which(colnames(Probabilities) == PW)]* PriorProb[2]

virginica =Probabilities[3,][which(colnames(Probabilities) == SL)]*
  Probabilities[3,][which(colnames(Probabilities) == SW)]*
  Probabilities[3,][which(colnames(Probabilities) == PL)]*
  Probabilities[3,][which(colnames(Probabilities) == PW)]* PriorProb[3]


Target1 = setosa/(setosa+versicolor+virginica)
Target2 = versicolor/(setosa+versicolor+virginica)
Target3 = virginica/(setosa+versicolor+virginica)
colnames(Target1) = rownames(Target1)
colnames(Target2) = rownames(Target2)
colnames(Target3) = rownames(Target3)

cbind(Target3,Target1,Target2)

irisTest$Pred[i] = colnames(cbind(Target3,Target1,Target2))[which(cbind(Target3,Target1,Target2) == max(cbind(Target3,Target1,Target2)))]
}

##_____________________________________________________________________________________________________________________________
table(irisTest$Species,irisTest$Pred)
































