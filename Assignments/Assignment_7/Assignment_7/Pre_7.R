library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
data("mtcars")
glimpse(mtcars)
mod1 = lm(mpg ~ disp, data = mtcars)
summary(mod1)
plot(mtcars$mpg ~ mtcars$disp)
abline(mod1)
mod2 = lm(mpg ~ qsec, data = mtcars)
plot(mtcars$mpg ~ mtcars$qsec)
abline(mod2, col="Blue")
mean(mod1$residuals^2)
mean(mod2$residuals^2)
preds = add_predictions(mtcars, mod1) 
preds[1:5,c(1,12)]
newdf = data.frame(disp = c(500,600,700,800,900))
predictions = predict(mod1, newdata = newdf)
{plot(mtcars$mpg ~ mtcars$disp,xlim=c(0,1000),ylim=c(-10,50))
  points(x=newdf$disp,y=predictions, col="Red")
  abline(mod1)}