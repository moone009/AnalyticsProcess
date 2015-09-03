###############################################################################################################################
# Name             : PairingCols
# Date             : 02-08-2015
# Author           : Christopher M
# Dept             : Business Analytics
# Purpose          : Reordering columns to pair keys and descriptions next to each other
# Called by        : Not in production
###############################################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150208            initial
###############################################################################################################################


PairingCols <- function(df,Cols){
  
  ColList = 1:length(df)
  ColOne = which(colnames(df) == Cols[1])
  ColTwo = which(colnames(df) == Cols[2])
  
  li = c()
  li <- c(li, 1:which(ColList == ColOne))
  li <- c(li, which(ColList == ColTwo))
  
  Cols = c(li,ColList[-c(li)])
  return(Cols)
  
}


##_____________________________________________________________________________________________________________________________
# Example

df = structure(list(id_prem = c(934L, 1262L, 1584L, 3854L, 5210L, 
5371L), id_spt = c(1L, 1L, 1L, 1L, 1L, 1L), id_mtr = c("  VO786107", 
"  VZ172131", "  NZ156283", "  VO723368", "  VZ453544", "PVXZT80283"
), cd_mtr_mfg = c("F", "F", "A", "F", "F", "F"), cd_offc = c("76", 
"76", "81", "93", "72", "72"), cd_mtr_dials = c(5L, 5L, 5L, 5L, 
5L, 5L), cd_mtr_desc = c("SM", "SE", "SE", "SM", "SE", "SU"), 
    dt_mtr_purch = c("2002-03-21", "2002-09-17", "2005-12-06", 
    "1998-09-18", "2004-10-29", "2007-05-15"), cd_mtr_volts = c("240", 
    "240", "240", "240", "240", "A02"), cd_class = c(200L, 200L, 
    200L, 200L, 200L, 200L), qy_mtr_const = c(1L, 1L, 1L, 1L, 
    1L, 1L), cd_comm_medium = c("AM", "AM", "AM", "AM", "AM", 
    "AM"), Purchase_year = c(2002, 2002, 2005, 1998, 2004, 2007
    ), MeterType = c("VO", "VZ", "NZ", "VO", "VZ", "PVXZT"), 
    Manufacturer = c("Schlumberger/Sangamo", "Schlumberger/Sangamo", 
    "Landis & Gyr (Duncan/Lafayette)", "Schlumberger/Sangamo", 
    "Schlumberger/Sangamo", "Schlumberger/Sangamo"), id_trnsfmr = c(701167254793, 
    699416250572, 690150294824, 643660412187, 684031288551, 690320287994
    )), .Names = c("id_prem", "id_spt", "id_mtr", "cd_mtr_mfg", 
"cd_offc", "cd_mtr_dials", "cd_mtr_desc", "dt_mtr_purch", "cd_mtr_volts", 
"cd_class", "qy_mtr_const", "cd_comm_medium", "Purchase_year", 
"MeterType", "Manufacturer", "id_trnsfmr"), class = "data.frame", row.names = c(NA, 
6L))


head(df)
df = df[,c(PairingCols(df,c('cd_mtr_mfg','Manufacturer')))]
head(df)
