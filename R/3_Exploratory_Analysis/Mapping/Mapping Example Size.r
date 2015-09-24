#########################################################################################################
# Name             : Mapping Example.r
# Date             : 08-26-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : For Fun
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150826              initial
########################################################################################################




library(ggmap)
library(scales)
library(zipcode)
library(ggplot2)
library(dplyr)
library(plyr)

df <- read.table(header = TRUE, text = "
subjectid   location           disease
12          'Naperville,il'         yes
15          'Chicago,IL'          no
13          'Lake Forest,IL'  yes
85          'Lake Forest,IL'  yes
46          'Naperville,il'         yes
569         'Chicago,IL'          yes
825         'Lake Forest,IL'  yes
685         'Naperville,il'         no
54          'Lake Forest,IL'  no
214         'Naperville,il'         no
214         'Orland Park,il'         no
214         'Orland Park,il'         no
214         'Downers Grove,il'         no
214         'Downers Grove,il'         no
214         'Downers Grove,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
214         'Oak Park,il'         no
214         'Oak Park,il'         no
685         'Chicago,IL'          no
125         'Lake Forest,IL'  yes
569         'Chicago,IL'          no", stringsAsFactors = FALSE)

# Get geographic locations and merge them into the data file
geoloc <- geocode(unique(df$location))
pos <- data.frame(location = unique(df$location), geoloc, stringsAsFactors = FALSE)
df <- merge(df, pos, by = "location", all = TRUE)

df = rbind(df,df,df,df,df)

# Summarise the data file
df = ddply(df, .(location, lon, lat), summarise, 
           countDisease = sum(ifelse(disease == "yes", 1, 0)),
           countTotal = length(location))

map <- get_map(location = 'chicago,il', zoom = 9)
ggmap(map) + geom_point(data = df, aes(x = lon, y = lat,size = 50)) 


ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countTotal)) +
  scale_size(range = c(1, 5))


ggmap(map) + geom_point(data = df, aes(x = lon, y = lat, size = countTotal, colour = countTotal)) +
  scale_size(range = c(1, 5)) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")











