#########################################################################################################
# Name             : Example of GGplot 
# Date             : 07-14-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Shows the user how to work with ggplot
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150702              initial
#########################################################################################################


##__________________________________________________________________________________________________________________________________________
# Load libraries
library(ggplot2)
library(reshape)

##__________________________________________________________________________________________________________________________________________
# Sample Data
TimeSeries = structure(list(Dt = structure(c(32L, 43L, 54L, 56L, 57L, 58L, 59L, 60L, 61L, 33L, 34L, 35L, 36L, 37L, 38L, 39L, 40L, 41L, 42L, 44L, 45L, 46L, 47L, 48L, 49L, 50L, 51L, 52L, 53L, 55L, 62L, 73L, 84L, 87L, 88L, 89L, 90L, 91L, 92L, 63L, 64L, 65L, 66L, 67L, 68L, 69L, 70L, 71L, 72L, 74L, 75L, 76L, 77L, 78L, 79L, 80L, 81L, 82L, 83L, 85L, 86L, 1L, 12L, 23L, 26L, 27L, 28L, 29L, 30L, 31L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L, 11L, 13L, 14L, 15L, 16L, 17L, 18L, 19L, 20L, 21L, 22L, 24L, 25L, 93L, 94L, 95L, 96L, 97L, 98L, 
                                             99L), .Label = c("1/1/2015", "1/10/2015", "1/11/2015", "1/12/2015", "1/13/2015", "1/14/2015", "1/15/2015", "1/16/2015", "1/17/2015", "1/18/2015", "1/19/2015", "1/2/2015", "1/20/2015", "1/21/2015", "1/22/2015", "1/23/2015", "1/24/2015", "1/25/2015", "1/26/2015",  "1/27/2015", "1/28/2015", "1/29/2015", "1/3/2015", "1/30/2015",  "1/31/2015", "1/4/2015", "1/5/2015", "1/6/2015", "1/7/2015",  "1/8/2015", "1/9/2015", "11/1/2014", "11/10/2014", "11/11/2014",  "11/12/2014", "11/13/2014", "11/14/2014", "11/15/2014", "11/16/2014",  "11/17/2014", "11/18/2014", "11/19/2014", "11/2/2014", "11/20/2014",  "11/21/2014", "11/22/2014", "11/23/2014", "11/24/2014", "11/25/2014", "11/26/2014", "11/27/2014", "11/28/2014", "11/29/2014", "11/3/2014", "11/30/2014", "11/4/2014", "11/5/2014", "11/6/2014", "11/7/2014", 
                                                              "11/8/2014", "11/9/2014", "12/1/2014", "12/10/2014", "12/11/2014",  "12/12/2014", "12/13/2014", "12/14/2014", "12/15/2014", "12/16/2014",  "12/17/2014", "12/18/2014", "12/19/2014", "12/2/2014", "12/20/2014",  "12/21/2014", "12/22/2014", "12/23/2014", "12/24/2014", "12/25/2014", "12/26/2014", "12/27/2014", "12/28/2014", "12/29/2014", "12/3/2014", "12/30/2014", "12/31/2014", "12/4/2014", "12/5/2014", "12/6/2014", "12/7/2014", "12/8/2014", "12/9/2014", "2/1/2015", "2/2/2015", "2/3/2015", "2/4/2015", "2/5/2015", "2/6/2015", "2/7/2015"), class = "factor"), 
                            Cons.Value = c(15.25, 12, 10.15, 9.93, 8.25, 16.67, 11.07, 10.1, 11.82, 13.07, 9.9, 12.86, 10.45, 15.68, 12.54, 8.56, 9.17, 21.76, 11.89, 13.68, 14.91, 10.4, 12.02, 9.95, 9.6, 40.65, 40.15, 15.2, 23.63, 15.07, 27.96, 3.96, 4.76, 4.79, 3.32, 4.17, 7.26, 6.62, 3.6, 3.95, 4.8, 4.07, 3.34, 12.12, 15.9, 11.97, 12.24, 12.33, 16.5, 12.08, 14.76, 24.86, 11.89, 11.93, 12.09, 15.72, 12.25, 12.23, 14.71, 13.98, 18.31, 18.91, 17.15, 12.27, 18.71, 13.3, 12.88, 13.62, 21.45, 13.41, 21.29, 14.85, 15.78, 13.03, 13.47, 12.7, 12.68, 15.41, 13.5, 19.71, 19.4, 17.44, 12.47, 12.47, 19.54, 19.3, 13.85, 17.72, 20.44, 12.65, 12.69, 12.99, 12.95, 13.1, 12.66, 12.98, 13.26, 12.62, 13.34), Weather.Value = c(35L, 40L, 52L, 52L, 45L, 45L, 38L, 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              42L, 43L, 49L, 43L, 27L, 26L, 22L, 23L, 24L, 13L, 14L, 23L,19L, 22L, 42L, 49L, 35L, 22L, 20L, 18L, 24L, 41L, 35L, 19L,      31L, 30L, 28L, 34L, 34L, 35L, 35L, 33L, 29L, 27L, 30L, 39L,47L, 44L, 37L, 25L, 23L, 30L, 30L, 35L, 37L, 42L, 38L, 38L,43L, 40L, 28L, 22L, 12L, 11L, 22L, 26L, 32L, 16L, -2L, 3L,    0L, 4L, 4L, 10L, 24L, 18L, 14L, 10L, 27L, 30L, 38L, 39L, 32L, 33L, 30L, 30L, 30L, 36L, 29L, 23L, 27L, 26L, 31L, 23L,     27L, 23L, 11L, 11L, 13L, 7L, 21L, 27L)), .Names = c("Dt", 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           "Cons.Value", "Weather.Value"), class = "data.frame", row.names = c(NA,  -99L))

