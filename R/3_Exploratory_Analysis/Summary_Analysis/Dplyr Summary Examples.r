#########################################################################################################
# Name             : Dplyr Summary Examples
# Date             : 07-24-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Making life a little easier
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150724???             initial
#########################################################################################################


library(dplyr)

##__________________________________________________________________________________________________________________________________________
# Create Sample Data
n=25000
CallCenter <- data.frame(CallID = paste0("CID.", 1:n), 
                         CustomerID = paste0("CUST-", sample(1:999, n, replace = TRUE)),
                         CallDate = paste0(Sys.Date() - sample(1:365, n, replace = TRUE)),
                         CallType= sample(c("Billing","Pricing", "Tech Question","MISC","Product Information"), n, replace = TRUE),
                         CurrentCustomer = sample(c("yes", "no"), n, replace = TRUE), 
                         Territory = sample(c("West", "Midwest", "East"), n, replace = TRUE, prob=c(.25, .5, .25)), 
                         CompanyType = sample(c("Tech", "Sales","Industrial","Retail","None","Academic","Govt"), n, replace = TRUE), 
                         EstimatedCompanyRev = sample(c("<1", "1-5","6-10","10-25","25-50","50+"), 
                                                      n, replace = TRUE, prob=c(.13, .03,.13,.34,.14,.07)), 
                         FlaggedForCallBack = sample(c("No", "Yes"), 
                                                     n, replace = TRUE, prob=c(.93, .07)), 
                         CallDuration = sample(c(seq(0, 4000, by=10), 
                                                 seq(0, 4000, by=10)), n, replace=TRUE)
)

CallCenter$CallDate = as.Date(CallCenter$CallDate,format="%Y-%m-%d")


##__________________________________________________________________________________________________________________________________________
# Examples of Quick Summary tables
Stats =   CallCenter %>%  
  filter(CallDate >= '2014-01-01') %>% 
  group_by(CallType)               %>% 
  summarise(Mean=mean(CallDuration),Min=min(CallDuration),Max=max(CallDuration), Median=median(CallDuration), Std=sd(CallDuration),Sum = sum(CallDuration))
Stats

Stats =   CallCenter %>%  
  filter(CallDate >= '2014-01-01') %>% 
  group_by(Territory,CallType)     %>% 
  summarise(Mean=mean(CallDuration),Min=min(CallDuration),Max=max(CallDuration), Median=median(CallDuration), Std=sd(CallDuration),Sum = sum(CallDuration))
Stats

Stats =   CallCenter %>%  
  filter(CallDate >= '2014-01-01') %>% 
  filter(CallType != 'MISC')       %>% 
  group_by(Territory,CallType)     %>% 
  summarise(Mean=mean(CallDuration),Min=min(CallDuration),Max=max(CallDuration), Median=median(CallDuration), Std=sd(CallDuration),Sum = sum(CallDuration),Total_Records=n())
Stats

# Granular level rolling up at the customer level
Stats =   CallCenter %>%  
  filter(CallDate >= '2014-01-01') %>% 
  filter(CallType != 'MISC')       %>% 
  group_by(CustomerID)             %>% 
  summarise(Mean=mean(CallDuration),Min=min(CallDuration),Max=max(CallDuration), Median=median(CallDuration), Std=sd(CallDuration),Sum = sum(CallDuration),Total_Records=n())

arrange(Stats,desc(Total_Records),CustomerID)















