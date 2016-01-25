


logfile <- read.csv('F:\\Analytics_Process\\R\\SampleData\\logfiles.txt',header=F)
logfile$Col = paste(logfile$V1,logfile$V2)
logfile  = as.data.frame(logfile[,c(3)])
colnames(logfile)<- 'text'
logfile$text = as.character(logfile$text)

parseddata <- data.frame()

idx <- 1
for(i in 1:nrow(logfile)){
  print(idx)
  
  if(pmatch("LOG ID", logfile[idx,]) == 1){LogId = logfile[idx,]}
  if(pmatch("ADDRESS", logfile[idx+1,]) == 1){Address = logfile[idx+1,]}
  
  start = idx +2
  Error = c()
  for(x in start:nrow(logfile)){

    if((!is.na(pmatch("Error", logfile[x,])) == F) == F){Error = c(Error,logfile[x,])}
    
    if((!is.na(pmatch("KWH:", logfile[x,])) == F) == F){break}
    start = start + 1
  }
  
  idx <- start
  
  if(pmatch("KWH:", logfile[idx,]) == 1){Kwh = logfile[idx,]}
  
  idx <- idx + 1
  
  data <- cbind(LogId,Address,Error,Kwh)
  
  parseddata <- rbind(parseddata,data)
  
  if(idx - 1 == nrow(logfile)){
    parseddata$LogId <-   trim(gsub('LOG ID',' ',    parseddata$LogId))
    parseddata$Address <- trim(gsub('ADDRESS:',' ',parseddata$Address))
    parseddata$Error <-   trim(gsub('Error :',' ',   parseddata$Error))
    parseddata$Kwh <-   trim(gsub('KWH:',' ',   parseddata$Kwh))
    parseddata$CT <-1
    break}
}

dcast(parseddata,LogId+Address+Kwh~Error)
  





