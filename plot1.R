

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#read NEI and SCC data 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Total emissions by year
NEI.T <- aggregate(NEI$Emissions, by=list(NEI$year),FUN=sum)

# plotting

png("plot1.png")
plot(NEI.T,type="l",xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~"Emissions "),col='blue',main = expression("Total US" ~ PM[2.5] ~ "Emissions"))
dev.off()

