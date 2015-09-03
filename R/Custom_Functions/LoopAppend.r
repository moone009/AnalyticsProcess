#########################################################################################################
# Name             : LoopAppend
# Date             : 06-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Loops over a director and appends files 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150608              initial
#########################################################################################################


##_____________________________________________________________________________________________________________________________
# Define function

LoopAppend <- function (FileDir,Seperator,IsHeader,quote) {
  
  # find the files that you want
  list.of.files <- list.files(FileDir)
  
  # Create empty frame
  ReturnFile = data.frame()
  
  for( i in 1:length(list.of.files)){
    
    FileToRead = paste(FileDir,list.of.files[i],sep="")
    print(FileToRead)
    if(quote == T){
      Df = read.csv(FileToRead,sep=Seperator,quote = "",header = IsHeader)
    }
    if(quote == F){
      Df = read.csv(FileToRead,sep=Seperator,header = IsHeader)
    }
    if(i >= 1){ReturnFile = rbind(ReturnFile,Df)}
    
  }
  print(i)
  return(ReturnFile)
  
}
##_____________________________________________________________________________________________________________________________
# setup test data
#dir.create('F:/LoopAppend')
#write.csv(iris,'f:/LoopAppend/iris-1.csv')
#write.csv(iris,'f:/LoopAppend/iris-2.csv')
#write.csv(iris,'f:/LoopAppend/iris-3.csv')

# Check our files
#list.files('F:/LoopAppend')

##_____________________________________________________________________________________________________________________________
# Execute function
#df = LoopAppend('F:/LoopAppend/',',',T,F)












