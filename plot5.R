library(ggplot2)
#set Data files names
if(!file.exists("./data")){dir.create("./Data")}
zipFile <- "./Data/exdata_data_NEI_data.zip"

#check if files are extracted
if (!file.exists("./Data/summarySCC_PM25.rds") || !file.exists("./Data/Source_Classification_Code.rds")) {
  unzip(zipFile, overwrite = T, exdir = "./Data")
}

summSCC <- readRDS("./Data/summarySCC_PM25.rds")
SourcClassCode <- readRDS("./Data/Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#Subset and aggregrate cars AND Baltimore data
baltData <-subset(summSCC, summSCC$fips=="24510" & summSCC$type == "ON-ROAD")
baltCars <- aggregate(Emissions ~ year, baltData, sum)

#Plot
ggplot(baltCars, aes(year, Emissions,col = "green")) + geom_point() + geom_line() + ggtitle("Baltimore Vehicle Emissions")

ggsave("plot5.png", width = 15, height = 15, units = "cm")