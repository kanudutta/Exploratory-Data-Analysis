# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999-2008?
# read NEI and SCC data 

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



# Searching for coal and comb pattern and then subsetting it with 
#original SCC data to get the desired rows

SCC1 <- grepl("coal", SCC$Short.Name,ignore.case=T) & grepl("comb",SCC$SCC.Level.One, 
                                                            ignore.case=T)
table(SCC1)

SCC2 <- SCC[SCC1,1]
cc1 <- NEI[NEI$SCC %in% SCC2,]

#grouping emissions by year and by type
cc1.Total <- aggregate(cc1$Emissions, by=list(cc1$year,cc1$type),FUN=sum)
colnames(cc1.Total) <- c("Year","Type","Emissions")

# plotting
png("plot4.png") 
print(ggplot(cc1.Total, aes(x = as.factor(Year), y = Emissions , fill=Type)) + geom_bar(stat = "identity") + 
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions")) +
  ggtitle("coal combustion-related sources Emission") + scale_fill_manual(values=c("#999999", "#E69F00")))
dev.off()

