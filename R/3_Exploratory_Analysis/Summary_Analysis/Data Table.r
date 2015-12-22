#########################################################################################################
# Name             : Data Table Examples
# Date             : 20151222
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Training
# Called by        : 
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20151222              initial
#########################################################################################################

## Load Library
library(data.table)

## Read in Data
df <-fread("f:/EM_AMI_daily_usage.20151221.000000045714.txt",header=T,sep="|")
df_join <- fread("f:/data.table.csv",header=T,sep=",")

## Subsetting Data
df[Utility_ID =='2448232200001-EPBZT100269' & Quality == 'AGG' & QTY > 4500]

## Grouping Pivoting Data
df[ ,.(sum(QTY, na.rm=TRUE) , sd(QTY, na.rm=TRUE))]

df[,.(Kwh_Sum=sum(QTY)),by=Utility_ID]

df[,.(Kwh_Sum=sum(QTY),
	  avg=sum(QTY)/NROW(QTY),
      count=NROW(QTY)
      ),
      by=.(Utility_ID,Quality)]

df[,.(Kwh_Sum=sum(QTY),
	  min=min(QTY),
	  lower=quantile(QTY, .25, na.rm=TRUE),
	  middle=quantile(QTY, .50, na.rm=TRUE),
	  upper=quantile(QTY, .75, na.rm=TRUE),
	  max=max(QTY),
      count=NROW(QTY)
      ),
      by=.(Utility_ID,Quality)]

## Merging Data
df.merge <- merge(df, df_join, by=c('Utility_ID'))

## Faster Merge
setkey(df, Utility_ID)
setkey(df_join, Utility_ID)
df.merge <- merge(df, df_join, by=c('Utility_ID'))
