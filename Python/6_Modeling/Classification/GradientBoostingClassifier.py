#########################################################################################################
# Name             : GradientBoostingClassifier
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

from sklearn.cross_validation import train_test_split
from sklearn.metrics import classification_report
from sklearn.ensemble import GradientBoostingClassifier
import sklearn
import numpy as np
import pandas as pd

##
df = pandas.read_csv('F:\\Analytics_Process\\Python\\SampleData\\iris.csv')
print(df.head(10))

Matrix = df.values
print(Matrix.shape)   
 
CrossTab ,Rpt = GBM(df,'Species',100) 
print(Rpt)
print(CrossTab)

##
def GBM(df,Target,estimators):
    
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
    a_train, a_test, b_train, b_test = train_test_split(MatrixFeatures, MatrixTarget, test_size=0.75)
    
    # Set out model
    clf = GradientBoostingClassifier(n_estimators=estimators, learning_rate=.01,max_depth=6, random_state=0)
    
    # train and predict
    clf.fit(a_train,np.ravel(b_train))
    Z = clf.predict(a_test)
    
    df = pd.DataFrame(Z) 
    df =df.reset_index()
    df1 = pd.DataFrame(b_test) 
    df1 =df1.reset_index()
    merged = df.merge(df1,on='index') 
    
    merged.rename(columns={'0_x':'Pred'}, inplace=True)
    merged.rename(columns={'0_y':'Actual'}, inplace=True)
    
    return(pd.crosstab(merged.Pred, merged.Actual),classification_report(np.array(b_test.tolist()), np.array(Z.tolist())))

