library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
library(ggplot2)
#Part 1
#1
salaries = read.csv("../Exam_2/salaries.csv", stringsAsFactors = FALSE)
#2
#viewing the data different ways
tbl_df(salaries)
glimpse(salaries)
names(salaries)

#tried to gether it 
long <- gather(salaries, FacultyRank, Salary, AssistProf:FullProf, na.rm = FALSE, convert = FALSE)
#when i plotted my boxplot the salary numbers were weird so I was wanting to try to change it and see if it made a difference
long$Salary <- as.numeric(long$Salary)
Tier <- long$Tier

#3  
bp<-ggplot(long, aes(x=Tier, y=long$Salary, fill=FacultyRank)) +
  geom_boxplot()
boxplot = bp + ggtitle("Faculty Salaries - 1995") +
  xlab("University Tier") + ylab("Salary")

#4
jpeg(file= "ZUSHI_exam2_Plot1.jpeg") 
boxplot = bp + ggtitle("Faculty Salaries - 1995") +
  xlab("University Tier") + ylab("Salary")

dev.off()

#Part 2
#1
df2 = read.csv("atmosphere.csv")
glimpse(df2)

#2 Creating two different linear models

mod1 = lm(Diversity ~ CO2_Concentration, data = df2)
summary(mod1)
df2$predicted <- predict(mod1)
df2$residuals <- residuals(mod1)
mod2 = lm(Diversity ~ CO2_Concentration*Aerosol_Density, data = df2)
summary(mod2)
df2$predicted <- predict(mod2)
df2$residuals <- residuals(mod2)

#3 Comparing residuals
mean(mod1$residuals^2)
mean(mod2$residuals^2)
#mod2 has a lower number so it is better to use

#4 Add predictions 
pred1 <- add_predictions(df2, mod1)
pred2 <- add_predictions(df2, mod2)

#5

#trying to plot it
ggplot(df2, (aes(x=CO2_Concentration))+
  geom_point(aes(y=Diversity), alpha=.5) +
  geom_jitter(aes(y=pred1), color = "Red")) 


ggplot(df2, (aes(x=cyl))) +
  geom_point(aes(y=mpg)) +
  geom_jitter(aes(y=pred), color ="Red") +
  geom_point(aes(y=mpg)) +
  labs(x= "Cylinder", y= "MPG")

