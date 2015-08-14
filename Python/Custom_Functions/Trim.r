#########################################################################################################
# Name             : Trim
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Remove whitespace
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################

trim <- function (x) gsub("^\\s+|\\s+$", "", x)
 
