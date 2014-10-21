library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

vehicleCodes <- grep("^(22010|22300)", NEI$SCC)
vehicleCodes <- intersect(which(NEI$fips == "24510"), vehicleCodes)

totalPerYear <- ddply(NEI[vehicleCodes,], c("year"), 
                      function(df)sum(df$Emissions, na.rm=TRUE))

png(filename="plot5.png")
ggplot(data=totalPerYear, aes(x=year, y=V1)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 from Motor Vehicles vs. Year in the Baltimore City")
dev.off()
