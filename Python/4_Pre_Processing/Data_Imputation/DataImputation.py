#########################################################################################################
# Name             : Data Imputation
# Date             : 04-21-2015
# Author           : Christopher M
# Dept             : BEI Business Analytics
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    CMooney      20150421             initial
#########################################################################################################


def ValueImputationMedian(frame,Target,IndicatorCol=False):
    if IndicatorCol == True:
        Col = Target + "_Missing"
        frame[Col] = frame[Target].isnull()
    
    frame[Target] = frame[Target].fillna(frame[Target].median())
    
    return(frame)
    
def ValueImputationAverage(df,Target,IndicatorCol=False):
    if IndicatorCol == True:
        Col = Target + "_Missing"
        df[Col] = df[Target].isnull()
    
    df[Target] = df[Target].fillna(df[Target].mean())
    
    return(df)    


