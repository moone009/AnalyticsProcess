#########################################################################################################
# Name             : ggplot boxplots
# Date             : 09-12-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : For Fun
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150912              initial
########################################################################################################

library(dplyr)
library(ggplot2)
##_____________________________________________________________________________________________________________________________
# Plot1
dat<-data.frame(ve=rep(c("FF","GG"),times=50),
                metValue=rnorm(100),metric=rep(c("A","B","D","C"),each=25),
                atd=rep(c("HH","GG"),times=50))
dat2<-data.frame(ve=rep(c("FF","GG"),times=50),
                 metValue=rnorm(100),metric=rep(c("A","B","D","C"),each=25),
                 atd=rep(c("HH","GG"),times=50))

Plot1 <-  ggplot(dat) + 
  geom_boxplot(aes(x=ve, y=metValue, fill=metric), alpha=.35, w=0.6, notch=FALSE, na.rm = TRUE) +  
  geom_hline(yintercept=mean(dat$metValue), colour="#DD4466", linetype = "longdash") +
  scale_fill_manual(values=c("red","blue","green","yellow"))

#P + geom_jitter(data=dat2, aes(x=ve, y=metValue, colour=atd), 
#                size=2, shape=4, alpha = 0.4, 
#                position = position_jitter(width = .03, height=0.03), na.rm = TRUE) + 
#  scale_colour_manual(values=c("red","blue"))
 

##_____________________________________________________________________________________________________________________________
# Plot2
tbl <- as.data.frame(table(mpg$manufacturer))
mpg <- inner_join(mpg, tbl, by = c("manufacturer" = "Var1"))
mpg$manufacturer = paste(mpg$manufacturer,':',mpg$Freq,'obs')
Plot2 <- ggplot(mpg, aes(factor(manufacturer), cty, fill = mpg$manufacturer))
Plot2 <- Plot2 + geom_boxplot(lwd=0.5) + ylim(0,50) + coord_flip()
Plot2 <- Plot2 + theme(legend.position = "none", axis.title.y=element_blank())


##_____________________________________________________________________________________________________________________________
# Plot3



 

##_____________________________________________________________________________________________________________________________
# Print All Plots
Plot1
Plot2
