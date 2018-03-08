library(dplyr)
library(magrittr)
library(choroplethr)
library(tidyverse)
library(choroplethrMaps)
library(data.table)
setwd("/Users/stutipandey/Practice Github")
getwd()
data<-fread("Bridge data.csv")
data=mutate(data,cond=min(DECK_COND_058,SUPERSTRUCTURE_COND_059,SUBSTRUCTURE_COND_060,CHANNEL_COND_061,CULVERT_COND_062,na.rm=T))
class(data1$cond)
summary(data)
  rateit=function(cond){
    rate=rep("good",length(cond))
    rate[cond<5]="bad"
    rate[cond<2]="fail"
    return(rate)
  }
data$rate = rateit(data$cond)
table(data$cond)
table(data$rate)
table(data$RECORD_TYPE_005A)
TABLE()
data=filter(data,cond>0)
