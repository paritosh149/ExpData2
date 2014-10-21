library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

totalPerYear <- ddply(NEI[NEI$fips == "24510",], c("year"), 
                      function(df)sum(df$Emissions, na.rm=TRUE))

png(filename="plot2.png")
plot(totalPerYear$year, totalPerYear$V1, type="l", xlab="Year", ylab="PM2.5 (tons)", main="Tons of PM2.5 Generated Per Year in Baltimore City")
dev.off()