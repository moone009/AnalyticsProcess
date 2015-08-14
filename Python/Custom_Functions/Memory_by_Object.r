#########################################################################################################
# Name             : Memory of Objects
# Date             : 03-23-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Display the memory allocated to each object. 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150323             initial
#########################################################################################################

options("scipen"=100, "digits"=4)

MemUsage = as.data.frame(sort( sapply(ls(),function(x){object.size(get(x))})))
colnames(MemUsage) = 'MB'
MemUsage$GB = round(MemUsage$MB /1073741824,4)
MemUsage$MB = round(MemUsage$MB /1048576,4)
print(tail(MemUsage,10))


 
