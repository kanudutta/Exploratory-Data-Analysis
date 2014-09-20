# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system 

#read NEI and SCC data 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subsetting main data to get baltimore data, and grouping emissions by year
BA <- subset (NEI, fips == "24510")
BA.T <- aggregate(BA$Emissions, by=list(BA$year),FUN=sum)
colnames(BA.T) <- c("Year","Emissions")

# plotting 
png("plot2.png")
plot(BA.T,type="l",xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~"Emissions"),col='green',main = expression("Total Baltimore" ~ PM[2.5] ~ "Emissions"))
dev.off()    

