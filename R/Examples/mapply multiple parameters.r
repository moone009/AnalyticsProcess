###############################################################################################################################
# Name             : mapply multiple parameters
# Date             : 07-11-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples to use mapply with multiple parameters
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593       20160323             initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Create Simple function

cartype <- function(x,y){
  
  if(x < 20 & y >250){
    'large'
  }else if(x > 15 & x < 20 & y > 140 & y < 250){
    'medium'
  }else{'small'}
  
}

##_____________________________________________________________________________________________________________________________
# Execute function with multiple parameters

mtcars$Size <- mapply(cartype, mtcars$mpg,mtcars$disp)

ggplot(mtcars, aes(x=mpg, y=disp,color=Size)) +
  geom_point(aes(size = 8,shape = factor(cyl))) +guides(size = FALSE)


mtcars$Size <-mapply(cartype, mtcars[,1],mtcars[,3])

ggplot(mtcars, aes(x=mpg, y=disp,color=Size)) +
  geom_point(aes(size = 5,shape = factor(cyl))) +guides(size = FALSE)


