###############################################################################################################################
# Name             : Pivot Count
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Pivot data example
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# load libraries

library(data.table)
library(reshape2)

##_____________________________________________________________________________________________________________________________
# Setup sample data

n = 5000000
CallCenter <- data.frame(CallID = paste0("CID.", 1:n), 
                         CustomerID = paste0("CUST-", sample(999:99999, n, replace = TRUE)),
                         EmployeeID = paste0("REP-", sample(1:35, n, replace = TRUE)),
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
                                                 seq(0, 4000, by=10)), n, replace=TRUE),
                         Score = runif(n, 0, 1)
)



##_____________________________________________________________________________________________________________________________
# Pivot data

DT <- data.table(CallCenter)

system.time(Tmp <- DT[, .N, by = list(CallType,CurrentCustomer,Territory ,CompanyType)])
system.time(Tmp <- dcast(Tmp, CallType+CurrentCustomer+Territory~CompanyType))

 
system.time(dcast(CallCenter,CallType+CurrentCustomer+Territory~CompanyType,value.var = "CompanyType",fun.aggregate =length))

system.time(dcast(DT,CallType+CurrentCustomer+Territory~CompanyType,value.var = "CompanyType",fun.aggregate =length))
