library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)
NEI$year <- as.numeric(NEI$year)

twocity<-NEI[NEI$fips=="24510"|NEI$fips=="06037",]
vehicles<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicles)<-"SCC"

data2<-merge(vehicles,twocity,by="SCC")
data2$city[data2$fips=="24510"]<-"Baltimore"
data2$city[data2$fips=="06037"]<-"LA"

plotdata<-ddply(data2,.(year,city),summarize,sum=sum(Emissions))
png("plot6.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_line(aes(color=city),size=1)+labs(title="PM2.5 Emission from motor vehicle sources",
                                              y="total PM2.5 emission each year")
dev.off()