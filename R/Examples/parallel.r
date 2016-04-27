

data = rbind(mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars
             ,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars
             ,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars)

data$RowIdx <- 1:nrow(data)
parralel_prep <- function(x,n){
  
  OneCore <- .25*n
  TwoCore <- .5*n
  ThreeCore <- .75*n
  FourCore <- n+1
  
  if(x < OneCore){return(1)}
  if(x < TwoCore && x >= OneCore){return(2)}
  if(x < ThreeCore && x >= TwoCore){return(3)}
  if(x < FourCore && x >= ThreeCore){return(4)}
  
}

parralel_prep <- function(df,cores){
  
  # Split the data by available cores
  Increment <- 1/cores
  Collection <- round(seq(Increment,1,Increment)* nrow(df),0)
  
  # Id do split the data on
  df$idx <- 1:nrow(df)
  
  # Use the Pidx as the Parallel index (foreach(i = 1:n) %dopar% )
  df$Pidx <- 0
  
  for(i in 1:length(Collection)){
    df[df$idx <= Collection[i] & df$Pidx == 0,]$Pidx = i
  }  
  
  return(df)
}

data$Pidx <- apply(data[12],1,parralel_prep,nrow(data))
table(data$Pidx)


library(doSNOW)
library(foreach)

registerDoSNOW(makeCluster(4, type = "SOCK"))


example <- function(x,n){
  
  if(x == 8){return('large')
  }else if(x == 6){return('Medium')
  }else if(x == 4){return('Small')
  }else{return('Unknown')}
  
}


system.time(NewDataFrame <- foreach(i = 1:4) %dopar% {
  print(i)
 
   apply(subset(data, Pidx == i)[2],1,example)
})

NewDataFrame <- rbindlist(Map(as.data.frame, NewDataFrame))
colnames(NewDataFrame) <- c('ParRow')
data <- cbind(data,NewDataFrame)




seq.gen <- function(a,b,...){
  seq(a,b,...)
}
