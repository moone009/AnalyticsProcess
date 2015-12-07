library(forecast)
http://training-course-material.com/training/R_-_Forecasting

data <- structure(c(12, 20.5, 21, 15.5, 15.3, 23.5, 24.5, 21.3, 23.5,
                    28, 24, 15.5, 17.3, 25.3, 25, 36.5, 36.5, 29.6, 30.5, 28, 26,
                    21.5, 19.7, 19, 16, 20.7, 26.5, 30.6, 32.3, 29.5, 28.3, 31.3,
                    32.2, 26.4, 23.4, 16.4, 15, 16, 18, 27, 21, 49, 21, 22, 28, 36,
                    40, 3, 21, 29, 62, 65, 46, 44, 33, 62, 22, 12, 24, 3, 5, 14,
                    36, 40, 49, 7, 52, 65, 17, 5, 17, 1),
                  .Dim = c(36L, 2L), .Dimnames = list(NULL, c("Advertising", "Sales")),
                  .Tsp = c(2006, 2008.91666666667, 12), class = c("mts", "ts", "matrix"))
head(data)
nrow(data)
plot(data)

moving_average = forecast(ma(data[1:31], order=2), h=5)
moving_average_accuracy = accuracy(moving_average, data[32:36])
moving_average; moving_average_accuracy
plot(moving_average, ylim=c(0,60))
lines(data[1:36])


ma(data, order=5)

exp <- ses(data[1:31], 5, initial="simple")
exp_accuracy = accuracy(exp, data[32:36])
exp
exp_accuracy
plot(exp, ylim=c(0,60))
lines(data[1:36])



train = data[1:31]
test = data[32:36]
arma_fit <- auto.arima(train)
arma_forecast <- forecast(arma_fit, h = 5)
arma_fit_accuracy <- accuracy(arma_forecast, test)
arma_fit; arma_forecast; arma_fit_accuracy
plot(arma_forecast, ylim=c(0,60))
lines(data[1:36])