##__________________________________________________________________________________________________________________________________________
# Line Chart 
TimeSeries$My_Estimate = 9.5

TimeSeries$Dt = as.Date(TimeSeries$Dt, "%m/%d/%Y")
TimeSeries <- melt(TimeSeries, id=c("Dt"))

ggplot(data = TimeSeries) +
  geom_line(aes(x = Dt,y =  value, colour = variable))  + 
  ylab("Value (Cons = KwH ,My_Estimate = KwH, Weather = F)") +
  xlab("Date") +
  ggtitle("Usage Overview")

p=ggplot(data = TimeSeries) +
  aes(x = Dt,y =  value, colour = variable)+
  geom_line( size = 1.5)  + 
  ylab("Value (Cons = KwH ,My_Estimate = KwH, Weather = F)") +
  xlab("Date") + 
  ggtitle("Usage Overview")
p + theme(
  legend.position = c(.97, .95), # c(0,0) bottom left, c(1,1) top-right.
  legend.background = element_rect(fill = "white", colour = NA)
)
#-----------------------------------------
df.dummy_data <- data.frame(
  dummy_metric <- cumsum(1:20),
  date = seq.Date(as.Date("1980-01-01"), by="1 year", length.out=20)
)

# Plot the data using ggplot2 package
ggplot(data=df.dummy_data, aes(x=date,y=dummy_metric)) +
  geom_line()

##__________________________________________________________________________________________________________________________________________
# Multiple Line Chart 

df.facet_data <- read.csv(url("http://www.sharpsightlabs.com/wp-content/uploads/2014/12/facet_dummy_data.csv"))
df.facet_data$month <- factor(df.facet_data$month, levels=month.abb)

ggplot(data=df.facet_data, aes(x=df.facet_data$month,y=sales, group=region)) +
  geom_line()

ggplot(data=df.facet_data, aes(x=month,y=sales, group=region)) +
  geom_line() +
  facet_grid(region ~ .)

ggplot(data=df.facet_data, aes(x=region,y=sales)) +
  geom_bar(stat="identity") +
  facet_wrap(~month) +
  ggtitle("Small Multiples in R") +
  theme(plot.title = element_text(family="Trebuchet MS", face="bold", size=20, hjust=0, color="#555555")) +
  theme(axis.text.x = element_text(angle=90)) 

##__________________________________________________________________________________________________________________________________________
# Scatterplot 
# Create dummy dataset
df.test_data <- data.frame(x_var = 1:50 + rnorm(50,sd=15),
                           y_var = 1:50 + rnorm(50,sd=2)                          
)

# Plot data using ggplot2
ggplot(data=df.test_data, aes(x=x_var, y=y_var)) +
  geom_point(aes(colour = x_var))

p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(aes(colour = qsec))

p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point(aes(alpha = qsec))

