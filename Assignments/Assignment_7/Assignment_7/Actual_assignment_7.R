library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
library(ggplot2)


# 1.  loads the "/Data/mushroom_growth.csv" data set
df = read.csv("../../../../Data_Course/Data/mushroom_growth.csv")
glimpse(df)
df$Species = factor(df$Species)

# 2.  creates several plots exploring relationships between the response and predictors
ggplot(df, aes(x= Light, y= GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm")


ggplot(df, aes(x= Nitrogen, y= GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm")


ggplot(df, aes(x= Humidity, y= GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm")


ggplot(df, aes(x= Temperature, y= GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm")

# 3.  defines at least 2 models that explain the **dependent variable "GrowthRate"**
#   + One must be a lm() and 
# + one must be an aov()

mod1 = lm(GrowthRate ~ Nitrogen, data = df)
summary(mod1)
df$predicted <- predict(mod1)
df$residuals <- residuals(mod1)

mod2 = (aov(GrowthRate ~ Light, data = df))
summary(mod2)
df$predicted <- predict(mod2)
df$residuals <- residuals(mod2)

# 4.  calculates the mean sq. error of each model
mean(mod1$residuals^2)
mean(mod2$residuals^2)
# 5.  selects the best model you tried
mod2
# 6.  adds predictions based on new values for the independent variables used in your model
predR = predict(loess(GrowthRate ~ Nitrogen, data = df))
summary(predR)
# 7.  plots these predictions alongside the real data
ggplot(df, aes(x= Nitrogen, y = GrowthRate)) + 
  geom_point() + 
  geom_smooth(se=FALSE) + 
  geom_point(aes(y=predR), color = "Red", size = 4)
# + Upload responses to the following as a numbered plaintext document to Canvas:
#   1.  Are any of your predicted response values from your best model scientifically meaningless? Explain
#No, they show a p value of < 0.5 so they are significant. Looking at the plot we can see hwo the amount of nitrogen changes the growth rate. There is a point that is the most optimal for growth, and from the graph we can see that too little or too much nitrogen will change growth rate as well. Though we have some outliers, we don't have any points showing up below 0 so it makes sense that this data has significance. 
# 2.  In your plots, did you find any non-linear relationships?  If so, do a bit of research online and give a link to at least one resource explaining how to deal with this in R
#https://datascienceplus.com/first-steps-with-non-linear-regression-in-r/






