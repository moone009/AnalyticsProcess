
library(forecast)
library(readxl)

##________________________________________________________________________________________________________________________________
# Load Data
linearTrend <- read_excel('F:\\Analytics_Process\\R\\SampleData\\Forecasting.xlsx', sheet='Sheet1', na = "NA")
MovingAverage <- read_excel('F:\\Analytics_Process\\R\\SampleData\\Forecasting.xlsx', sheet='Sheet1', na = "NA")
WeightedMovingAverage <- read_excel('F:\\Analytics_Process\\R\\SampleData\\Forecasting.xlsx', sheet='Sheet1', na = "NA")
SmoothingForecast <- read_excel('F:\\Analytics_Process\\R\\SampleData\\Forecasting.xlsx', sheet='Sheet1', na = "NA")

##________________________________________________________________________________________________________________________________
# Expoential Smoothing Forecast
SmoothingForecast$RecodedTime <- 1:nrow(MovingAverage)
SmoothingForecast <- SmoothingForecast[,c('RecodedTime','MonthSales','Data')]

alpha <- .2
SmoothingForecast$Forecast <- ''
SmoothingForecast$Forecast[2] <- SmoothingForecast$Data[1]
SmoothingForecast$Forecast = as.numeric(SmoothingForecast$Forecast)
SmoothingForecast$Data = as.numeric(SmoothingForecast$Data)

for(i in 2:nrow(SmoothingForecast)){
  SmoothingForecast$Forecast[i+1] <- (1-alpha)*SmoothingForecast$Data[i] + (alpha * SmoothingForecast$Forecast[i])
  
  if((i+1)>= nrow(SmoothingForecast)){
    futureValue <- data.frame(RecodedTime = 8,MonthSales='Sep',Data = '',Forecast = (1-alpha)*SmoothingForecast$Data[i+1] + (alpha * SmoothingForecast$Forecast[i+1]))
    break
  }
}

SmoothingForecast <- rbind(SmoothingForecast,futureValue)

##________________________________________________________________________________________________________________________________
# Moving Average Forecast
MovingAverage$RecodedTime <- 1:nrow(MovingAverage)
MovingAverage <- MovingAverage[,c('RecodedTime','MonthSales','Data')]

# Example five month moving average
futureValue <- data.frame(RecodedTime = 8,MonthSales='Sep',Data = sum(MovingAverage[3:7,][3])/5)


##________________________________________________________________________________________________________________________________
# Weighted Moving Average Forecast
WeightedMovingAverage$RecodedTime <- 1:nrow(WeightedMovingAverage)
WeightedMovingAverage <- WeightedMovingAverage[,c('RecodedTime','MonthSales','Data')]
Weights = c(.1,.2,.2,.2,.3)

# Example weighted five month moving average
futureValue <- data.frame(RecodedTime = 8,MonthSales='Sep',Data = sum(MovingAverage[3:7,][3]*Weights))

##________________________________________________________________________________________________________________________________
# Linear Trend Forecast
linearTrend$RecodedTime <- 1:nrow(linearTrend)
linearTrend <- linearTrend[,c('RecodedTime','MonthSales','Data')]

slope <- ((nrow(linearTrend)*sum(linearTrend$RecodedTime*linearTrend$Data))-(sum(linearTrend$RecodedTime)*sum(linearTrend$Data)))/
         ((nrow(linearTrend)*sum(linearTrend$RecodedTime^2))-sum(linearTrend$RecodedTime)^2)
slope
Intercept <- (sum(linearTrend$Data)-slope*(sum(linearTrend$RecodedTime)))/nrow(linearTrend)

futureValue <- data.frame(RecodedTime = 8,MonthSales='Sep',Data = Intercept+(slope*8))

##________________________________________________________________________________________________________________________________
# Arima Forecast
http://scm.ncsu.edu/scm-articles/article/exponential-smoothing-approaches-to-forecasting-a-tutorial











