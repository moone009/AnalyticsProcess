
df = read.csv('F:/mtcars1.csv')
dft = read.csv('F:/mtcars2.csv')


model = lm(mpg~disp+hp+hp*disp+wt,mtcars)
summary(model)
regression_metrics(model,mtcars,mtcars$mpg,length(model$coefficients)-1)

regression_metrics <- function(model,df,trained_Y,Number_of_predictors){
  
  RMSE = function(predictions, actual){
    sqrt(mean((predictions - actual)^2))
  }
  mae <- function(predictions,actual){
    error <- predictions - actual
    mean(abs(error))
  }
  mse <- function(residuals) { 
    mse <- mean(residuals^2)
    return(mse)
  }
  r2 <- function(predictions,trained_Y) { 
    SSR  <- sum((predictions - mean(trained_Y))^2)
    SST  <- sum((trained_Y - mean(trained_Y))^2)
    R2  <- SSR/SST
    return(R2)
  }
  Residualstandarderror <-function(model,trained_Y,predictors){
    
    #anova(model)
    SumSq <- sum((fitted(model)-trained_Y)^2)
    return(sqrt(SumSq/(length(trained_Y)-(predictors+1))))
  }
  fStat <- function(predictions,actual,predictors){
    
    TSS <- sum((actual -mean(actual))^2)
    RSS <- sum((actual-predictions)^2)
    FSTAT <- ((TSS-RSS)/predictors)/(RSS/(length(actual)-predictors-1))
    return(FSTAT)
  }
  adjustedr2 <- function(predictions,actual,predictors){
    n <- length(actual)
    rsqared <- r2(predictions,actual)
    return(1-(1-rsqared) * ((n-1)/(n-predictors-1)))
    
  }
  
  
  # calcuate predictions
  predictions <- predict(model,df)
  
  # functions
  res_error <- Residualstandarderror(model,trained_Y,Number_of_predictors)
  root_mean_square_error <- RMSE(fitted(model),trained_Y)
  mean_absolute_error <- mae(fitted(model),trained_Y)
  mean_square_error <- mse(resid(model))
  rsquared <- r2(predictions,trained_Y)
  fstatistic <- fStat(predictions,trained_Y,Number_of_predictors)
  n_rows <- nrow(df)
  degreesFreedom <- nrow(df) - Number_of_predictors
  adjustedr2 <- adjustedr2(predictions,trained_Y,Number_of_predictors)
  
  results <- data.frame(
             n_rows,
             degreesFreedom,
             fstatistic,
             res_error,
             root_mean_square_error,
             mean_absolute_error,
             mean_square_error,
             rsquared,
             adjustedr2)
  
  results = as.data.frame(t(results))
  results$Metric <- rownames(results)
  rownames(results) <- NULL
  colnames(results) <- c('Value','Metric')
  results <- results[,c(2,1)]
  results$Value = round(results$Value,3)
  
  return(results)
  
}





