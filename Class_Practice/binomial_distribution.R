library(tidyverse)


a = rnorm(500000, mean = 10, sd = 1)
b = rnorm(500000, mean = 10.5, sd = 1)
c = rnorm(500000, mean = 11, sd = 1)

#bigger the sample size the smaller the difference you can detect with certaintity 

mean(a)

sd(a)


mean(b)
sd(b)

df = data.frame(a=a,b=b,c=c)
df = gather(df, Var, Value, 1:3)


ggplot(df, aes(x=Value, fill = Var)) +
  geom_density(alpha = .5) 
# p< .05 it is significant

t.test(a,b)
t.test(a,c)

mod1 = (aov(Value ~ Var, data = df))
summary(mod1)
tuk1 = TukeyHSD(mod1) #all possible comparisons between every value of subtracting the means.
tuk1
plot(tuk1)

#binomial distribution is countin the number of successes
hist(rbinom(3,10,.5))
#the more you replicate something, the closer you will get to the true distribution in nature




binom.test(10,10,.99)
#super low p value tells you that the results you saw don't come from a binomial distribution 
#small p value (p<0.5) means to reject (failed to accept) your null hypothesis. Ain't no difference (so there is a difference?)
#what we really want to now is the probability of it happening. Sample, count up success, then see if it is believable that hypothesized probability

?t.test
#T-test is comparing the mean between two groups
#science doesn't prove things, it disproves things


