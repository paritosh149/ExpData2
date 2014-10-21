library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

totalPerYear <- ddply(NEI[NEI$fips == "24510",], c("year", "type"), 
                      function(df)sum(df$Emissions, na.rm=TRUE))

head(totalPerYear)
png(filename="plot3.png")
ggplot(data=totalPerYear, aes(x=year, y=V1, group=type, colour=type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 vs. Year by Source Type")
dev.off()
