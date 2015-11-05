#########################################################################################################
# Name             : Kmeans
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans
from sklearn import datasets


##
df = pd.read_csv('F:\\Analytics_Process\\Python\\SampleData\\iris.csv')
print(df.head(10))

Matrix = df.values
print(Matrix.shape)  

# Excute Kmeans func
Clusters,Model = Kmeans(df,'Species',3)
# After Analysis predict and return segments
MatrixFeatures = Matrix[:,[0,1,2,3]]
Predictions = Model.predict(MatrixFeatures)

# Bind Data
Pred_df = pd.DataFrame(Predictions)

df.reset_index(level=0, inplace=True)
Pred_df.reset_index(level=0, inplace=True)

result = pd.merge(df, Pred_df, on='index')
result = result.rename(columns={0: 'Kmeans'})

# Summarize Data
Data = result.groupby(['Species','Kmeans']).size().reset_index()
Data.columns = ['Species','Kmeans','Total']
Data = pd.DataFrame(Data)
Data = Data.sort(['Kmeans'], ascending=[False])
Data = Data.head(10)


# Plot Data
Dataplt = pd.crosstab(result.Species, result.Kmeans)
Dataplt.plot(kind='barh',alpha=0.5, stacked=True)


##
def Kmeans(df,Target,Clusters):
    
    Clusters = Clusters+ 1
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

    li = []
    cl = []
    for i in range(1,Clusters):
        k_means = KMeans(n_clusters=i)
        k_means.fit(MatrixFeatures) 
        print(k_means.inertia_)
        li.append(k_means.inertia_)
        cl.append('cluster:'+str(i))

    print('Note: distance based models expect data to be standardized otherwise large values will dominate distance based calculations')

    print('To return actual clusters execute: Clusters = k_means.predict(MatrixFeatures)')

    df = pd.DataFrame(li)
    df.columns = ['Sum of Squares']
    cl = pd.DataFrame(cl)
    cl.columns = ['Clusters']
    
    cl.reset_index(inplace=True)
    df.reset_index(inplace=True)

    data = pd.merge(cl, df, on='index')
    data = data.drop('index', 1)
    data.plot('Clusters','Sum of Squares',legend = None)
    plt.legend(data[[1]], loc='best') 
    plt.xticks(rotation=55)
    return(data,k_means)



standardized_X = good_columns.apply(lambda x: (x - np.min(x)) / (np.max(x) - np.min(x)))
data,km = Kmeans(standardized_X,'season_end',9)

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 