#########################################################################################################
# Name             : Create Dummies Example
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

import numpy as np
import pandas as pd

my_data = np.array([[5, 'a', 1],
                    [3, 'b', 3],
                    [1, 'b', 2],
                    [3, 'a', 1],
                    [4, 'b', 2],
                    [7, 'c', 1],
                    [7, 'c', 1]])                


df = pd.DataFrame(data=my_data, columns=['y', 'dummy', 'x']) 


dummies = pd.get_dummies(df['dummy'])

dummies = pd.concat([df, dummies], axis=1)      
dummies =  dummies.drop(['dummy'], axis=1)

print(dummies)

 