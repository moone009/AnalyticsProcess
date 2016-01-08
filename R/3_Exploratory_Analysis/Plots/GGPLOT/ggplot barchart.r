n = 250
Meter <- data.frame(MeterID = paste0("MTR-", 1:n), 
                    MeterName = paste0("NZXST", sample(999:99999, n, replace = TRUE)),
                    CurrentServiceType= sample(c("Commercial","Industrial", "Residential","Shop","Lost"), n, replace = TRUE, prob=c(.10,.10,.75,.02,.07)),
                    DaysWithoutMeterEvent = sample(c( "1-5","6-10","10-25","25-50","50+"), 
                                                   n, replace = TRUE, prob=c(.33,.13,.34,.14,.07)),
                    Location = sample(c("Outdoor", "Indoor"), n, replace = TRUE), 
                    MeterAgeDays = sample(1:9999, n, replace = TRUE),
                    CollectionType = sample(c("Cellular", "Drive By", "Network"), n, replace = TRUE, prob=c(.1, .3, .6))
)


Data = as.data.frame(table(Meter$CurrentServiceType))
ggplot(Data, aes(x=reorder(Var1,-Freq), y = Freq,fill=Var1)) + geom_bar(stat="identity")
 
