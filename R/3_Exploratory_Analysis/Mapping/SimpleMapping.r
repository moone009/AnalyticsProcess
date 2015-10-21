head(crime)

downtown <- subset(crime,
                   -95.39681 <= lon & lon <= -95.34188 &
                     29.73631 <= lat & lat <=  29.78400
)

qmplot(lon, lat, data = downtown, maptype = "toner-background", color = I("red"))



downtown <- subset(crime, lat <= 30.3 &
                           -95.59681 <= lon & lon <= -95)
                   

qmplot(lon, lat, data = downtown, maptype = "toner-background", color = I("red"))