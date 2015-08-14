###############################################################################################################################
# Name             : Subsetting Data
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : How to subset data
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Sample Data
n = 200
source('F:\\Analytics_Process\\R\\SampleData\\CreateSampleData.r')

##_____________________________________________________________________________________________________________________________
# Examples

# View All MPO PlayPlans
subset(Collections, PayPlan == 'MPO')

# View All MPO PlayPlans setup through the call center
subset(Collections, PayPlan == 'MPO' & PlayPlanMethod == 'CallCenter')

# View All MPO PlayPlans setup through the call center with arreas less than 999
subset(Collections, PayPlan == 'MPO' & PlayPlanMethod == 'CallCenter' & Arrears < 999)

# View All MPO PlayPlans setup through the call center with arreas less than 999 and only return the customerID and success probability
subset(Collections, PayPlan == 'MPO' & PlayPlanMethod == 'CallCenter' & Arrears < 999 ,select = c( CustomerID, SuccessProbability))

# View All MPO PlayPlans setup through the call center with arreas less than 999 and all columns except for MeterId
subset(Collections, PayPlan == 'MPO' & PlayPlanMethod == 'CallCenter' & Arrears < 999 ,select = -c(MeterID))
