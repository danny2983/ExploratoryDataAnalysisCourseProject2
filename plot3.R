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

#Subsetting
baltSub <- subset(summSCC, summSCC$fips == "24510")

#Of the four types of sources indicated by the typetype 
#(point, nonpoint, onroad, nonroad) variable, which of these four 
#sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 
#plotting system to make a plot answer this question.
baltAggType <- aggregate(Emissions ~ year + type, baltSub, sum)

#Plot
ggplot(data=baltAggType, aes(year, Emissions, col=type)) + geom_point() + geom_line() + ggtitle("Baltimore Emissions by Year and Type")

##Plot time series to file
ggsave("plot3.png", width = 15, height = 15, units = "cm")


