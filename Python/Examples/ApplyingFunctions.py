#########################################################################################################
# Name             : Grid_Search_RF
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################

import numpy as np
import pandas as pd
pyinstaller --onefile script.py
pd.set_option('display.height', 1000)
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

##
# KDD Cup Example
df = pd.read_csv('F:\\kddcup98-1.csv')


# Create lambda functions
RemoveText =  lambda x:  re.sub("\D", "", x )
RemoveNumbers =  lambda x:  re.sub("\d+", "", x )

def abc(a, b, c):
    return a*10000 + b*100 + c

test = df[['GiftCnt36','GiftCntAll','GiftCntCardAll']].head(20)

mappingValues = list(map(list, test.values))

test['MapTest'] = list(map(abc,mappingValues))

df['CustomerID'] = df.apply(lambda row: RemoveNumbers(row['CustomerID']), axis=1)


http://chrisalbon.com/r-stats/apply-with-plyr.html

data = {'name': ['Jason', 'Molly', 'Tina', 'Jake', 'Amy'], 
        'year': [2012, 2012, 2013, 2014, 2014], 
        'reports': [4, 24, 31, 2, 3],
        'coverage': [25, 94, 57, 62, 70]}
df = pd.DataFrame(data, index = ['Cochice', 'Pima', 'Santa Cruz', 'Maricopa', 'Yuma'])
df



capitalizer = lambda x: x.upper()

df['name'].map(capitalizer)
df['name'] = df['name'].apply(capitalizer)



def times100(x):
    # that, if x is a string,
    if type(x) is str:
        # just returns it untouched
        return x
    # but, if not, return it multiplied by 100
    elif x:
        return 100 * x
    # and leave everything else
    else:
        return
df.applymap(times100)


def Accountstatus(x,y):
    if x <= 25 and y <= 5:
        return 'small'
    if x > 40 and y < 10:
        return 'medium'
    else:
        return 'huge'

df['newcolumn'] = df.apply(lambda x: Accountstatus(x['coverage'], x['reports']), axis=1)
















