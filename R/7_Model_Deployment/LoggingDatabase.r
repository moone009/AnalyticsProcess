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

##_____________________________________________________________________________________________________________________________
## SQLLITE
# Setup DB Connection or DB
my_db <- src_sqlite("AnalyticsModel_logger", create = T)


# Manually Create Table
dbSendQuery(my_db$con, 'CREATE TABLE Model_Logging_Classification(
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            ModelID varchar(200),
            ProcessedRecords int, 
            StartTime varchar(200),
            EndTime varhcart(200), 
            Acc int, 
            Recall int,
            Precision int) ')

dbSendQuery(my_db$con, 'CREATE TABLE Model_Logging_Prediction(
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            ModelID varchar(200),
            ProcessedRecords int, 
            StartTime varchar(200),
            EndTime varhcart(200), 
            MSE int, 
            MAE int) ')

dbSendQuery(my_db$con, 'CREATE TABLE Models(
            ID INTEGER PRIMARY KEY AUTOINCREMENT,
            ModelID varchar(200),
            ModelDescription varchar(2000), 
            Model_Type varchar(200),
            Model_Specific_Type varchar(200),
            Model_Author varchar(200),
            Model_Author_Dept varchar(200),
            RunFrequency varchar(200)
) ')


## Run Frequencies
# Everyday Hourly
# Everyday Once Per day
# Five Days a week Once Per day
# Once a week
# First of the Month
# End of the Month

## Example Models Log
ModelId <- paste0("'",'Class_001', "'")
ModelDescription <- paste0("'",'RandomForest that classifiess Meter Type A Failure', "'")
Model_Type <- paste0("'",'Classification', "'")
Model_Specific_Type <-paste0("'",'RandomForest', "'")
Model_Author <- paste0("'",'Christopher Mooney', "'")
Model_Author_Dept <- paste0("'",'BEI', "'")
RunFrequency <-  paste0("'",'Everyday Once Per day', "'")

## Example Classification Result Log
ModelId <- paste0("'",'Class_001', "'")
ProcessedRecords<- 435435
StartTime <- paste0("'", as.character(Sys.time()), "'")
EndTime <- paste0("'", as.character(Sys.time()), "'")
Acc <- 89.94
Recall <- 95.5
Precision <- 99.8

## Example Prediction Result Log
ModelId <- paste0("'",'Regression_001', "'")
ProcessedRecords<- 555
StartTime <- paste0("'", as.character(Sys.time()), "'")
EndTime <- paste0("'", as.character(Sys.time()+sample(1343,3323,99)[1]), "'")
MSE <- 22
MAE <- 12


Insert_one <- "INSERT INTO Models (ModelId,ModelDescription,Model_Type,Model_Specific_Type,Model_Author,Model_Author_Dept,RunFrequency) VALUES ("
Insert_Two <-  list(ModelId, ModelDescription, Model_Type, Model_Specific_Type, Model_Author,Model_Author_Dept,RunFrequency)
Insert_Two <- paste(as.character(Insert_Two), collapse=",")
dbSendQuery(my_db$con,paste(Insert_one,Insert_Two,")"))

Insert_one <- "INSERT INTO Model_Logging_Classification (ModelId,ProcessedRecords,StartTime,EndTime,Acc,Recall,Precision) VALUES ("
Insert_Two <-  list(ModelId,ProcessedRecords, StartTime, EndTime, Acc, Recall,Precision)
Insert_Two <- paste(as.character(Insert_Two), collapse=",")
dbSendQuery(my_db$con,paste(Insert_one,Insert_Two,")"))

Insert_one <- "INSERT INTO Model_Logging_Prediction (ModelId,ProcessedRecords,StartTime,EndTime,MSE,MAE) VALUES ("
Insert_Two <-  list(ModelId,ProcessedRecords, StartTime, EndTime, MSE,MAE)
Insert_Two <- paste(as.character(Insert_Two), collapse=",")
dbSendQuery(my_db$con,paste(Insert_one,Insert_Two,")"))


as.data.frame(tbl(my_db, sql("SELECT *  FROM Models ")))
as.data.frame(tbl(my_db, sql("SELECT *  FROM Model_Logging_Classification ")))

Predictions <- as.data.frame(tbl(my_db, sql("SELECT *  FROM Model_Logging_Prediction ")))
Predictions$RunTime <-strptime(Predictions$EndTime,"%Y-%m-%d %H:%M:%S") - strptime(Predictions$StartTime,"%Y-%m-%d %H:%M:%S")
Predictions
