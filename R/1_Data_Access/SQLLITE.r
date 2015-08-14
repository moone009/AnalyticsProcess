###############################################################################################################################
# Name             : SQLLITE
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Examples of how to read,write,insert,update and work with dataframes using SQLLITE
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################

##_____________________________________________________________________________________________________________________________
# Load Packages

library(sqldf)

##_____________________________________________________________________________________________________________________________
#create new database or if exists it will simply connect
setwd('F:\\')
db <- dbConnect(SQLite(), dbname="SqlDB.sqlite")

# Create test data
testdata = rbind(mtcars,mtcars,mtcars,mtcars,mtcars,mtcars,mtcars)
testdata = rbind(testdata,testdata,testdata,testdata,testdata,testdata,testdata)
testdata = rbind(testdata,testdata,testdata,testdata,testdata,testdata,testdata)

# Insert Data into SQLlite
dbWriteTable(db, "Cars_Data", testdata)
 
# Read Data into SQLlite
dbGetQuery(db, "select * from Cars_Data limit 3")

# View Tables and columns
dbGetQuery(db, "SELECT name FROM  sqlite_master WHERE type='table'")
dbListTables(db)  
dbListFields(db, "Cars_Data")	

# Create Tables
dbSendQuery(conn = db,
       "CREATE TABLE School
       (SchID INTEGER,
        Location TEXT,
        Authority TEXT,
        SchSize TEXT)")	 

# Drop Tables		
dbSendQuery(conn = db,"Drop table School")	 
	
