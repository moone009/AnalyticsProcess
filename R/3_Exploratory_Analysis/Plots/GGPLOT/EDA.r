test = EDA(mtcars)


 EDA <-function(df){
  require(ggplot2)
  require(gridExtra)
  require(GGally)
  require(tidyr)
  
  NewDir <- paste(getwd(),
                  '/ExploratoryDataAnalysis-',
                  gsub(':','',Sys.time()),
                  '/',sep='')
  OldDir <- getwd()

  # Create Directory for files
  dir.create(NewDir)
  setwd(NewDir)
  
  
  # Extract Data Types
  cols <- sapply(df, class)
  numeric_cols <- names(which(cols =='numeric'))
  factor_cols <- names(which(cols =='factor'))
  print(paste('Numeric Columns:',paste(numeric_cols, collapse=", ")))
  print(paste('Factor Columns:',paste(factor_cols, collapse=", ")))
  
  # Log transform numeric data types for comparison
  logdf = log(df[,c(numeric_cols)])
    
    # Bar plots
    if(length(factor_cols) >= 1){
      for(idx in 1:length(factor_cols)){
        
        c <- ggplot(df,  aes_string(factor_cols[idx]))
        c <- c+ geom_bar() + 
          xlab(factor_cols[idx]) +
          ggtitle(paste('barplot:',factor_cols[idx],'\nRun Date:', Sys.Date()))
   
        ggsave(file=paste('barplot-',factor_cols[idx],'.png',sep=''), width=5, height=4, c) 
        
      }
    }
    
    # Histograms
    if(length(numeric_cols) >= 1){  
      for(idx in 1:length(numeric_cols)){
        
        # Calculate skewness
        skewness <- round((3*(mean(df[[numeric_cols[idx]]]) - median(df[[numeric_cols[idx]]])))/sd(df[[numeric_cols[idx]]]),2)
        logskewness <- round((3*(mean(logdf[[numeric_cols[idx]]]) - median(logdf[[numeric_cols[idx]]])))/sd(logdf[[numeric_cols[idx]]]),2)
        
        # Calculate mean,meadian, and 
        uni <- paste('mean:',round(mean(df[[numeric_cols[idx]]]),2),
                      'median:',round(median(df[[numeric_cols[idx]]]),2),
                      'sd:',round(sd(df[[numeric_cols[idx]]]),2),'skewness:',skewness)
        log_uni <- paste('mean:',round(mean(logdf[[numeric_cols[idx]]]),2),
                     'median:',round(median(logdf[[numeric_cols[idx]]]),2),
                     'sd:',round(sd(logdf[[numeric_cols[idx]]]),2),'skewness:',logskewness)
        
        p1 <- ggplot(data=df, aes_string(numeric_cols[idx])) + 
          geom_histogram() + 
          xlab(numeric_cols[idx]) + 
          ggtitle(paste('Histogram:',numeric_cols[idx],'\n',uni,'\nRun Date:', Sys.Date()))
        
        p2 <- ggplot(data=logdf, aes_string(numeric_cols[idx])) + 
          geom_histogram() + 
          xlab(numeric_cols[idx]) +
          ggtitle(paste('Log Transformed Histogram:',numeric_cols[idx],'\n',log_uni,'\nRun Date:', Sys.Date()))

        #save plots
        png(paste('Histogram-',numeric_cols[idx],'.png',sep='') ,width = 1080, height = 680)  
        grid.arrange(p1, p2, nrow=1)  
        dev.off()
        
      }
    }
     
    # ScatterPlots
    corr_list = c()
    if(length(numeric_cols) >= 1){  
      for(idx in 1:length(numeric_cols)){
        
        tmp <- numeric_cols[-idx]
        
        for(idx_i in 1:length(tmp)){
          
          corr <- cor(df[[numeric_cols[idx]]],df[[ tmp[idx_i]]])
          
          # only append values where correlation is greater than .75 or less than .75
          if( (corr >.75) || (corr < -.75) ){
            corr_list <- c(paste(numeric_cols[idx],',',tmp[idx_i],',',corr,sep=''),corr_list)
          }
          
          p1 <-  ggplot(df, aes_string(numeric_cols[idx], tmp[idx_i])) + 
            geom_point() +  
            geom_smooth(method=loess) +       
            ggtitle(paste('Scatterplot:',numeric_cols[idx],'-',tmp[idx_i],'\ncorreltaion:',round(corr,2),'\nRun Date:', Sys.Date()))
          #print(p1)  
          #ggsave(file=paste('Scatterplot-',numeric_cols[idx],'-', tmp[idx_i],'.png',sep=''), width=5, height=4, p1) 
          
        }
      }
    }
  
  # transform correlation list into data frame
  ExportCorr <- as.data.frame(corr_list)
  ExportCorr <- separate(data = ExportCorr, col = corr_list, into = c("Var1", "Var2","Cor"), sep = "\\,")
  ExportCorr <- ExportCorr[!duplicated(ExportCorr[,3]),]
  ExportCorr$Cor = round(as.numeric(ExportCorr$Cor),3)
  ExportCorr <- ExportCorr[order(-ExportCorr$Cor),] 
  setwd(OldDir)
  print(paste('files located at:',NewDir))
  return(ExportCorr)
  
}
