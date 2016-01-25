###############################################################################################################################
# Name             : Trim Whitespace
# Date             : 01-22-2016
# Author           : Christopher Mooney
# Dept             : Business Analytics
# Purpose          : Trim whitespace from text
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150122             initial
###############################################################################################################################

library(stringr)
items <- c('    Today    ', ' The   red    fox   runs   ', '    Life is   Wonderful   !',
           'HAPPPY                      NEW                   YEAR')


trim <-  function(x){ x <- gsub('  ',' ',x) 
                      x <- gsub('  ',' ',x) 
                      x <- gsub('  ',' ',x) 
                      x <- gsub('  ',' ',x) 
                      x <- str_trim(x, side = c("both"))
                      return(x)}

as.data.frame(items)
as.data.frame(trim(items))

