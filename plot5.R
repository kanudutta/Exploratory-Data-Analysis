# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

library(ggplot2)

#read NEI and SCC data 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset data from motor vehicle  by type=ON-ROAD 
BA3 <- subset (NEI, fips == "24510" & type=="ON-ROAD")

#Grouping motor vehicle emissions by year 
BAMV.T <- aggregate(BA3$Emissions, by=list(BA3$year),FUN=sum)
colnames(BAMV.T) <- c("Year","Emissions")

#plotting
png("plot5.png")
print(qplot(Year, Emissions, data=BAMV.T, geom="line") + ggtitle(expression("Baltimore" ~ PM[2.5] ~ "Motor Vehicle Emissions")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions")))
dev.off()
