#########################################################################################################
# Name             : Data Imputation Example
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

import sys
sys.path.append("F:\\Analytics_Process\\Python\\4_Pre_Processing\\Data_Imputation\\")
import pandas
import DataImputation

df = pandas.read_csv('F:\\Analytics_Process\\R\\SampleData\\iris_missing_Values.csv')
print(df.head(10))
df = DataImputation.ValueImputationMedian(df,'Sepal.Length')
df = DataImputation.ValueImputationAverage(df,'Sepal.Width')
print(df.head(10))
