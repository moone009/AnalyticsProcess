###############################################################################################################################
# Name             : SQLLITE_InsertFunction
# Date             : 04-15-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Custom function for inserting data into sqllite
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150415            initial
###############################################################################################################################



CreateTable = function(df,TableName,IndexColumn='None'){
 
	# Extract Column Names
	Names = colnames(df)
	files <- lapply(Names, function(x){paste(gsub("\\.","",x),  class(df[[which(colnames(df) ==x)]]) , "," )})
	files[length(files)] =  gsub( ",","",as.character(files[length(files)]))
	Sql = gsub( "factor","text",as.character(files))
	Sql = gsub(",,",",",toString(Sql))

	Script = paste("CREATE TABLE " ,TableName ,"(", Sql ,")")
	 
	# Create Table
	if(length(which(dbListTables(db)==TableName))>0){print("Table Exists")}
	else{
	dbSendQuery(conn = db,Script)
	}

	# Create Index
	if(IndexColumn != FALSE){
	idx = paste("CREATE INDEX ", IndexColumn ,"ON", TableName ,"(",IndexColumn,");")
	dbSendQuery(conn = db,idx)
	}
	 
	 
	# Prepare data for insert	
	Columns = rep("?,",length(Names))
	Columns[length(Columns)] =  gsub( ",","",as.character(Columns[length(Columns)]))
	Columns = gsub(",,",",",toString(Columns))

	# Insert data from data frame	
	InsertScript = paste("INSERT INTO ",TableName ,"VALUES (",Columns,")")
	dbGetPreparedQuery(db, InsertScript, data.frame(df))	


}

