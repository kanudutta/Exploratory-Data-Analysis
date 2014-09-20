#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, 

library(ggplot2)
library(gridExtra)

#read NEI and SCC data 

#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")


#Subset data from motor vehicle  by type=ON-ROAD fro both cities
BA <- subset (NEI, fips == "24510" & type=="ON-ROAD")
LA <- subset (NEI, fips == "06037" & type=="ON-ROAD")

#Grouping motor vehicle emissions by year and by type for both cities
BAmv.T <- aggregate(BA$Emissions, by=list(BA$year,BA$type),FUN=sum)
City <- c("Baltimore","Baltimore","Baltimore","Baltimore")
BAmv.T1 <- cbind(BAmv.T,City)
colnames(BAmv.T1) <- c("Year","Type","Emissions","City")
LAmv.T <- aggregate(LA$Emissions, by=list(LA$year,LA$type),FUN=sum)
City <- c("Los Angeles","Los Angeles","Los Angeles","Los Angeles")
LAmv.T1 <- cbind(LAmv.T,City)
colnames(LAmv.T1) <- c("Year","Type","Emissions","City")
combined <- rbind(BAmv.T1,LAmv.T1)

#plotting
png("plot6.png")
p1 <- qplot(Year, Emissions, data=combined, colour=City,geom="path")
p2 <- ggplot(data=combined, aes(x=factor(Year), y=Emissions, fill=City)) + geom_bar(stat="identity", position=position_dodge())+xlab("Year")
g_legend<-function(p){
  tmp <- ggplotGrob(p)
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

legend <- g_legend(p1)
lwidth <- sum(legend$width)

p3 <- grid.arrange(arrangeGrob(p1 
                         ,p2, main ="Motor Vehicle Emissions Baltimore Vs Los Angeles",
                         left = ""),widths=unit.c(unit(1, "npc") - lwidth, lwidth), nrow=1)
print (p3)
dev.off()