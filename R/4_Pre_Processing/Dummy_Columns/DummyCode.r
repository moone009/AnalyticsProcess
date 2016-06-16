#########################################################################################################
# Name             : DummyCode
# Date             : 06-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Creates dummy variables for factors and characters 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150608              initial
#########################################################################################################


##_____________________________________________________________________________________________________________________________
# Define function

DummyCode <- function (df,DummyColumns) {
  
  # Create a copy of original dataset
  FileToDummyCode = df
  # greate a unique id for this dataset to group on
  FileToDummyCode$ByVarID = 1:nrow(FileToDummyCode)
  
  for( i in 1:length(DummyColumns)){
    
    print(DummyColumns[i])
    
    # Switch data to character
    Table=as.data.frame.matrix(table(FileToDummyCode$ByVarID,FileToDummyCode[,DummyColumns[i]]))
    
    # rename our columns
    colnames(Table) = paste(DummyColumns[i],'.',colnames(Table),sep='')
    colnames(Table) = gsub(' ','', colnames(Table))
    colnames(Table) = gsub(')','', colnames(Table))
    colnames(Table) = gsub('\\(','', colnames(Table))
    colnames(Table) = gsub('-','', colnames(Table))
    colnames(Table) = gsub('+','', colnames(Table))
    
    
    # bind data back to original dataset
    df = cbind(df,Table)                            
    
  }
  return(df)
}

##_____________________________________________________________________________________________________________________________
# setup test data
mtcars$carb = as.factor(mtcars$carb)
mtcars$am = as.character(mtcars$am)

##_____________________________________________________________________________________________________________________________
# Execute function
df = DummyCode(mtcars,c('carb','am'))

head(df)


 