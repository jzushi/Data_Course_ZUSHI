library(readr)
df=read_csv("DNA_Conc_by_Extraction_Date.csv", col_names = TRUE)
cat("DNA_Conc_by_Extraction_Date.csv")

df<- read.csv(file = "DNA_Conc_by_Extraction_Date.csv", head = TRUE, sep="\t")
col1= df$Year_Collected
col2= df$Extract.Code


col3= df$Date_Collected
Katycon= df$DNA_Concentration_Katy
Bencon= df$DNA_Concentration_Ben
col6= df$Lab

class(col1)
class(col2)
str(df)
hist(col4, main = "Katy's Extractions", xlab = df$DNA_Concentration_Katy, ylab = df$Year_Collected )

Katy = data.frame(Year= df$Year_Collected, Concentration = df$DNA_Concentration_Katy)
Ben = data.frame(Year=df$Year_Collected, Concentration= df$DNA_Concentration_Ben)
hist(x=Katy$Year, y=Katy$Concentration)
str(Ben)
class(Ben$Year)
Ben$Year=as.factor(Ben$Year)
class(Katy$Year)
class(Katy$Concentration)
as.numeric(Katy$Year)
hist(col4, main = "Katy's Extractions", xlab = df$DNA_Concentration_Katy, ylab = df$Year_Collected )

Year1=as.integer(Katy$Year)
class(Katy$Year)
Katy$Year = as.factor(Katy$Year)
class(Katy$Year)
class(Katy$Concentration)



Katy1=plot(x=Katy$Year, y=Katy$Concentration)
hist(Katy1)

#Need to figure out what is going on here
hist(Katy$Year, main = "Katy DNA", xlab="Year", ylab = "DNA Concentration")
hist(Ben$Year, main = "Ben DNA", xlab = "Year", ylab = "DNA Concentration")


#Second task
plot(Ben, main= "Ben's Extractions", xlab= "Year", ylab= "DNA Concentrations")
plot(Katy, main= "Katy's Extractions", xlab= "Year", ylab= "DNA Concentrations")

#Third Task
jpeg(file= "ZUSHI_Plot1.jpeg") 
plot(Katy, main= "Katy's Extractions", xlab= "Year", ylab= "DNA Concentrations")
dev.off()

jpeg(file= "ZUSHI_Plot2.jpeg")
plot(Ben, main= "Ben's Extractions", xlab= "Year", ylab= "DNA Concentrations")
dev.off()

#Fourth Task
summary(Katycon)
summary(Bencon)

anova(Ben$Year~Katy$Year)
Ben$Year~Katy$Year


Ben$Concentration





#Fifth task
#Bengo= data.frame(Years= Ben$Year, Average= )

benmean=plot(x=Ben$Year, y=Ben$Concentration)

mean(Ben$Concentration)
summary(Ben$Year, Ben$Concentration)

summary(Ben$Year)
Ben$Year
sort(Ben$Year)|uniq
data=cbind(Ben$Year, Ben$Concentration)
data

