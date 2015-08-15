library(curl); library(gdata)

setwd("/home/billy/Documents/CourseraDataScience/DataProducts/Project")

download.file(url = "http://www.sepa.org.uk/media/141539/2011-household-waste.xls",
              destfile = "./Data/scot11.xls",method="wget")
download.file(url = "http://www.sepa.org.uk/media/141591/2013_household_waste_official_statistics.xls",
              destfile = "./Data/scot13.xls",method="wget")
# 2012 data is available only as a pdf due to an error on the website
download.file(url = "http://www.sepa.org.uk/media/141552/2012-household-waste-official-statistics.pdf",
              destfile = "./Data/scot12.pdf",method="wget")
rawdata_11<-read.xls(xls = "./Data/scot11.xls", sheet = 1, skip =1)[2:33,c(1,2,4)]
rawdata_13<-read.xls(xls = "./Data/scot13.xls", sheet = 1, skip =1)[1:32,c(1,2,4)]
#2012 data copied and pasted from pdf file
arising_12<-c(97242,134708,60803,48509,27737,77709,70103,58793,55233,52346,
              43986,187741,14299,76111,195595,234209,126183,33248,42701,49883,
              62729,155838,10233,75015,82126,52861,10865,57627,151923,43190,
              38944,72345)
recycling_12<-c(37.3,35.6,40.1,31.5,58.9,22.2,29.7,44.4,38.7,44.8,54.2,36.7,
                29.7,55.2,52.8,29.5,44.3,50.7,45.3,51.9,51.8,39.8,22.5,55.0,
                38.9,42.8,13.5,47.5,37.4,55.7,44.1,43.0)
scotData<-data.frame(council=rawdata_11[,1],
                     waste_2011=rawdata_11[,2],waste_2012=arising_12,waste_2013=rawdata_13[,2],
                     recycling_2011=rawdata_11[,3],recycling_2012=recycling_12,
                     recycling_2013=rawdata_13[,3])

scotData$council<-as.character(scotData$council)
scotData$recycling_2011<-as.numeric(as.character(scotData$recycling_2011))
scotData$recycling_2013<-as.numeric(as.character(scotData$recycling_2013))
scotData$waste_2011<-as.numeric(gsub(",","",as.character(scotData$waste_2011)))
scotData$waste_2013<-as.numeric(gsub(",","",as.character(scotData$waste_2013)))
write.csv(scotData,"./Data/datafile.csv")
                     
                     
                     
                     
                     