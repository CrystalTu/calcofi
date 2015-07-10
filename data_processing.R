setwd("work/Fishery/calcofi")
library(jsonlite)
library(reshape2)
library(dplyr)

output=fromJSON('adj_space_quarter_data1951_2007.json')

output$quarter_cruise_season[1]

test <- matrix(as.numeric(unlist(output$crdata[1])),ncol=178,byrow=TRUE)
class("test")<-numeric
