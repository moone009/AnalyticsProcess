library(doSNOW)
library(foreach)
library(data.table)
registerDoSNOW(makeCluster(5, type = "SOCK"))


df <- data.frame(id <- rnorm(100000000))
colnames(df) <- 'id'
par.prep <- function(x,cores){
  
  x$PprepID <-  as.numeric(cut(1:nrow(x),cores))
  return(x)
  
}

p.func <- function(x){
  if(x > 2){"big"
  }else if(x == 1){"Thats random"
  }else{"Hello"}
}
##_________________________________________________________________________
## for loop


##_________________________________________________________________________
## Apply
system.time(df$func.results <- apply(df[1],1,p.func))
table(df$func.results)


##_________________________________________________________________________
## parallel

df <-par.prep(df,5)

system.time(NewDataFrame <- foreach(i = 1:5) %dopar% {
  print(i)
  
  apply(subset(df, PprepID == i)[1],1,p.func)
})

NewDataFrame <- rbindlist(Map(as.data.frame, NewDataFrame))
colnames(NewDataFrame) <- c('ParRow')
df <- cbind(df,NewDataFrame)
table(df$ParRow)
##_________________________________________________________________________
