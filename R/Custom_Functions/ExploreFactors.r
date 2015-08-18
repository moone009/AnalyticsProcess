#########################################################################################################
# Name             : ExploreFactors
# Date             : 06-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Quickly iterates over a dataframe and provides frequency and plots of factors 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150608              initial
#########################################################################################################


##_____________________________________________________________________________________________________________________________
# Define function
ExploreFactors <- function(dataframe,plots){
  trim <- function (x) gsub("^\\s+|\\s+$", "", x)
  NewDataFrame = dataframe
  SDF <- data.frame(VariableName = character(),
                    Count=numeric(), 
                    Freq=numeric())
  
  for (i in 1:length(NewDataFrame)){
    
    if(class(NewDataFrame[i][,]) == 'factor' & nlevels(NewDataFrame[i][,]) < 32){
      
      if(class(NewDataFrame[i][,]) == 'factor' | class(NewDataFrame[i][,]) == 'character'){
        Name = colnames(NewDataFrame[i])
        
        print(Name)
        Table=as.data.frame(table(NewDataFrame[, i]))
        Table$Var1 = paste(Name,"-",Table$Var1,sep='')
        Table$FreqPer = round(Table$Freq /sum(Table$Freq),3)
        Table <- Table[order(Table$Freq),] 
        SDF = rbind(SDF,Table)
        
        if(plots == 1){
          png(paste(Name,'-Barplot.png',sep=''))
          barplot(table(NewDataFrame[, i]), main="Explorer Function Barchart Output",  xlab=Name,col="blue", ylab="Count",density=55)
          
          dev.off()
          
          png(paste(Name,'-Piechart.png',sep=''))
          mytable <- table(NewDataFrame[, i])
          lbls <- paste(names(mytable), "\n", mytable, sep="")
          pie(mytable, labels = lbls, 
              main="Explorer Function Piechart Output",xlab =Name)
          dev.off()
          
        }          
      }   
    } 
  }
  SDF$Var1 = trim(SDF$Var1)
  return(SDF)
}


##_____________________________________________________________________________________________________________________________
# Execute function
mtcars$carb = as.factor(mtcars$carb)
mtcars$am = as.factor(mtcars$am)

ExploreFactors(mtcars,0)
ExploreFactors(mtcars,1)
