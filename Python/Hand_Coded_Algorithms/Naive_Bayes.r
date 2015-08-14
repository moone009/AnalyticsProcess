#########################################################################################################
# Name             : Naive Bayes Classifier
# Date             : 07-08-2015
# Author           : Christopher M
# Dept             : BEI
# Purpose          : Classification 
# Called by        : Not in production
#########################################################################################################
# ver    user        date(YYYYMMDD)        change  
# 1.0    w47593      20150708              initial
#########################################################################################################
rm(list=ls(all=TRUE))

##_____________________________________________________________________________________________________________________________

outlook = c('rainy','rainy','overcast','sunny','sunny','sunny','overcast','rainy','rainy','sunny','rainy','overcast','overcast','sunny')
Temp = c('hot','hot','hot','mild','cold','cold','cold','mild','cold','mild','mild','mild','hot','mild')
Humidity = c('high','high','high','high','normal','normal','normal','high','normal','normal','normal','high','normal','high')
Windy = c('false','true','false','false','false','true','true','false','false','false','true','true','false','true')
Golf = c('n','n','y','y','y','n','y','n','y','y','y','y','y','n')

df = cbind(outlook,Temp,Humidity,Windy,Golf)
df = as.data.frame(df)

##_____________________________________________________________________________________________________________________________

target = 'Golf'
TargetsToProcess = length(table(df[target]))
TargetNames = rownames(table(df[target]))

vars = c('outlook','Temp','Humidity','Windy')

##_____________________________________________________________________________________________________________________________
Postieor = c()
for(i in 1:TargetsToProcess){
  
assign(paste("Postieor_",rownames(table(df[target]))[i],sep=''),nrow(df[df[target] == TargetNames[i],])) 
Postieor = c(Postieor,paste("Postieor_",rownames(table(df[target]))[i],sep=''))

}

##_____________________________________________________________________________________________________________________________
for(var_i in 1:length(vars)){
  
# Create dynamic variables
assign(vars[var_i], as.data.frame.matrix(table(df[[vars[var_i]]],df[[target]])))

# here we need to pass our dynamically created object into a static object
tmp =get(vars[var_i])

for(i in 1:TargetsToProcess){
                                                        # Confusing amount of code, we are simply calling our posterior probability
  tmp[[  TargetNames[i]  ]] = tmp[[  TargetNames[i]  ]]/get(ls()[ which(ls() == paste('Postieor_',TargetNames[i],sep='')) ])
  tmp$Col = rownames(tmp)
  
}
# Reassign variable
assign(vars[var_i],  tmp)
}

##_____________________________________________________________________________________________________________________________

Input_Outlook = 'rainy'
Input_Temp = 'mild'
Input_Humidity = 'normal'
Input_Windy = 'true'

Input = 'y'
i = 2
Yes = get(vars[1])[get(vars[1])$Col == Input_Outlook,c(Input)] *
      get(vars[2])[get(vars[2])$Col == Input_Temp,c(Input)] *
      get(vars[3])[get(vars[3])$Col == Input_Humidity,c(Input)] *
      get(vars[4])[get(vars[4])$Col == Input_Windy,c(Input)] * 
      get(ls()[ which(ls() == paste('Postieor_',TargetNames[i],sep=''))])/nrow(df)


Input = 'n'
i = 1
No =  get(vars[1])[get(vars[1])$Col == Input_Outlook,c(Input)] *
      get(vars[2])[get(vars[2])$Col == Input_Temp,c(Input)] *
      get(vars[3])[get(vars[3])$Col == Input_Humidity,c(Input)] *
      get(vars[4])[get(vars[4])$Col == Input_Windy,c(Input)] * 
      get(ls()[ which(ls() == paste('Postieor_',TargetNames[i],sep=''))])/nrow(df)



##_____________________________________________________________________________________________________________________________

YesPlay = Yes/(Yes+No)
NoPlay = No/(Yes+No)

YesPlay
NoPlay