MapData <-structure(list(servzip = c(NA, 5029, 53005, 53007, 53008, 53012, 
                                     53017, 53018, 53021, 53022, 53023, 53024, 53027, 53029, 53033, 
                                     53036, 53040, 53045, 53046, 53051, 53054, 53056, 53058, 53064, 
                                     53066, 53069, 53072, 53074, 53076, 53080, 53089, 53091, 53092, 
                                     53094, 53095, 53097, 53103, 53104, 53105, 53108, 53109, 53110, 
                                     53114, 53118, 53119, 53120, 53122, 53126, 53127, 53129, 53130, 
                                     53132, 53138, 53139, 53140, 53142, 53143, 53144, 53145, 53146, 
                                     53149, 53150, 53151, 53152, 53153, 53154, 53156, 53158, 53167, 
                                     53168, 53170, 53171, 53172, 53177, 53178, 53179, 53180, 53181, 
                                     53182, 53183, 53184, 53185, 53186, 53187, 53188, 53189, 53190, 
                                     53192, 53194, 53202, 53203, 53204, 53205, 53206, 53207, 53208, 
                                     53209, 53210, 53211, 53212, 53213, 53214, 53215, 53216, 53217, 
                                     53218, 53219, 53220, 53221, 53222, 53223, 53224, 53225, 53226, 
                                     53227, 53228, 53233, 53235, 53295, 53402, 53403, 53404, 53405, 
                                     53406, 53504, 54113, 54130, 54136, 54140, 54656, 54903, 54911, 
                                     54913, 54914, 54915, 54942, 54952, 54956, 54957, 54958, 56167, 
                                     58245), latitude = c(NA, NA, 43.060872, 43.10836, 43.018696, 
                                                          43.305412, 43.199526, 43.05348, 43.483263, 43.219155, 43.777582, 
                                                          43.32546, 43.313361, 43.132743, 43.233282, 43.178685, 43.52413, 
                                                          43.055315, 43.153447, 43.151183, NA, 43.146023, 43.108775, 43.018696, 
                                                          43.108241, 43.114118, 43.076953, 43.40181, 43.265289, 43.394676, 
                                                          43.14004, 43.502688, 43.223907, 43.170606, 43.40328, 43.234506, 
                                                          42.886982, 42.551693, 42.662671, 42.825711, 42.535968, 42.948416, 
                                                          42.60027, 42.991622, 42.881035, 42.797775, 43.050762, 42.778642, 
                                                          42.960098, 42.937448, 42.941264, 42.896145, 42.66749, 42.691937, 
                                                          42.60217, 42.559823, 42.56427, 42.601842, NA, 42.973663, 42.872477, 
                                                          42.901235, 42.980163, 42.574616, 42.935259, 42.884347, 42.879242, 
                                                          42.529075, 42.742629, 42.573081, 42.550263, 42.642298, 42.909816, 
                                                          42.699169, 43.015999, 42.515668, NA, 42.515596, 42.696322, 43.002534, 
                                                          42.532636, 42.798555, 43.015289, 43.018696, 43.020762, 42.967394, 
                                                          42.818747, 42.511818, 42.58098, 43.046213, 43.037963, 43.017414, 
                                                          43.053763, 43.076179, 42.985465, 43.047863, 43.11941, 43.068962, 
                                                          43.083012, 43.072062, 43.049012, 43.020363, 42.999364, 43.086711, 
                                                          43.14351, 43.11096, 42.996614, 42.969115, 42.953915, 43.083261, 
                                                          43.163692, 43.153865, 43.11576, 43.048545, 42.997647, 42.966681, 
                                                          43.037313, 42.971156, 43.017412, 42.767286, 42.704519, 42.743169, 
                                                          42.714369, 42.730807, 42.698173, 44.264904, 44.293197, 44.268387, 
                                                          44.286637, 43.96977, 44.06858, 44.276986, 44.322836, 44.267411, 
                                                          44.244753, 44.29382, 44.212448, 44.180085, 44.198944, NA, 43.536338, 
                                                          NA), longitude = c(NA, NA, -88.09478, -88.06893, -88.302997, 
                                                                             -87.99794, -88.26177, -88.39844, -87.98908, -88.12043, -88.10103, 
                                                                             -87.94573, -88.37332, -88.34737, -88.2396, -88.5739, -88.19215, 
                                                                             -88.1503, -88.16124, -88.11034, NA, -88.30975, -88.40276, -88.302997, 
                                                                             -88.48935, -88.43771, -88.268, -87.88001, -88.20144, -87.95887, 
                                                                             -88.22641, -88.43299, -87.95085, -88.73058, -88.18026, -88.00914, 
                                                                             -88.20955, -88.04908, -88.28132, -87.94293, -88.144386, -87.86101, 
                                                                             -88.74978, -88.47085, -88.47117, -88.40435, -88.0842, -87.96609, 
                                                                             -88.374455, -87.99839, -88.05121, -88.00891, -88.541721, -88.12599, 
                                                                             -87.82979, -87.87878, -87.83043, -87.87617, NA, -88.15414, -88.34409, 
                                                                             -88.12464, -88.09438, -88.232632, -88.40501, -87.8992, -88.58987, 
                                                                             -87.87201, -88.22308, -88.12444, -88.17065, -87.903161, -87.86395, 
                                                                             -87.91692, -88.59572, -88.13454, NA, -88.25761, -88.04658, -88.37771, 
                                                                             -88.59862, -88.19409, -88.20924, -88.302997, -88.26852, -88.264, 
                                                                             -88.73279, -88.18285, -87.662878, -87.9005, -87.91548, -87.92625, 
                                                                             -87.93473, -87.93476, -87.89998, -87.96618, -87.94727, -87.97423, 
                                                                             -87.8859, -87.9103, -88.00012, -88.01273, -87.94343, -87.9749, 
                                                                             -87.90894, -87.99436, -87.99213, -87.99141, -87.9457, -88.02823, 
                                                                             -87.98717, -88.04032, -88.04121, -88.04239, -88.03717, -88.03798, 
                                                                             -87.93373, -87.87452, -87.569664, -87.79747, -87.80062, -87.80534, 
                                                                             -87.82424, -87.85827, -89.85736, -88.312, -88.25922, -88.33656, 
                                                                             -88.31001, -90.80796, -88.644873, -88.39445, -88.40492, -88.4383, 
                                                                             -88.37783, -88.53557, -88.40959, -88.48273, -88.678863, NA, -95.38554, 
                                                                             NA), CT = c(47L, 1L, 7071L, 677L, 2L, 1390L, 351L, 2633L, 13L, 
                                                                                         5995L, 1L, 5998L, 1L, 6912L, 1L, 16L, 1L, 7302L, 459L, 11850L, 
                                                                                         1L, 103L, 1423L, 35L, 4891L, 408L, 9033L, 4348L, 4L, 1798L, 6125L, 
                                                                                         1L, 7631L, 1L, 23L, 1915L, 1334L, 2117L, 8274L, 1334L, 5L, 6522L, 
                                                                                         1L, 2305L, 1830L, 124L, 1994L, 2485L, 61L, 4754L, 2605L, 11323L, 
                                                                                         7L, 1145L, 9506L, 11395L, 7517L, 7910L, 3L, 2727L, 6413L, 8817L, 
                                                                                         10219L, 5L, 891L, 10763L, 2L, 5378L, 149L, 3609L, 891L, 15L, 
                                                                                         7591L, 2424L, 1L, 2305L, 1L, 206L, 2715L, 1015L, 1L, 7015L, 9538L, 
                                                                                         13L, 10494L, 8668L, 1L, 81L, 1L, 2347L, 9L, 8934L, 2279L, 8235L, 
                                                                                         14027L, 8683L, 14232L, 8600L, 9220L, 9535L, 9683L, 12242L, 16437L, 
                                                                                         10765L, 9555L, 12243L, 12621L, 8104L, 11611L, 9067L, 8302L, 5513L, 
                                                                                         6325L, 5972L, 7227L, 4548L, 810L, 2621L, 13L, 11832L, 8944L, 
                                                                                         4595L, 9436L, 9758L, 1L, 219L, 9L, 2207L, 1L, 1L, 4L, 8849L, 
                                                                                         5806L, 10980L, 14127L, 2141L, 2106L, 14427L, 1L, 1L, 2L, 1L)), .Names = c("servzip", 
                                                                                                                                                                   "latitude", "longitude", "CT"), row.names = c(NA, -142L), class = "data.frame")






MapData$label <- paste(MapData$servzip,'Mtrs:',MapData$CT)
map <- get_map(location = 'milwaukee,wi', zoom = 12)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")



MapData$label <- paste(MapData$servzip,'\nMtrs:',MapData$CT)

map <- get_map(location = 'milwaukee,wi', zoom = 9)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue",high = "red", space = "Lab")


map <- get_map(location = 'milwaukee,wi', zoom = 9)
ggmap(map) + geom_point(data = MapData, 
                        aes(x = longitude, y = latitude, size = CT, colour = CT)) +
  scale_size(range = c(1, 35))+   
  #geom_text(data = MapData, aes(x = longitude, y = latitude, fontface='bold',label = as.character(label))) +
  scale_colour_continuous(low = "blue", high = "red", space = "Lab")





























