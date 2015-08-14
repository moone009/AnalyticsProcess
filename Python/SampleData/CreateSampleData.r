###############################################################################################################################
# Name             : CreateSampleData
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : File to create sample data
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################
#Call Center
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

# Meter
Meter <- data.frame(MeterID = paste0("MTR-", 1:n), 
                    MeterName = paste0("NZXST", sample(999:99999, n, replace = TRUE)),
                    CurrentServiceType= sample(c("Commercial","Industrial", "Residential","Shop","Lost"), n, replace = TRUE, prob=c(.10,.10,.75,.02,.07)),
                    DaysWithoutMeterEvent = sample(c( "1-5","6-10","10-25","25-50","50+"), 
                                                   n, replace = TRUE, prob=c(.33,.13,.34,.14,.07)),
                    Location = sample(c("Outdoor", "Indoor"), n, replace = TRUE), 
                    MeterAgeDays = sample(1:9999, n, replace = TRUE),
                    CollectionType = sample(c("Cellular", "Drive By", "Network"), n, replace = TRUE, prob=c(.1, .3, .6))
)


# Collections
Collections <- data.frame(
  MeterID = paste0("MTR-", 1:n), 
  CustomerID = paste0("CUST-", sample(999:99999, n, replace = TRUE)),
  CurrentServiceType= sample(c("Commercial","Industrial", "Residential"), n, replace = TRUE, prob=c(.10,.10,.85)),
  SetupDate = paste0(Sys.Date() - sample(1:365, n, replace = TRUE)),
  PayPlan = sample(c( "FXB","FXC","MPO","NONE","PILOT"), 
                   n, replace = TRUE, prob=c(.33,.13,.34,.14,.07)),
  PlayPlanMethod = sample(c("IVR", "Online","CallCenter"), n, replace = TRUE, prob=c(.33,.1,.5)), 
  Arrears = sample(30:9999, n, replace = TRUE),
  RepeatCustomer = sample(c("Yes", "No"), n, replace = TRUE, prob=c(.7, .3)),
  SuccessProbability = runif(n, 0, 1)
)

# Print head to display feel of data for user
cat('\n Df: CallCenter \n')
print(head(CallCenter,2))
cat('\n Df: Meter \n')
print(head(Meter,2))
cat('\n Df: Collections \n')
print(head(Collections,2))
 
