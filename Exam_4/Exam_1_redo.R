library(ggplot2)
library(readr)
library(tidyverse)
#1
df = read.delim("DNA_Conc_by_Extraction_Date.csv")
head(df)
dfKaty <- df[,-5]
dfBen <- df[,-4]
head(dfKaty)
head(dfBen)


hist(df$DNA_Concentration_Katy, xlab = "DNA Concentration", main ="Katy's DNA")
hist(df$DNA_Concentration_Ben, xlab = "DNA Concentration", main = "Ben's DNA")
#2
plot(x=df$Year_Collected, y=df$DNA_Concentration_Katy)
class(df$Year_Collected)
class(df$DNA_Concentration_Katy)
Katy<- plot(x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Katy)
plot(Katy, xlab = "Year", ylab = "DNA Concentratin", main= "Katy's Extractions")
plot(Katy, x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Katy, xlab = "YEAR", ylab = "DNA Concentration", main= "Katy's Extractions")
Ben<- plot(x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Ben)
plot(Ben, x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Ben, xlab = "YEAR", ylab = "DNA Concentration", main= "Ben's Extractions")
#3
jpeg(file= "ZUSHI_Plot1_Redo.jpeg") 
plot(Katy, x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Katy, xlab = "YEAR", ylab = "DNA Concentration", main= "Katy's Extractions")
dev.off()
jpeg(file= "ZUSHI_Plot2_Redo.jpeg")
plot(Ben, x=as.factor(df$Year_Collected), y=df$DNA_Concentration_Ben, xlab = "YEAR", ylab = "DNA Concentration", main= "Ben's Extractions")
dev.off()
#4
summary(dfKaty$DNA_Concentration_Katy)
summary(dfBen$DNA_Concentration_Ben)

K <- aggregate(DNA_Concentration_Katy ~ Year_Collected, dfKaty, mean)
B <- aggregate(DNA_Concentration_Ben ~ Year_Collected, dfBen, mean)
diff <- (B$DNA_Concentration_Ben-K$DNA_Concentration_Katy)
x <- cbind(K,B$DNA_Concentration_Ben, diff)
x$Year_Collected[which.min(x$diff)]


#5
B <- aggregate(DNA_Concentration_Ben ~ Year_Collected, dfBen, mean)

B1 <- B$Year_Collected[which.max(B$DNA_Concentration_Ben)]
B[B$Year_Collected == B1,]

