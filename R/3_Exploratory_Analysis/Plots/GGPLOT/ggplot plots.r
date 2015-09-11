#########################################################################################################
# Name             : ggplot plots
# Date             : 09-01-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Additional examples of ggplot
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150901             initial
#########################################################################################################



library(MASS) # For the data set

##_____________________________________________________________________________________________________________________________
# faceting variable
ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(smoke ~ .)

ggplot(birthwt, aes(x=bwt)) + geom_histogram(fill="white", colour="black") +
  facet_grid(ftv ~ .)


##_____________________________________________________________________________________________________________________________
# overlayed density plot

# Convert smoke to a factor
birthwt$smoke <- factor(birthwt$smoke)

# Map smoke to fill, make the bars NOT stacked, and make them semitransparent
ggplot(birthwt, aes(x=bwt, fill=smoke)) +
  geom_histogram(position="identity", alpha=0.4)


##_____________________________________________________________________________________________________________________________
# overlayed density plot
b <- biopsy

b$classn[b$class=="benign"]    <- 0
b$classn[b$class=="malignant"] <- 1

# Here we can if V1 >5 there is a strong probability of having a malignant tumor
ggplot(b, aes(x=V1, y=classn)) +
geom_point(position=position_jitter(width=0.3, height=0.06), alpha=0.4,
shape=21, size=1.5) + stat_smooth(method=glm, family=binomial)


##_____________________________________________________________________________________________________________________________
# 2d density plot
p <- ggplot(faithful, aes(x=eruptions, y=waiting))
p + geom_point() + stat_density2d()

p + geom_point() +
  stat_density2d(aes(alpha=..density..), geom="tile", contour=FALSE)


##_____________________________________________________________________________________________________________________________
# Boxplots
# Using methods from Chapter 5
ggplot(mtcars, aes(x=wt, y=mpg,colour=as.factor(am)))  + geom_point(size=5.5,shape=20)  + stat_smooth(method=loess)

ggplot(mtcars, aes(x=wt, y=mpg, fill=disp)) +
  geom_point(shape=21, size=2.5) +
  scale_fill_gradient(low="blue", high="red")+ stat_smooth(method=loess)

ggplot(mtcars, aes(x=wt, y=mpg, fill=disp)) +
  geom_point(shape=21, size=2.5) +
  scale_fill_gradient(low="blue", high="red", breaks=seq(70, 460, by=30),
                      guide=guide_legend())


ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()

df = cbind(state.x77,as.data.frame(state.division))
ggplot(aes(y = Income, x = state.division,color =state.division ), data = df) + 
  geom_boxplot()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("State Division by Income")


##_____________________________________________________________________________________________________________________________
# Correlation Plot Matrix
carsize <- cut(mtcars[,"wt"], breaks=c(0, 2.5, 3.5, 5.5), labels=c("Compact", "Midsize", "Large"))
mtcars <-cbind(mtcars,carsize)
mtcars <- mtcars[,c(1,3,4,5,7,12)]

require(ggpairs)
ggpairs(data=mtcars, diag=list(continuous="density"), columns=1:5, colour="carsize",axisLabels="show")
rm(mtcars)


##_____________________________________________________________________________________________________________________________
# Line plot
ggplot(BOD, aes(x=Time, y=demand)) + geom_line()

BOD1 <- BOD # Make a copy of the data
BOD1$Time <- factor(BOD1$Time)
ggplot(BOD1, aes(x=Time, y=demand, group=1)) + geom_line()


ggplot(BOD, aes(x=Time, y=demand)) +
  geom_line() +
  geom_point(size=4, shape=22, colour="darkred", fill="pink")

sunspotyear <- data.frame(
  Year     = as.numeric(time(sunspot.year)),
  Sunspots = as.numeric(sunspot.year)
)

ggplot(sunspotyear, aes(x=Year, y=Sunspots)) + geom_area()


ggplot(sunspotyear, aes(x=Year, y=Sunspots)) +
  geom_area(colour="black", fill="blue", alpha=.2)


##_____________________________________________________________________________________________________________________________
# Line plot
df = read.csv('F:\\Analytics_Process\\R\\SampleData\\SampleTimeSeriesData.csv',sep=",",header=T)

df$Date = as.Date(df$Date, "%m/%d/%Y")
df <- melt(df, id=c("Date"))

ggplot(data = df) +
  geom_line(aes(x = Date,y =  value, colour = variable))  + 
  ylab("Value (Cons = KwH ,My_Estimate = KwH, Weather = F)") +
  xlab("Date") +
  ggtitle("Usage Overview")

p=ggplot(data = df) +
  aes(x = Date,y =  value, colour = variable)+
  geom_line( size = 1.5)  + 
  ylab("Value (Cons = KwH ,My_Estimate = KwH, Weather = F)") +
  xlab("Date") + 
  ggtitle("Usage Overview")
p + theme(
  legend.position = c(.9785, .95), # c(0,0) bottom left, c(1,1) top-right.
  legend.background = element_rect(fill = "white", colour = NA)
)










