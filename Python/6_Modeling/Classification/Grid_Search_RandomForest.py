#########################################################################################################
# Name             : Grid_Search_RF
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

from sklearn.cross_validation import train_test_split
from sklearn.metrics import classification_report
from sklearn.ensemble import (RandomForestClassifier, ExtraTreesClassifier,AdaBoostClassifier)
from sklearn.grid_search import GridSearchCV, RandomizedSearchCV
import sklearn
import numpy as np
import pandas as pd

##
# KDD Cup Example
df = pd.read_csv('F:\\kddcup98-1.csv')
Matrix = df.values
print(Matrix.shape)   
Grid_Search_RF(df,'TARGET_B') 

# Iris Example
df = pd.read_csv('F:\\Analytics_Process\\Python\\SampleData\\Iris.csv')
Matrix = df.values
print(Matrix.shape)   
ModelFit = Grid_Search_RF(df,'Species') 

##
def Grid_Search_RF(df,Target):
    
    # transform into matrix
    Matrix = df.values
    
    # index of target
    TargetIndex = df.columns.get_loc(Target)
    
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
    train_features, test_features, train_Target, test_Target = train_test_split(MatrixFeatures, MatrixTarget, test_size=0.75)
    
    param_grid = {"max_depth": [1,3,6,9,12, None],
                  "max_features": [1,np.shape(train_features)[1]],
                  "min_samples_split": [1, 3, 5, 10],
                  "min_samples_leaf": [1, 3, 5, 10],
                  "n_estimators": [200,500,900],
                  "bootstrap": [True, False],
                  "criterion": ["gini", "entropy"]}
                    
    model = RandomForestClassifier()
    
    rsearch = GridSearchCV(estimator=model, param_grid=param_grid,n_jobs=6,verbose=1)
    rsearch.fit(train_features, np.unique(np.ravel(train_Target), return_inverse=True)[1])

    print(rsearch.best_params_)
    return(rsearch)



