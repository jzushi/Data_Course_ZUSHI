?read.table
df<- read.csv("../../../Data_Course/Data/landdata-states.csv")
class(df)
head(df)

class(df$State)
class(df$Date)
dim(df)
str(df)
summary(df)
summary(df$Home.Value)
names(df)[4]
hist(df$Land.Value)
plot(x=df$region, y=df$Land.Value)
plot(x=df$Year, y=df$Land.Value, col=df$region)

library(readr)
 its<- read.delim("../../../Data_Course/Data/ITS_mapping.csv")
summary(its$SampleID)
dim(its)
str(its)
summary(its)
class(its$Ecosystem)
class(its$Lat)

hist(its$Ecosystem)
plot(its, xlab= "Ecosystem", ylab= "Lat", x=its$Ecosystem, y=its$Lat)

png(filename = "./../../../../Desktop/Data_Course_ZUSHI/Assignments/Assignment_4/silly_boxplot.png")
dev.off()
