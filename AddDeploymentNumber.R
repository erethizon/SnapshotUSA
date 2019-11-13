#R code to add deployment number to camera info and export as new .csv file

#set up space
rm(list =ls())
#turn on libraries
library(ggplot2)
library(dplyr)
library(readr)

#add data
DF <- read_csv("Camera info/snapshot_lat_long.txt")

#now add new column to assign SnapUSA deployment number

DF$SnapUSA_deploy<-0
#now assign to specific camera numbers

change<-which(DF$Camera_Num == 14)
change
DF$SnapUSA_deploy[change]<-1 

#Now add start and stop dates for each camera

DF$OutDate<-"9/27/19"
DF$InDate<-"11/12/19"
#create as dates
library(lubridate)
DF$OutDate<-mdy(DF$OutDate)
DF$InDate<-mdy(DF$InDate)
DF$Interval<-interval(DF$OutDate, DF$InDate)

DF$CamNights<-as.period(DF$Interval, "days")

whip<-which(DF$Card_Numbe == 42|DF$Card_Numbe == 15 | DF$Card_Numbe == 13)                
first_upload<-c(whip, change)
DF$OutDate[!first_upload]<-NULL
DF$SnapUSA_deploy[whip]<-c(2:4)

#now output to use when adding snapshot USA deployments
write.csv(DF, "camera_metadata.csv")

cum_cam_nights<-sum(as.numeric(DF$CamNights)/86400)
cum_cam_nights<-sum(DF$CamNights)/86400
