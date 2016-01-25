###############################################################################################################################
# Name             : Target Variable Correlation
# Date             : 10-19-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Another way of viewing correlation to Target Variable
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20151019             initial
###############################################################################################################################

# Load libraries
library(reshape2)
library(ggplot2)


##________________________________________________________________________________________________________________________________
# Load Data and set Target

df <- mtcars
Target <- 'mpg'
cormat <-cor(df)

##________________________________________________________________________________________________________________________________
# Process Data

df <- as.data.frame(cormat) 
df$Vars = rownames(df) 
df<- subset(df,Vars == Target) 
df<- melt(df,id='Vars') 
df<-df[order(df$value),] 
df <- subset(df,variable != Target) 


# Comment out just used to show all colors
# print('check to see row 5 is not setting value to .2')
# df[3][5,] <- .2

df$value = round(df$value,2)


##________________________________________________________________________________________________________________________________
# Update our correlation values status 

df$Strength = '' 
df[df$value > 0.75 ,which(colnames(df)=="Strength")] = 'Positive_Strong' 
df[df$value > .5  & df$value <= .75 ,which(colnames(df)=="Strength")] = 'Positive_Medium' 
df[df$value > .35 & df$value <= .5 ,which(colnames(df)=="Strength")] = 'Positive_Weak' 
df[df$value <= .35 ,which(colnames(df)=="Strength")] = 'None' 

df[df$value <= -.35 & df$value <= .5 ,which(colnames(df)=="Strength")] = 'Negative_Weak' 
df[df$value < -.5  & df$value <= .75 ,which(colnames(df)=="Strength")] = 'Negative_Medium' 
df[df$value < -0.75 ,which(colnames(df)=="Strength")] = 'Negative_Strong' 

# Convert to factor for legend 
df$Strength = as.factor(df$Strength) 
df$value = round(df$value,2)
df$value = abs(df$value)
##________________________________________________________________________________________________________________________________
# Build Plot 

# Custom colors to go along with our horizontal line 
corrcolors = c(Positive_Strong="#00CC00", Positive_Weak="#FF9933", Positive_Medium="#CCFF66",None = '#FF6666',
			   Negative_Strong="#86B1C1", Negative_Weak="#A886C1", Negative_Medium="#93C186"
) 

ggplot(df, aes(x=reorder(variable,value), value,fill=Strength)) + geom_bar(stat="identity", position="dodge")+ 
  geom_hline(aes(yintercept=.3),color='black')     + 
  geom_hline(aes(yintercept=.5),color='black') + 
  geom_hline(aes(yintercept=.75),color='black')    + 
  ylab("Correlation (Absolute Value)") + 
  xlab("Variables") + 
  geom_text(aes(y=value+.02, label = value))+
  ggtitle(paste("Correlation by Target Variable: ", Target ))+ 
  scale_fill_manual(values=corrcolors)+theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
