#########################################################################################################
# Name             : Custom GGplot Functions
# Date             : 07-02-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Making life a little easier
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150702              initial
#########################################################################################################
library(ggplot2)
rm(list=ls())
ggplotRegression(lm(mpg ~ disp, data = mtcars))
ggplotZscoreRegression(mtcars,'mpg','disp','gear')
ggplotZscoreRegression(mydf,'qsec','disp','carb','Motor Trend Cars MPG Vs. Displacement','Gears')
ggplotZscoreRegression(NBA,'PayRollZscore','Percent','Team','Motor Trend Cars MPG Vs. Displacement','NBA Team')

##__________________________________________________________________________________________________________________________________________
ggplotRegression <- function (fit) {
  
  require(ggplot2)
  
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       "Intercept =",signif(fit$coef[[1]],5 ),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)))
}



##__________________________________________________________________________________________________________________________________________
ggplotZscoreRegression <- function (MyDataFrame,aes,fact,LabelNames,X,Y,Title,LegendName) {
  
  require(ggplot2)
  DataFrame = MyDataFrame
  corr = cor(DataFrame[[X]],DataFrame[[Y]])
  lm = lm(DataFrame[[X]]~ DataFrame[[Y]],DataFrame)
  
  p <- ggplot(DataFrame, aes)
  p + geom_point(fact)+ stat_smooth(method = "loess", formula = y ~ x, size = .5) + geom_text(LabelNames,hjust=0, vjust=0)+ guides(color=guide_legend(title=LegendName))+ xlab(X) + ylab(Y) + ggtitle(paste(Title,"\nCorrelation:",round(corr,2),"Adj R2:", round(signif(summary(lm)$adj.r.squared, 5),2)," PVal:", round(signif(summary(lm)$coef[2,4], 5),2)  ))
  
}

##__________________________________________________________________________________________________________________________________________


ggplotZscoreRegression(mtcars,                                       # DataFrame
                       aes(mtcars$disp,mtcars$mpg),                  # Aes
                       aes(colour =  factor(mtcars$gear)),           # Factor to color by
                       aes(label =  factor(mtcars$gear)),            # Add Labels To Points
                       'disp',                                       # X
                       'mpg',                                        # Y
                       'Motor Trend Cars MPG Vs. Displacement',      # Title
                       'Gears')                                      # Legend Name


ggplotZscoreRegression(iris,                                         # DataFrame
                       aes(iris$Sepal.Length,iris$Petal.Length),     # Aes
                       aes(colour =  factor(iris$Species)),          # Factor to color by
                       aes(label =  factor(iris$Species)),           # Add Labels To Points
                       'Sepal.Length',                               # X
                       'Petal.Length',                               # Y
                       'Sepal.Length Vs. Petal.Length',              # Title
                       'Species')                                    # Legend Name

ggplotZscoreRegression(mpg,                                          # DataFrame
                       aes(mpg$displ,mpg$hwy),                       # Aes
                       aes(colour =  factor(mpg$class)),             # Factor to color by
                       aes(label =  factor(mpg$class)),              # Add Labels To Points
                       'displ',                                      # X
                       'hwy',                                        # Y
                       'displ Vs. hwy',                              # Title
                       'class')                                      # Legend Name

ggplotZscoreRegression(ChickWeight,                                  # DataFrame
                       aes(ChickWeight$weight,ChickWeight$Time),     # Aes
                       aes(colour =  factor(ChickWeight$Diet)),      # Factor to color by
                       aes(label =  factor(ChickWeight$Diet)),       # Add Labels To Points
                       'weight',                                     # X
                       'Time',                                       # Y
                       'weight Vs. Time',                            # Title
                       'Diet')                                       # Legend Name
library(sqldf)
diamonds = sqldf("select * from diamonds order by random() limit 200")
ggplotZscoreRegression(diamonds,                                     # DataFrame
                       aes(diamonds$price,diamonds$carat),           # Aes
                       aes(colour =  factor(diamonds$cut)),          # Factor to color by
                       aes(label =  factor(diamonds$cut)),           # Add Labels To Points
                       'price',                                      # X
                       'carat',                                      # Y
                       'price Vs. carat',                            # Title
                       'cut')                                        # Legend Name






