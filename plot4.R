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

#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
SourcClassCodecoal <- SourcClassCode[grepl("coal", SourcClassCode$Short.Name, ignore.case = T),]
summSCCcoal <- coalClassCode[coalClassCode$SCC %in% SourcClassCodecoal$SCC,]
finalCoal <- aggregate(Emissions ~ year + type, summSCCcoal, sum)

#plot
ggplot(finalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle(expression("Total US" ~ PM[2.5] ~ "Coal Emission by Type and Year")) +
  xlab("Year") +
  ylab(expression("US " ~ PM[2.5] ~ "Coal Emission")) +
  scale_colour_discrete(name = "Type of sources") +
  theme(legend.title = element_text(face = "bold"))

ggsave("plot4.png", width = 15, height = 15, units = "cm")