p <- ggplot(mtcars, aes(wt, mpg))
p <- p + geom_point(aes(colour = factor(cyl)))
p +guides(color=guide_legend(title='Cylinders'))+ xlab('Weight') + ylab('Miles Per Gallon') + ggtitle('Weight Compared to MPG\nDate 2015-01-01')

##__________________________________________________________________________________________________________________________________________
# BubbleChart 
x_var <- rnorm( n = 15, mean = 5, sd = 2)
y_var <- x_var + rnorm(n = 15, mean = 5, sd =4)
size_var <- runif(15, 1,10)

df.test_data <- data.frame(x_var, y_var, size_var)

# PLOT THE DATA USING GGPLOT2
ggplot(data=df.test_data, aes(x=x_var, y=y_var)) +
  geom_point(aes(size=size_var)) +
  scale_size_continuous(range=c(2,15)) +
  theme(legend.position = "none")

p <- ggplot(mtcars, aes(wt, mpg))
p <- p + geom_point(aes(size=mpg)) 
p +guides(color=guide_legend(title='Cylinders'))+ xlab('Weight') + ylab('Miles Per Gallon') + ggtitle('Weight Compared to MPG\nDate 2015-01-01')


##__________________________________________________________________________________________________________________________________________
# Regression Line 
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="lm", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")

qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="loess", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")


##__________________________________________________________________________________________________________________________________________
# Boxplot 
# A boxplot splits the data set into quartiles. The body of the boxplot consists of a "box" (hence, the name),
# which goes from the first quartile (Q1) to the third quartile (Q3).

# Within the box, a horizotal line is drawn at the Q2, the median of the data set. Two vertical lines, called whiskers,
# extend from the front and back of the box. The bottom whisker goes from Q1 to the smallest non-outlier in the data set, 
# and the top whisker goes from Q3 to the largest non-outlier.

# Boxplot will tell you the followingL Skewness and outliers. 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 

qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

library(grid) 
rm(mtcars)
mtcars =subset(mtcars, gear == '3',)             
p <- qplot(gear, mpg, data=mtcars, geom=c("boxplot"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")  
p <- p + annotate("text", x = 2.8, y = 20, label = "Whisker")
p <- p +  geom_segment(aes(x = 2.9, y = 20, xend = 3, yend = 20), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 2.8, y = 21.5, label = "Max")
p <- p +  geom_segment(aes(x = 2.9, y = 21.5, xend = 3, yend = 21.5), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 2.8, y = 10.5, label = "Min")
p <- p +  geom_segment(aes(x = 2.9, y = 10.5, xend = 3, yend = 10.5), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 2.8, y = 12.5, label = "Whisker")
p <- p +  geom_segment(aes(x = 2.9, y = 12.5, xend = 3, yend = 12.5), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 3.3, y = 13, label = "Q1")
p <- p +  geom_segment(aes(x = 3.3, y = 13, xend = 3.3, yend = 14.6), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 3.15, y = 13, label = "Median")
p <- p +  geom_segment(aes(x = 3.15, y = 13, xend = 3.15, yend = 15.5), arrow = arrow(length = unit(0.5, "cm")))

p <- p + annotate("text", x = 3.3, y = 19.6, label = "Q3")
p <- p +  geom_segment(aes(x = 3.3, y = 19.5, xend = 3.3, yend = 18.4), arrow = arrow(length = unit(0.5, "cm")))



df.test_data <- data.frame(x_var = 1:75 + rnorm(75,sd=85),
                           y_var = runif(75, min=1, max=9),
                           type = rep(letters[1:3],25)
)

qplot(type,x_var, data=df.test_data, geom=c("boxplot", "jitter"), 
      fill=type, main="Boxplot of Var",
      xlab="", ylab="Count")

qplot(type,y_var, data=df.test_data, geom=c("boxplot", "jitter"), 
      fill=type, main="Boxplot of Var",
      xlab="", ylab="Count")


##__________________________________________________________________________________________________________________________________________
# Densisty Plot 
qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")


##__________________________________________________________________________________________________________________________________________
# Bar Plot 
c <- ggplot(mtcars, aes(factor(cyl)))
# By default, uses stat="bin", which gives the count in each category
c + geom_bar()


c <- qplot(factor(cyl), data=mtcars, geom="bar", fill=gear)
# By default, uses stat="bin", which gives the count in each category
c + geom_bar()
c + geom_bar(width=.5) + xlab("Cylinders") +labs('custom title')






