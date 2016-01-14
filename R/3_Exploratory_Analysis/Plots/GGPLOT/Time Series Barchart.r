###############################################################################################################################
# Name             : Time Series Barchart
# Date             : 12-14-2016
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Create time series barchart
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150114            initial
###############################################################################################################################


##load library
library(ggplot2)

n <- 5000
CallCenter <- data.frame(CallID = paste0("CID.", 1:n), 
                         CustomerID = paste0("CUST-", sample(999:99999, n, replace = TRUE)),
                         EmployeeID = paste0("REP-", sample(1:35, n, replace = TRUE)),
                         CallDate = paste0(Sys.Date() - sample(1:30, n, replace = TRUE)),
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


Data = as.data.frame(table(CallCenter$CallDate,CallCenter$CallType))

ggplot(Data, aes(x=Var1, y = Freq,fill=Var2)) + geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90))

ggplot(Data, aes(x=reorder(Var1,-Freq), y = Freq,fill=Var2)) + geom_bar(stat="identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


