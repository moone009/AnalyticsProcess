#########################################################################################################
# Name             : Create Boxplot
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

df.boxplot('DemAge') 

df.boxplot('GiftAvgCard36') 

 