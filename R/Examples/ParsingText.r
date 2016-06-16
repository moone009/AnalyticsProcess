

library(stringr)
text <- "hello at moon@gmail.com and bob@wisc.edu and joe@florida.edu"
str_extract(text, "\\S*@\\S*")
text <- strsplit(text," ") 
text <- unlist(text, recursive = TRUE, use.names = TRUE)
names(table(str_extract(text, "\\S*@\\S*")))



x = c("07620 Alpine, N.J.", "94027 Atherton, Calif.", "10014 New York, N.Y.", "91008 Duarte, Calif.")
zip = str_extract(x, "^[0-9]+")
city = toupper(str_extract(x, "[A-z]+( [A-z]+)*"))
state = toupper(str_extract(x, "([A-z]+.)+$"))
mydf = data.frame(zip, city, state)