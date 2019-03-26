#Packages
library(tidyverse)
library(fitdistrplus)


# Data
data("mtcars")
df <- mtcars

# quick peek
glimpse(df)


#plot mpg vs disp

p = ggplot(df, aes(x=disp,y=mpg)) +
  geom_point() 
p

p + geom_smooth(method = "lm", se=FALSE)

# Make linear model of relationship between disp and mpg
mod1 = lm(mpg ~ disp, data = df)
summary(mod1)
# gather info from model
df$predicted <- predict(mod1)
df$residuals <- residuals(mod1)

df
p

# plot from above but with model precited values
p2 = p + geom_smooth(method="lm", se=FALSE, alpha=.05, color="lightgrey") +
  geom_point(aes(y=df$predicted),color="Red")
p2

# Show residuals
p2 + geom_segment(aes(xend=disp,yend=df$predicted),linetype=2) +
  theme_bw() 
#shows you the difference between actual and theoretical

p2 + geom_smooth(aes(color = factor(am)), se = FALSE, method = "lm")
#anova splits data into categorical groups and runs linear models. If parallel no interaction. 
mod2 = aov(mpg ~ disp * factor(am), data = mtcars)
summary(mod2)


outcome = rbinom(100,1,.8)

attendance = rnorm(100,.5,.1)

score = sample(0:100,100)

df2= data.frame(outcome=outcome, attendance = attendance, score = score)

plot(df2$outcome)
ggplot(df2, aes(x=attendance, y=outcome)) +
  geom_point() + geom_smooth(method = "lm")


mod3 = glm(outcome ~ attendance, family = "binomial", data = df2)
summary(mod3)




