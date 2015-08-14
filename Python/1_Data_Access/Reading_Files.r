#########################################################################################################
# Name             : Reading files
# Date             : 03-23-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Various ways to read files.  
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150323             initial
#########################################################################################################


setwd('F:\\Analytics_Process\\R\\SampleData\\')

t1 = system.time(df <- read.csv('CallCenter.csv',sep=',',header=T))

library(data.table)
t2 = system.time(df <- fread('CallCenter.csv',sep=',',header=T))

t3 = system.time(df <- read.csv2('CallCenter.csv',sep=',',header=T))

t4 = system.time(df <- read.table('CallCenter.csv',sep=',',header=T))

library(sqldf)
t5 = system.time(df <- read.csv.sql('CallCenter.csv',sep=',',header=T))

library(mmap)
t6 = system.time(df <- mmap.csv('CallCenter.csv',sep=',',header=T))


output = rbind(t1,t2,t3,t4,t5,t6)
output = as.data.frame(output)
output$Method = rownames(output)
 
tbl = table(output$Method)
for(i in 1:nrow(output)){tbl[i] = output[[1]][i]}
	
	
barchart(tbl)

 