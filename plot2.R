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
baltSub <- subset(summSCC, summSCC$fips=="24510")

#Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510"fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
baltYearEmission <- aggregate(Emissions ~ year, baltSub, sum)

#Plot emissions by year for Baltimore
plot(baltYearEmission$year, baltYearEmission$Emissions, main="Baltimore Emissions by Year", xlab="Year", ylab="Emissions", type="l", col="blue", bg="gray")

##Plot time series to file
png(filename="plot2.png")
# plotting
plot(baltYearEmission$year, baltYearEmission$Emissions, main="Baltimore Emissions by Year", xlab="Year", ylab="Emissions", type="l", col="blue", bg="gray")
dev.off()