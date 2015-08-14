setwd("F:\\Analytics_Process\\R\\")

folders <- list.dirs(full.names = TRUE)
file <- list.files(folders, full.names = TRUE)  
file = as.data.frame(file)
file = sqldf("select * from file where file like '%.r%'")
file$file = as.character(file$file)

li = c()
for(i in 1:nrow(file)){
res <- suppressWarnings(readLines(file[[1]][i]))
print(cat(paste('filename',gsub('# Name             ','',res[2]),paste('- Purpose',gsub('# Purpose          ','',res[6])))))
li = c(li,paste(paste('location:',file[[1]][i]),'~ filename',gsub('# Name             ','',res[2]),paste('~ Purpose',gsub('# Purpose          ','',res[6]))))
}
write.csv(li,'Analytic_files.txt',row.names = F)
