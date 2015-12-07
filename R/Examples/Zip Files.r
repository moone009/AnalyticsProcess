
fileDir <- 'C:\\Users\\w47593\\Desktop\\WPS Data\\Detectent'
Output <- 'F:\\WPS Data Files'
files <- list.files(fileDir)

for(i in 1:length(files)){
print(paste(round(i/length(files),2),"%", " files have been zipped",sep=''))
zip(zipfile = paste(Output,'\\',i,'-',files[i],'.zip',sep=''), files = paste(fileDir,'\\',files[i],sep=''))
}

 