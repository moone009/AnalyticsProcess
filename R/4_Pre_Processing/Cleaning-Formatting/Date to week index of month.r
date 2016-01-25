###############################################################################################################################
# Name             : Date to week index of month
# Date             : 01-22-2016
# Author           : Artem Klevtsov: Found function on stackoverflow
# Dept             : Business Analytics
# Purpose          : convert date to week of month (1-5)
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150715             initial
###############################################################################################################################


monthweeks <- function(x) {
  UseMethod("monthweeks")
}
monthweeks.Date <- function(x) {
  ceiling(as.numeric(format(x, "%d")) / 7)
}
monthweeks.POSIXlt <- function(x) {
  ceiling(as.numeric(format(x, "%d")) / 7)
}
monthweeks.character <- function(x) {
  ceiling(as.numeric(format(as.Date(x), "%d")) / 7)
}

dates <- as.Date(c('2012-05-01','2011-12-22'))
monthweeks(dates)


