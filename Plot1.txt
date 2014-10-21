library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

totalPerYear <- ddply(NEI, c("year"), 
                      function(df)sum(df$Emissions, na.rm=TRUE))

png(filename="plot1.png")
plot(totalPerYear$year, totalPerYear$V1, type="l", xlab="Year", ylab="PM2.5 (tons)", main="Tons of PM2.5 Generated Per Year")
dev.off()