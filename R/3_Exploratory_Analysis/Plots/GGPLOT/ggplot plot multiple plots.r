#########################################################################################################
# Name             : ggplot plot multiple plots
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Plotting multiples
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################

library(gridExtra)
# Kernel density plots for mpg
# grouped by number of gears (indicated by color)
graph1 = qplot(gear, hp, data=mtcars, geom=c("boxplot", "jitter"), 
               fill=gear, main="HP by Gear Number",
               xlab="", ylab="Horse Power")

# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmittion type is represented by shape and color
graph2 = qplot(hp, mpg, data=mtcars, shape=as.factor(cyl), color=am, 
               facets=gear~cyl, size=I(3),
               xlab="Horsepower", ylab="Miles per Gallon") 

# Separate regressions of mpg on weight for each number of cylinders
graph3 = qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
               method="lm", formula=y~x, color=cyl, 
               main="Regression of MPG on Weight", 
               xlab="Weight", ylab="Miles per Gallon")

# Boxplots of mpg by number of gears 
# observations (points) are overlayed and jittered
graph4 = qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
               fill=gear, main="Mileage by Gear Number",
               xlab="", ylab="Miles per Gallon")

grid.arrange( graph1, graph2,graph3,graph4, ncol=2)
 