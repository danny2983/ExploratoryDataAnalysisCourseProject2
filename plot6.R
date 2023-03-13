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

#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
#Subset both Baltimore and LA and then vehicles
baltLA <-subset(summSCC, summSCC$fips %in% c("24510", "06037") & summSCC$type == "ON-ROAD")
baltLACars <- aggregate(Emissions ~ year + fips, baltLA, sum)

#Plot
ggplot(baltLACars, aes(year, Emissions, col=fips)) + geom_point() + geom_line() + ggtitle("Baltimore vs LA County Vehicle Emissions") + scale_colour_discrete(name = "Location", labels = c("LA County", "Baltimore"))

ggsave("plot6.png", width = 15, height = 15, units = "cm")