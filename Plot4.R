library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

coalCodes <- SCC[grep(".*Coal.*", SCC$Short.Name),"SCC"]
totalPerYear <- ddply(NEI[NEI$SCC %in% coalCodes,], c("year"), 
                      function(df)sum(df$Emissions, na.rm=TRUE))

png(filename="plot4.png")
ggplot(data=totalPerYear, aes(x=year, y=V1)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 (tons)") +
  ggtitle("PM2.5 from Coal-Related Sources vs. Year")
dev.off()