#########################################################################################################
# Name             : Remove characters and numbers from pandas
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################
import re
import numpy as np
import pandas as pd

##
df = pd.read_csv('F:\\Analytics_Process\\Python\\SampleData\\CallCenter.csv')
print(df.head(5))
print(len(df))

# Create lambda functions
RemoveText =  lambda x:  re.sub("\D", "", x )
RemoveNumbers =  lambda x:  re.sub("\d+", "", x )

# Examples
text = 'NXZ10123'
print(RemoveNumbers(text))
print(RemoveText(text))

df['CustomerID'] = df.apply(lambda row: RemoveNumbers(row['CustomerID']), axis=1)

df['EmployeeID'] = df.apply(lambda row: RemoveText(row['EmployeeID']), axis=1)

print(df.head(5))
