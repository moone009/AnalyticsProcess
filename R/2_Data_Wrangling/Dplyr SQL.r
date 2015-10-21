###############################################################################################################################
# Name             : Dplyr SQL
# Date             : 10-20-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Example of how to use DPLYR for databases
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20151020            initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages
library(dplyr)
library(nycflights13)


##_____________________________________________________________________________________________________________________________
## SQLLITE
# Setup DB Connection or DB
my_db <- src_sqlite("my_db.sqlite31", create = T)

# Copy Data to new tables
copy_to(my_db, flights, temporary = FALSE, indexes = list(c("year", "month", "day"), "carrier", "tailnum"))
copy_to(my_db, mtcars, temporary = FALSE, indexes = list( "gear"))

# Insert New Records to existing table
db_insert_into( con =my_db$con, table = "mtcars", values  = mtcars)

# Query Data
tbl(my_db, sql("SELECT count(*) FROM flights where carrier = 'UA' and dep_delay > 240 "))
tbl(my_db, sql("SELECT mpg,cyl,hp FROM mtcars "))
tbl(my_db, sql("SELECT gear,count(*) as CT FROM mtcars group by gear "))


##_____________________________________________________________________________________________________________________________
## mysql

library(dplyr)
conDplyr = src_mysql(dbname = "trainingDB", user = "training", 
                     password = "training123", host = "localhost")

myData <- conDplyr %>%
  tbl("titanic") %>%
  select(pclass, sex, age, fare, survived, parch) %>%
  filter(survived==0) %>%
  collect() 

myData <- conDplyr %>%
  tbl("titanic") %>%
  select(pclass, sex, survived) %>%
  group_by(pclass, sex) %>%
  summarise(survival_ratio = mean(survived)) %>%
  collect() 

myDF <- tbl(conDplyr,"titanic")
myDF1 <- filter(myDF, fare > 150)
myDF2 <- select(myDF1, pclass,sex,age,fare)
myDF3 <- group_by(myDF2, pclass,sex)
myDF4 <- summarise(myDF3, 
                   avg_age = mean(age),
                   avg_fare = mean(fare))


myDF2$query








