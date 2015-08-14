#########################################################################################################
# Name             : Zscore scatter plot
# Date             : 06-24-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Good way to look at data :)
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150624              initial
#########################################################################################################

# Load required libraries
library(ggplot2)
library(ggplot2)

##___________________________________________________________________________________________________________________________
BaseballData = read.csv('F:\\Analytics_Process\\R\\SampleData\\mlb-standings-and-payroll.csv',sep=',',header=T)

#which(colnames(BaseballData) == 'est_payroll')
BaseballData = subset(BaseballData,year == 2014,c(1,2,3,4,12,23))

BaseballData$PayRollZscore = (BaseballData$est_payroll - mean(BaseballData$est_payroll))/sd(BaseballData$est_payroll)
BaseballData$PayRollScaled = scale(BaseballData$est_payroll)

# standard Plot but kind of useless
p <- ggplot(BaseballData, aes(PayRollZscore, wins_losses))
p + geom_point(aes(colour = factor(tm)))
 
# Standard Plot with labels
p <- ggplot(BaseballData, aes(PayRollZscore, wins_losses, label=tm))
p + geom_point() +geom_text(aes(label=tm),hjust=0, vjust=0)

# Standard Plot with labels and color
p <- ggplot(BaseballData, aes(PayRollZscore, wins_losses))
p + geom_point(aes(colour = factor(tm)))+geom_text(aes(label=tm),hjust=0, vjust=0)

# Win Losses Final Plot
p <- ggplot(BaseballData, aes(PayRollZscore, wins_losses))
p + geom_point(aes(colour = factor(tm)))+ stat_smooth(method = "loess", formula = y ~ x, size = .5)    +
geom_text(aes(label=tm),hjust=0, vjust=0) + guides(color=guide_legend(title="Team"))+ ggtitle("2014 Revenue Vs. Standardized Salary\n Low Positive Correlation: .??")

##___________________________________________________________________________________________________________________________
NBA = read.csv('F:\\Analytics_Process\\R\\SampleData\\NBA.csv',sep=',',header=T)

NBA$PayRollZscore = (NBA$Salary - mean(NBA$Salary))/sd(NBA$Salary)
NBA$PayRollScaled = scale(NBA$Salary)

# standard Plot but kind of useless
p <- ggplot(NBA, aes(PayRollZscore, Percent))
p + geom_point(aes(colour = factor(Team)))

# Standard Plot with labels
p <- ggplot(NBA, aes(PayRollZscore, Percent, label=Team))
p + geom_point() +geom_text(aes(label=Team),hjust=0, vjust=0)

# Standard Plot with labels and color
p <- ggplot(NBA, aes(PayRollZscore, Percent))
p + geom_point(aes(colour = factor(Team)))+geom_text(aes(label=Team),hjust=0, vjust=0) + ggtitle("2014 Wins Vs. Standardized Salary\n Low Positive Correlation: .30")

# Winning Percent
p <- ggplot(NBA, aes(PayRollZscore, Percent))
p + geom_point(aes(colour = factor(Team)))+ stat_smooth(method = "loess", formula = y ~ x, size = .5)    +
geom_text(aes(label=Team),hjust=0, vjust=0) + guides(color=guide_legend(title="Team"))+ ggtitle("2014 Wins Vs. Standardized Salary\n Low Positive Correlation: .30")
   
# Revenue Income
p <- ggplot(NBA, aes(PayRollZscore, Rev))
p + geom_point(aes(colour = factor(Team)))+ stat_smooth(method = "loess", formula = y ~ x, size = .5)    +
  geom_text(aes(label=Team),hjust=0, vjust=0) + guides(color=guide_legend(title="Team"))+ ggtitle("2014 Revenue Vs. Standardized Salary\n Low Positive Correlation: .42")

# Operating Income
p <- ggplot(NBA, aes(PayRollZscore, OperatingIncome))
p + geom_point(aes(colour = factor(Team)))+ stat_smooth(method = "loess", formula = y ~ x, size = .5)    +
  geom_text(aes(label=Team),hjust=0, vjust=0) + guides(color=guide_legend(title="Team"))+ ggtitle("2014 Revenue Vs. Standardized Salary\n Low Positive Correlation: .42")





