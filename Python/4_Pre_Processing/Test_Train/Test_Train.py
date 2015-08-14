#########################################################################################################
# Name             : Test and Train
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

import pandas as pd
from sklearn.cross_validation import train_test_split

df = pandas.read_csv('F:\\Analytics_Process\\R\\SampleData\\iris_missing_Values.csv')
print(df.head(10))

Matrix = df.values
print(Matrix.shape)   
 
# Select our features (predictors)

# if our target is the last vector we can use this simpler method
MatrixFeatures = Matrix[:,:-1]

# if our target is not the we specify the features
MatrixFeatures = Matrix[:,[0,1,2,3]]


# Select our target is the last last vector we can simply say only return last vector
MatrixTarget = Matrix[:,[-1]]

# if our target is not the we specify the index
MatrixTarget = Matrix[:,[4]]

# Now we can split our data into test and train
TrainFeatures, TestFeatures, TrainTargets, TestTargets = train_test_split(MatrixFeatures, MatrixTarget, test_size=0.4)
    
# Training Sets
print(TrainFeatures.shape)   
print(TrainTargets.shape)   

# Testing Sets
print(TestFeatures.shape)   
print(TestTargets.shape)   

