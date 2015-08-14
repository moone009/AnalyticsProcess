#########################################################################################################
# Name             : Create Barchart
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot')

## Read in File
df = 'F:\kddcup98.csv'
df = pd.read_csv(df)

##_Charting     
Data = df.groupby('TARGET_B').size().reset_index()
Data.columns = ['TARGET_B','Total']
Data = Data.sort(['Total'], ascending=[False])
Data = Data.head(10)
Data = Data.set_index('TARGET_B')

Data.plot(kind='bar',alpha=0.5)

StatusCat96NK = df.groupby('StatusCat96NK').size().reset_index()
StatusCat96NK.columns = ['StatusCat96NK','Total']
StatusCat96NK = StatusCat96NK.sort(['Total'], ascending=[False])
StatusCat96NK = StatusCat96NK.head(10)
StatusCat96NK = StatusCat96NK.set_index('StatusCat96NK')

StatusCat96NK.plot(kind='bar')



 