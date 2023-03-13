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

#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? Using the base plotting system, make a plot 
#showing the total PM2.5 emission from all sources for each of the 
#years 1999, 2002, 2005, and 2008.
totalEmissions <- aggregate(Emissions ~ year, summSCC, sum)

#Plot emissions by year for Baltimore
plot(totalEmissions$year, totalEmissions$Emissions, main="Total Emissions by Year", xlab="Year", ylab="Emissions", type="l", col="skyblue")

##Plot time series to file
png(filename="plot1.png")
# plotting
plot(totalEmissions$year, totalEmissions$Emissions, main="Total Emissions by Year", xlab="Year", ylab="Emissions", type="l", col="skyblue")
dev.off()