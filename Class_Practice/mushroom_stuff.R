library(tidyverse)
library(readr)
library(ggplot2)
library(modelr)



df = read_csv("../../Desktop/Data_Course/Data/mushroom_growth.csv")
glimpse(df)
df$Species = factor(df$Species)



ggplot(df, aes(x= Light, y= GrowthRate)) +
  geom_point() +
  geom_smooth(method = "lm")

mod1 = lm(GrowthRate ~ Light, data = df)
summary(mod1)

df2 = add_predictions(df, mod1)

ggplot(df2, (aes(x=Light))) +
  geom_point(aes(y= GrowthRate)) +
  geom_jitter(aes(y=pred), color= "Red") +
  labs(x= "Light", y= "Growth Rate")

df2 = mutate(df2, DIFF= abs(pred-GrowthRate))
mean(df2$DIFF)

ggplot(df, aes(x= Light, y= GrowthRate, color = Temperature)) +
  geom_point() + geom_smooth(method = "lm")

mod2 = lm(GrowthRate ~ Light*Temperature, data = df)
summary(mod2)

df2 = add_predictions(df2, mod2, var = "pred2")
df2 = mutate(df2, DIFF2 = abs(pred2 - GrowthRate))

ggplot(df2, aes(x=Light)) +
  geom_point(aes(y=GrowthRate), alpha = .5) +
  geom_jitter(aes(y=pred), color = "Red") +
  geom_jitter(aes(y=pred2), color = "Blue")

mean(df2$DIFF)
mean(df2$DIFF2)

df$Humidity = factor(df$Humidity)
df3 = add_predictions(df, mod2)
mod3 = lm(GrowthRate ~ Light*Humidity, data = df)
summary(mod3)

df3 = add_predictions(df3, mod3, var = "pred3")
df3 = mutate(df3, DIFF3 = abs(pred3 - GrowthRate))

ggplot(df3, aes(x=Light)) +
  geom_point(aes(y=GrowthRate), alpha = .5) +
  geom_jitter(aes(y=pred), color = "Red") +
  geom_jitter(aes(y=pred3), color = "Blue")


glm(GrowthRate ~ Light + Nitrogen, data = df, family = "gaussian")



#okay actual class stuff now



predR = predict(loess(GrowthRate ~ Nitrogen, data = df))
summary(predR)
ggplot(df, aes(x= Nitrogen, y = GrowthRate)) + 
  geom_point() + 
  geom_smooth(se=FALSE) + 
  geom_point(aes(y=predR), color = "Red", size = 4)
  
  
mod.loess = loess(GrowthRate ~ Nitrogen, data = df)
predict(mod.loess, newdata = 15)

#because there was only 1 thinkg this worked but we would have had to make a df

nd = data.frame(Nitrogen = 15)

mod.loess = loess(GrowthRate ~ Nitrogen, data = df)
N15 = predict(mod.loess, newdata = nd)
N15

