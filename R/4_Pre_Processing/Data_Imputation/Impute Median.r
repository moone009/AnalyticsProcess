
df <- airquality
sapply(df, function(x) sum(is.na(x)))

f=function(x){
  x<-as.numeric(as.character(x)) #first convert each column into numeric if it is from factor
  x[is.na(x)] =median(x, na.rm=TRUE) #convert the item with NA to median value from the column
  return(x)
}
df=data.frame(apply(df,2,f))
sapply(df, function(x) sum(is.na(x)))



