#########################################################################################################
# Name             : Linear Regression
# Date             : 10-07-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20151007             initial
#########################################################################################################

import matplotlib.pyplot as plt
import numpy as np
from sklearn import datasets, linear_model
from sklearn.cross_validation import train_test_split
from sklearn.metrics import *
import pandas as pd

##
# Load the mtcars dataset
df = pd.read_csv('F:\\Analytics_Process\\Python\\SampleData\\mtcars.csv')
 
# Drop columns
cols = [0,5,6,7,8,9,10,11]
df = df.drop(df.columns[cols],axis=1)

Matrix = df.values
print(Matrix.shape)  

##
# Process data for model

# index of target
TargetIndex = df.columns.get_loc('mpg')
    
# Extract all features and target
li = list(range(0, (Matrix.shape[1])))
    
# Remove Target
li.remove(TargetIndex)
    
# print list of feature indexes
print('features: ' + str(li))
    
# Select our features (predictors)
MatrixFeatures = Matrix[:,li]
    
# Select our target
MatrixTarget = Matrix[:,TargetIndex]
    
# Split into test and train
train_features, test_features, train_Target, test_Target = train_test_split(MatrixFeatures, MatrixTarget, test_size=0.3)
    

##
# Create linear regression object
regr = linear_model.LinearRegression()

# Train the model using the training sets
regr.fit(train_features, train_Target)

# The coefficients
print('Coefficients: \n', regr.coef_)

# The mean square error
print("Residual sum of squares: %.2f"
      % np.mean((regr.predict(test_features) - test_Target) ** 2))
      
print("RMSE: %.2f",mean_squared_error(regr.predict(test_features), test_Target))
print("MAD: %.2f",mean_absolute_error(regr.predict(test_features), test_Target))
print("Explained Variance: %.2f",explained_variance_score(regr.predict(test_features), test_Target))
print("R2: %.2f",r2_score(regr.predict(test_features), test_Target))

# Explained variance score: 1 is perfect prediction
print('Variance score: %.2f' % regr.score(test_features, test_Target))

regr.intercept_
regr.coef_

pd.DataFrame([[regr.intercept_]])

pd.DataFrame([[regr.intercept_,regr.coef_]])




There exists no R type regression summary report in sklearn. The main reason is that sklearn is used for predictive modelling / machine learning and the evaluation criteria are based on performance on previously unseen data (such as predictive r^2 for regression).










