library(tidyverse)


a = rnorm(100, mean = 10, sd = 1)
b = rnorm(100, mean = 10.5, sd = 4)
c = rnorm(100, mean = 14, sd = 1)

mean(a)

sd(a)


mean(b)
sd(b)

df = data.frame(a=a,b=b,c=c)
df = gather(df, Var, Value, 1:3)


?rnorm

ggplot(df, aes(x=Value, fill = Var)) +
  geom_density(alpha = .5) 
# p< .05 it is significant

t.test(a,b)
t.test(a,c)

mod1 = (aov(Value ~ Var, data = df))
summary(mod1)
tuk1 = TukeyHSD(mod1) #all possible comparisons between every value of subtracting th emean
tuk1
plot(tuk1)


binom.test()
