
# Load packages
library(tidyverse)
library(tidyr)
library(ggplot2)
library(dplyr)
library(modelr)
library(MASS)
library(fitdistrplus)
library(gridExtra)

# Load data
df <- read.csv("./../../../Data_Course/Data/GradSchool_Admissions.csv")

# Quick peek
glimpse(df)

# Converted to factors
# df$admit <- factor(df$admit)
# df$rank <- factor(df$rank)


# Visualizing data
ggplot(data = df) +
  geom_histogram(aes(x = gre), bins = 10)

ggplot(df, aes(x = gpa, y = admit)) +
  geom_point() +
  geom_smooth(method = "glm", se = FALSE)
  
p <- ggplot(df, aes(x = gre, y = admit)) +
  geom_point() +
  geom_smooth(method = "glm", se = FALSE)




# Make a model to show the relationship between admit and other variables

mod1 <- glm(admit ~ gre * rank, data = df, family = "binomial")
summary(mod1)


# gather info from model
df$predicted <- predict(mod1)
df$residuals <- residuals(mod1)

# plot from above but with model precited values
p2 = p + geom_smooth(method="glm", se=FALSE, alpha=.05, color="lightgrey") +
  geom_point(aes(y=df$predicted),color="Red")
p2

# Show residuals
p3 = p2 + geom_segment(aes(xend = gre, yend = df$predicted), linetype=2) +
  theme_bw() + 
  geom_text(x = 300, y = 30, mapping = aes(label = paste0("Sum of Squares = ", signif(sum(residuals(mod1)^2),4)))) +
  geom_text(x = 300, y = 27.5, mapping = aes(label=paste0("Mean Sq. Deviance = ", signif(mean(residuals(mod1)^2),4))))
p3


# Trying "logistic" regression
mod1 <- glm(admit ~ gre * gpa , data = df, family = "binomial")

df$binom.pred <- predict(mod1, type = "response")
df$binom.resid <- residuals(mod1, type = "response")

summary(mod1)
exp(coefficients(mod1)) 

ggplot(df, aes(x = gre, y = admit)) +
  geom_segment(aes(xend = gre, yend = binom.pred), alpha=.5) +
  geom_point() +
  geom_point(aes(y = binom.pred), shape = 22, color = "Blue") +
  geom_point(data = df %>% filter(admit != round(binom.pred)),
             color = "red", size = 2)


mod2 <- glm(admit ~ gre * rank * gpa, data = df, family = "binomial")

df$binom.pred <- predict(mod2, type = "response")
df$binom.resid <- residuals(mod2, type = "response")

summary(mod2)
exp(coefficients(mod2)) 


ggplot(df, aes(x = gre, y = admit)) +
  geom_segment(aes(xend = gre, yend = binom.pred), alpha=.5) +
  geom_point() +
  geom_point(aes(y = binom.pred), shape = 22, color = "Blue") +
  geom_point(data = df %>% filter(admit != round(binom.pred)),
             color = "red", size = 2)




