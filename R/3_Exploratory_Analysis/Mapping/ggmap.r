library(ggmap)
library(ggplot2)
library(dplyr)


train <- read.csv("F:\\Analytics_Process\\R\\SampleData\\SF.csv")

Agg = sqldf("select Category,X,Y,count(*) as CT from train group by Category,X,Y")
Agg = subset(Agg, CT >5)

as.data.frame(table(Agg$Category))
map <- get_map(location = 'San Francisco,California', zoom = 13)
mapPoints = ggmap(map) +  geom_point(aes(x = X, y = Y, color = Category), data = Agg, alpha = .8,size = 4)
mapPoints



counts <- summarise(group_by(train, Category), Counts=length(Category))
counts <- counts[order(-counts$Counts),]
# This removes the "Other Offenses" category
top10 <- train[train$Category %in% counts$Category[c(1,30:40)],]

top10 <- summarise(group_by(top10, Category,X,Y), Counts=length(Category))

map <- get_map(location = 'San Francisco,California', zoom = 13)
mapPoints = ggmap(map) +  geom_point(aes(x = X, y = Y, color = Category), data = top10, alpha = .8,size = 4)
mapPoints


counts <- summarise(group_by(train, Resolution), Counts=length(Resolution))
counts <- counts[order(-counts$Counts),]
# This removes the "Other Offenses" category
top10 <- train[train$Resolution %in% counts$Resolution[c(1,3:10)],]

top10 <- summarise(group_by(top10, Resolution,X,Y), Counts=length(Resolution))

map <- get_map(location = 'San Francisco,California', zoom = 13)
mapPoints = ggmap(map) +  geom_point(aes(x = X, y = Y, color = Resolution), data = top10, alpha = .8,size = 4)
mapPoints








