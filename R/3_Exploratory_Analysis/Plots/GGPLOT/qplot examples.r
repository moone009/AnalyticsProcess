#########################################################################################################
# Name             : qplot examples
# Date             : 08-26-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : For Fun
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150826              initial
########################################################################################################

# Load library
library(ggplot2)

##_____________________________________________________________________________________________________________________________
# histograms
qplot(mpg, fill = as.factor(cyl), data = mtcars,binwidth = 1)
qplot(Sepal.Width, fill = Species, data = iris,binwidth = .1)
qplot(Sepal.Length, fill = Species, data = iris,binwidth = .1)
qplot(Petal.Width, fill = Species, data = iris,binwidth = .1)

##_____________________________________________________________________________________________________________________________
# scatterplots
mtcars$cyl <- as.factor(mtcars$cyl)
qplot(mpg, disp, data = mtcars, color = cyl,size = 5)
qplot(Sepal.Width, Sepal.Length, data = iris, color = Species,size=7)

qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="lm", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")

##_____________________________________________________________________________________________________________________________
# box plots
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

##_____________________________________________________________________________________________________________________________
# density plots
ggplot(data=mtcars, aes(x=mpg, fill=cyl)) +
  geom_density(alpha=0.3)

ggplot(data=iris, aes(x=Petal.Width, fill=Species)) +
  geom_density(alpha=0.3)

ggplot(data=diamonds, aes(x=price, fill=cut)) +
  geom_density(alpha=0.3)


##_____________________________________________________________________________________________________________________________
# density plots
qplot(mpg, disp, data = mtcars, facets = cyl ~ .)
qplot(Sepal.Width, Sepal.Length, data = iris, facets = Species ~ .)

