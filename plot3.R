# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# which of these four sources have seen decreases in emissions from 1999-2008 
# for Baltimore City? Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question

#read NEI and SCC data 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



library(ggplot2)

#subsetting main data to get baltimore data, and grouping emissions by year and by type
BA <- subset (NEI, fips == "24510")
BA.T2 <- aggregate(BA$Emissions, by=list(BA$year,BA$type),FUN=sum)


colnames(BA.T2) <- c("Year","Type","Emissions")

# plotting
png("plot3.png") 
print (qplot(Year, Emissions, data=BA.T2, color=Type, geom ="line") + ggtitle(expression("Baltimore" ~ PM[2.5] ~ "Emmission")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))) 
dev.off()


