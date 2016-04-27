
mtcars$hp2 = mtcars$hp^2
fit <- lm(mpg~hp+hp2 ,mtcars)
summary(fit)
point <- head(mtcars,1)
predict(fit,point)

fit <- lm(mpg~poly(hp,9) ,mtcars)
summary(fit)
point <- head(mtcars,1)
predict(fit,point)

library(ggplot2)
fit <- lm(mpg~poly(hp,6)+poly(disp,6)+wt,mtcars)

p <- ggplot(mtcars, aes(mpg, hp)) 
p <- p + geom_point(alpha=2/10, shape=21, fill="blue", colour="black", size=5)
p + stat_smooth(method="lm", se=TRUE, fill=NA,formula=y ~ poly(x, 3, raw=TRUE),colour="red")


library(ggplot2)
fit <- lm(mpg~poly(hp,3)+qsec+wt,mtcars)
fit <- lm(mpg~poly(hp,3)+poly(qsec,8)+wt,mtcars)

p <- ggplot(mtcars, aes(mpg, qsec)) 
p <- p + geom_point(alpha=2/10, shape=21, fill="blue", colour="black", size=5)
p + stat_smooth(method="lm", se=TRUE, fill=NA,formula=y ~ poly(x, 6, raw=TRUE),colour="red")
