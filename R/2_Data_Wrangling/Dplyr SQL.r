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
my_db <- src_sqlite("my_db.sqlite31r", create = T)

# Copy Data to new tables
copy_to(my_db, flights, temporary = FALSE, indexes = list(c("year", "month", "day"), "carrier", "tailnum"))
copy_to(my_db, mtcars, temporary = FALSE, indexes = list( "gear"))

# Manually Create Table
dbSendQuery(my_db$con, 'CREATE TABLE Model_Logging_Classification(ID INTEGER PRIMARY KEY AUTOINCREMENT,
            ModelID varchar(200),
            ProcessedRecords int, 
            StartTime varchar(200),
            EndTime varhcart(200), 
            Acc int, 
            Recall int,
            Precision int) ')

dbSendQuery(my_db$con, 'CREATE TABLE Models(ID INTEGER PRIMARY KEY AUTOINCREMENT,
            ModelID varchar(200),
            ModelDescription varchar(2000), 
            Model_Type varchar(200),
            Model_Specific_Type varchar(200),
            Model_Author varchar(200),
            Model_Author_Dept varchar(200),
            RunFrequency varchar(200)
            ) ')


Everyday Hourly
EVeryday Once Per day
Five Days a week Once Per day
Once a week
First of the Month
End of the Month

ModelId <- paste0("'",'Class_001', "'")
ModelDescription <- paste0("'",'RandomForest that classifiess Meter Type A Failure', "'")
Model_Type <- paste0("'",'Classification', "'")
Model_Specific_Type <-paste0("'",'RandomForest', "'")
Model_Author <- paste0("'",'Christopher Mooney', "'")
Model_Author_Dept <- paste0("'",'BEI', "'")


Insert_one <- "INSERT INTO Models (ModelId,ModelDescription,Model_Type,Model_Specific_Type,Model_Author,Model_Author_Dept) VALUES ("
Insert_Two <-  list(ModelId, ModelDescription, Model_Type, Model_Specific_Type, Model_Author,Model_Author_Dept)
Insert_Two <- paste(as.character(Insert_Two), collapse=",")
dbSendQuery(my_db$con,paste(Insert_one,Insert_Two,")"))


ModelId <- paste0("'",'Class_001', "'")
ProcessedRecords<- 435435
StartTime <- paste0("'", as.character(Sys.time()), "'")
EndTime <- paste0("'", as.character(Sys.time()), "'")
Acc <- 89.94
Recall <- 95.5
Precision <- 99.8
  
Insert_one <- "INSERT INTO Model_Logging_Results (ProcessedRecords,StartTime,EndTime,Acc,Recall,Precision) VALUES ("
Insert_Two <-  list(ProcessedRecords, StartTime, EndTime, Acc, Recall,Precision)
Insert_Two <- paste(as.character(Insert_Two), collapse=",")

dbSendQuery(my_db$con,paste(Insert_one,Insert_Two,")"))
as.data.frame(tbl(my_db, sql("SELECT *  FROM Model_Logging_Results ")))
as.data.frame(tbl(my_db, sql("SELECT *  FROM Models ")))




# Insert New Records to existing table
db_insert_into(con =my_db$con, table = "mtcars", values  = mtcars)

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








