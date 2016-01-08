dff <- mtcars

dff <- as.data.table(dff)

dff_sum <- dff[,list(HP_Sum=sum(mpg)),by=c('cyl', 'gear')]

dff_sum <- dff[,list(HP_Sum=sum(mpg),mean=mean(mpg),sd=sd(mpg),records= .N),by=c('cyl', 'gear')]

dff_ct <- dff[,list(records= .N),by=c('cyl', 'gear')]

dff[,list(mean=mean(mpg),sd=sd(mpg)),by=cyl]
