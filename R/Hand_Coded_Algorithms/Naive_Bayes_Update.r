outlook = c('rainy','rainy','overcast','sunny','sunny','sunny','overcast','rainy','rainy','sunny','rainy','overcast','overcast','sunny')
Temp = c('hot','hot','hot','mild','cold','cold','cold','mild','cold','mild','mild','mild','hot','mild')
Humidity = c('high','high','high','high','normal','normal','normal','high','normal','normal','normal','high','normal','high')
Windy = c('false','true','false','false','false','true','true','false','false','false','true','true','false','true')
Golf = c('n','n','y','y','y','n','y','n','y','y','y','y','y','n')

df = cbind(outlook,Temp,Humidity,Windy,Golf)
df = as.data.frame(df)
attach(df)

Input_Outlook = 'rainy'
Input_Temp = 'mild'
Input_Humidity = 'normal'
Input_Windy = 'true'

outlook = table(df$Golf,df$outlook)
outlook[1,] =  outlook[1,]/NoGolf
outlook[2,]= outlook[2,]/YesGolf

Temp = table(df$Golf,df$Temp)
Temp[1,] =  Temp[1,]/NoGolf
Temp[2,]= Temp[2,]/YesGolf

Humidity = table(df$Golf,df$Humidity)
Humidity[1,] =  Humidity[1,]/NoGolf
Humidity[2,]= Humidity[2,]/YesGolf

Windy = table(df$Golf,df$Windy)
Windy[1,] =  Windy[1,]/NoGolf
Windy[2,]= Windy[2,]/YesGolf

Target
Probabilities = as.data.frame(cbind(outlook,Temp,Humidity,Windy))
ProbabilitiesOverAll = cbind(outlookCT,TempCT,HumidityCT,WindyCT)

No = Probabilities[1,][which(colnames(Probabilities) == Input_Outlook)]*
Probabilities[1,][which(colnames(Probabilities) == Input_Temp)]*
Probabilities[1,][which(colnames(Probabilities) == Input_Humidity)]*
Probabilities[1,][which(colnames(Probabilities) == Input_Windy)]* Target[1]

Yes =Probabilities[2,][which(colnames(Probabilities) == Input_Outlook)]*
Probabilities[2,][which(colnames(Probabilities) == Input_Temp)]*
Probabilities[2,][which(colnames(Probabilities) == Input_Humidity)]*
Probabilities[2,][which(colnames(Probabilities) == Input_Windy)]* Target[2]


YesPlay = Yes/(Yes+No)
NoPlay = No/(Yes+No)

YesPlay
NoPlay

####################################################################################################################
####################################################################################################################

outlook = c('rainy','rainy','overcast','sunny','sunny','sunny','overcast','rainy','rainy','sunny','rainy','overcast','overcast','sunny')
Temp = c('hot','hot','hot','mild','cold','cold','cold','mild','cold','mild','mild','mild','hot','mild')
Humidity = c('high','high','high','high','normal','normal','normal','high','normal','normal','normal','high','normal','high')
Windy = c('false','true','false','false','false','true','true','false','false','false','true','true','false','true')
Golf = c('n','n','y','y','y','n','y','n','y','y','y','y','y','n')

df = cbind(outlook,Temp,Humidity,Windy,Golf)
df = as.data.frame(df)

Target = 'Golf'
PriorProb = prop.table(table(df[[Target]]))

Cols = which(colnames(df) != Target)
Probabilities = data.frame()

for(i in 1:length(Cols)){
  
  TempDataFrame = table(df[[Target]],df[[Cols[i]]])
  TempDataFrame[1,] =  TempDataFrame[1,]/NoGolf
  TempDataFrame[2,]= TempDataFrame[2,]/YesGolf
  
  if(nrow(Probabilities) <1){
  Probabilities = TempDataFrame
  }
  else if(nrow(Probabilities) > 1){
  Probabilities = cbind(Probabilities,TempDataFrame)
  }
  
}
Probabilities = as.data.frame(Probabilities)

No = Probabilities[1,][which(colnames(Probabilities) == Input_Outlook)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Temp)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Humidity)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Windy)]* PriorProb[1]

Yes =Probabilities[2,][which(colnames(Probabilities) == Input_Outlook)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Temp)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Humidity)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Windy)]* PriorProb[2]

 
YesPlay = Yes/(Yes+No)
NoPlay = No/(Yes+No)

YesPlay
NoPlay






df = iris
df[[1]] = cut(iris[[1]],3)
df[[2]] = cut(iris[[2]],3)
df[[3]] = cut(iris[[3]],3)
df[[4]] = cut(iris[[4]],3)

Input_Outlook = '(5.5,6.7]'
Input_Temp = '(2,2.8]'
Input_Humidity = '(0.994,2.97]'
Input_Windy = '(0.0976,0.9]'


Target = 'Species'
PriorProb = prop.table(table(df[[Target]]))

Cols = which(colnames(df) != Target)
Probabilities = data.frame()

for(i in 1:length(Cols)){
  
  TempDataFrame = table(df[[Target]],df[[Cols[i]]])
  TempDataFrame[1,] =  TempDataFrame[1,]/50
  TempDataFrame[2,]= TempDataFrame[2,]/50
  TempDataFrame[3,]= TempDataFrame[3,]/50
  
  if(nrow(Probabilities) <1){
    Probabilities = TempDataFrame
  }
  else if(nrow(Probabilities) > 1){
    Probabilities = cbind(Probabilities,TempDataFrame)
  }
  
}
Probabilities = as.data.frame(Probabilities)

setosa = Probabilities[1,][which(colnames(Probabilities) == Input_Outlook)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Temp)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Humidity)]*
  Probabilities[1,][which(colnames(Probabilities) == Input_Windy)]* PriorProb[1]

versicolor =Probabilities[2,][which(colnames(Probabilities) == Input_Outlook)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Temp)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Humidity)]*
  Probabilities[2,][which(colnames(Probabilities) == Input_Windy)]* PriorProb[2]

virginica =Probabilities[3,][which(colnames(Probabilities) == Input_Outlook)]*
  Probabilities[3,][which(colnames(Probabilities) == Input_Temp)]*
  Probabilities[3,][which(colnames(Probabilities) == Input_Humidity)]*
  Probabilities[3,][which(colnames(Probabilities) == Input_Windy)]* PriorProb[3]


Target1 = setosa/(setosa+versicolor+virginica)
Target2 = versicolor/(setosa+versicolor+virginica)
Target3 = virginica/(setosa+versicolor+virginica)

 
Target1
Target2
Target3




































