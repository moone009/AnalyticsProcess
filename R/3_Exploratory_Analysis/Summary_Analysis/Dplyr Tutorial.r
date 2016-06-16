library(dplyr)
library(data.table)
library(lubridate)
library(jsonlite)
library(tidyr)
library(ggplot2)
library(compare)

##______________________________________________________________________________________________________

spending=fromJSON("https://data.medicare.gov/api/views/nrth-mfg3/rows.json?accessType=DOWNLOAD")
names(spending)

meta=spending$meta
hospital_spending=data.frame(spending$data)
colnames(hospital_spending)=make.names(meta$view$columns$name)
hospital_spending=select(hospital_spending,-c(sid:meta))

dim(hospital_spending)
head(hospital_spending)

colnames(hospital_spending) <- gsub('\\.','',colnames(hospital_spending))

changeclass <- function(df){
  
  for(z in 1:length(colnames(df))){
    if(nrow(df)< 100){print('please change column types manually; record count < 100, stopping operation')
                      break 
    }
    len <- length(table(df[colnames(df)[z]]))
    total <- length(grep('[A-z]',df[[colnames(df)[z]]]))
    
    if(len > 32 & total == 0){df[,colnames(df)[z]] <- as.numeric(as.character(df[,colnames(df)[z]]))}
    if(len > 32 & total > 1){df[,colnames(df)[z]] <- as.character(df[[colnames(df)[z]]])}
    if(len <= 32 ){df[,colnames(df)[z]] <- as.factor(df[,colnames(df)[z]])}
  }
  return(df)
}

hospital_spending <- changeclass(hospital_spending)

##______________________________________________________________________________________________________
## subset columns
## select(Dataframe...columns)     

hospital_spending_subset <- select(hospital_spending,HospitalName, Period,  ClaimType)
head(hospital_spending_subset)


##______________________________________________________________________________________________________
## Drop columns

head(select(hospital_spending, -Period,-MeasureEndDate,-MeasureStartDate))

## Column Range
head(select(hospital_spending, HospitalName:State))

## Column Regular Expression
head(select(hospital_spending, starts_with("p")))
head(select(hospital_spending, ends_with("d")))
head(select(hospital_spending, contains("en")))

##______________________________________________________________________________________________________
## Filter Data

filter(hospital_spending, PercentofSpendingState >= 95 & State == 'WI' & AvgSpendingPerEpisodeHospital > 21000)
filter(msleep, sleep_total >= 16, bodywt >= 1)
filter(hospital_spending, HospitalName %in% c("BELLIN MEMORIAL HOSPITAL", "FROEDTERT MEMORIAL LUTHERAN HOSPITAL") & ClaimType == 'Hospice')

##______________________________________________________________________________________________________
## Chaining Operations

## Does not work because we removed ClaimType First
hospital_spending %>% 
  select(HospitalName, ProviderNumber) %>% 
  filter(HospitalName %in% c("BELLIN MEMORIAL HOSPITAL", "FROEDTERT MEMORIAL LUTHERAN HOSPITAL") & ClaimType == 'Hospice')

## Now it works because we reversed the selct and filter operation
hospital_spending %>% 
  filter(HospitalName %in% c("BELLIN MEMORIAL HOSPITAL", "FROEDTERT MEMORIAL LUTHERAN HOSPITAL") & ClaimType == 'Hospice') %>%
  select(HospitalName, ProviderNumber)

## Add decending order
hospital_spending %>% 
  filter(HospitalName %in% c("BELLIN MEMORIAL HOSPITAL", "FROEDTERT MEMORIAL LUTHERAN HOSPITAL")) %>%
  arrange(-ProviderNumber)  %>% 
  select(HospitalName, ProviderNumber)

##______________________________________________________________________________________________________
## Sumarizing Data
hospital_spending %>% 
  group_by(State) %>%
  summarise(avg = mean(PercentofSpendingState), 
            sd =   sd(PercentofSpendingState),
            median = median(PercentofSpendingState),
            min = min(PercentofSpendingState), 
            max = max(PercentofSpendingState),
            total = n())



