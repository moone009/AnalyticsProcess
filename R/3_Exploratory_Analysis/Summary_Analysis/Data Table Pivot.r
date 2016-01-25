dff <- mtcars

dff <- as.data.table(dff)

dff_sum <- dff[,list(HP_Sum=sum(mpg)),by=c('cyl', 'gear')]

dff_sum <- dff[,list(HP_Sum=sum(mpg),mean=mean(mpg),sd=sd(mpg),records= .N),by=c('cyl', 'gear')]

dff_ct <- dff[,list(records= .N),by=c('cyl', 'gear')]

dff[,list(mean=mean(mpg),sd=sd(mpg)),by=cyl]





Results Summary.

Anticipates obstacles and works to remove them. Christopher realized the the time to spent requesting data across the enterprise was costly and not efficient which has lead a culture of making gut based decisions. Christopher took it upon himself to see what platforms were being widely used and adopted by industry which ended up being Hadoop. Christopher took it upon himself to learn this complex database and language to ensure that we will have subject matter experts within the organization.

Sets high personal standards for own performance. Christopher is constantly learning in the classroom and on his own time. Along, with continually learning Christopher has a strong knack for complex data relationships and always goes back to double check his work. 

Can be trusted to effectively handle complex situations or problems without supervision or unnecessary guidance. 
Christopher is very capable to handle projects without supervision. Christopher creatively overcomes complex problems with statistical programming and understands the relational models of the enterprise. 

 
Interim SQL Server Data Mining Project
* Gain stronger understanding of WPS metering Data
* Build data model
* Build predictive models
* Build business rules models

Tableau Reporting for business clients
* Identified that many of the clients do not necessarily need modeling (often need inference) they need their data collected, cleansed, 
  and formatted for them to better understand what question to ask.
* Self Training
* Develop a semi automated process for data in Tableau to reach business end users on a timely manner
* CO, Harvest, Credit Collections, AMI Reporting, WPS

Hadoop Preparation
* Continue to keep skills polished for the upcoming hadoop project
* Gain better knowledge of Hive
* Gain better knowledge of Pig
* Gain better knowledge of custom MapReduce programming

Customer Operations Data Analysis
* Identify data sources
* Perform Data Analysis
* Identify if need for modeling or if data accepts modeling

Business Continuation
* Maintain Harvest
* Maintain and develop Iconnect
* Continue support with Meter-2-Bill
* Continue to monitor social security number