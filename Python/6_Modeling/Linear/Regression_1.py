#########################################################################################################
# Name             : Kmeans
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

import numpy as np
import random
import pandas as pd
from sklearn.linear_model import LinearRegression


sp500 = pd.read_csv('F:\\table.csv')
sp500 = sp500[['Date','Close']]

next_day = sp500["Close"].iloc[1:]
sp500 = sp500.iloc[:-1,:]
sp500["next_day"] = next_day.values

sp500["Close"] = sp500["Close"].astype(float)
sp500["next_day"] = sp500["next_day"].astype(float)

# Set a random seed to make the shuffle deterministic.
np.random.seed(1)
random.seed(1)

# Randomly shuffle the rows in our dataframe
sp500 = sp500.loc[np.random.permutation(sp500.index)]

# Select 70% of the dataset to be training data
highest_train_row = int(sp500.shape[0] * .7)
train = sp500.loc[:highest_train_row,:]

# Select 30% of the dataset to be test data.
test = sp500.loc[highest_train_row:,:]

regressor = LinearRegression()
regressor.fit(train[["Close"]], train["next_day"])
predictions = regressor.predict(test[["Close"]])

mse = sum((predictions - test["next_day"]) ** 2) / len(predictions)
print(mse)
mse = sum((predictions - test["next_day"]) ** 2) * (1/len(predictions))
print(mse)

import matplotlib.pyplot as plt
# Make a scatterplot with the actual values in the training set
plt.scatter(train["Close"], train["next_day"])
plt.plot(train["Close"], regressor.predict(train[["Close"]]))
plt.show()


import matplotlib.pyplot as plt
# Make a scatterplot with the actual values in the training set
plt.scatter(train["Close"], train["next_day"])
plt.plot(train["Close"], regressor.predict(train[["value"]]))
plt.show()
plt.scatter(test["Close"], test["next_day"])
plt.plot(test["Close"], predictions)
plt.show()


# The test set predictions are in the predictions variable.
import math
rmse = math.sqrt(sum((predictions - test["next_day"]) ** 2) / len(predictions))
mae = sum(abs(predictions - test["next_day"])) / len(predictions)

