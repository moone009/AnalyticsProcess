###############################################################################################################################
# Name             : Static_Missing_Vars
# Date             : 09-09-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : View Missing Data in data frame
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593       20150915             initial
###############################################################################################################################


Static_Missing_Vars <- function (df) {
  
  list = c()
  for(i in 1:length(colnames(df))){
    
    # Agg data
    Cases = table(df[colnames(df)[i]])
    Cases = sort(Cases,decreasing=T)
    
    # Drop Variables that are > 95% missing
    if(sum(is.na(df[colnames(df)[i]]))/nrow(df) >.95)
    {
      list = c(list , c=colnames(df)[i])
    }
    # Drop variables that are close to static (Warning sometimes the minroity help explain variance)  
    else if(Cases[1]/nrow(df)>.95)
    {
      list = c(list , c=colnames(df)[i])     
    }
    else if(Cases[1]/nrow(df)>.8)
    {
      print(paste('Variable',colnames(df)[i],'was not dropped, but',Cases[1]/nrow(df),'of the cases are static'))
    }
  }
  if(length(list)>0){
    print('The following variables will be dropped')
    print(as.data.frame(list))
    df = df[, !(colnames(df) %in% c((list)))]
  }
  
  return(df)
}	 