

df = read.csv("./Data/landdata-states.csv")
names(df)
summary(df)
str(df)
plot (x=df$State, y=df$Home.Value)
levels(df$State)


plot(x=df$region, y=df$Home.Value, col=df$region)

plot(x=df$Year, y=df$Home.Value, col=df$region)

identical(df$Year, df$Date)

plot(x=df$Year, y=df$Land.Value, col=df$region)

plot(x=df$Land.Value, y=df$Home.Value, col=df$region)

plot(x=df$Date, y=df$Year)

mod1 = lm(df$Home.Value ~ df$Land.Value)

summary(mod1)
abline(mod1)

sum(mod1$residuals^2)

plot(x=df$Home.Value, y=df$Year)
summary(mod2)
plot(mod2)

mod2= lm(df$Home.Value ~ df$Year)
abline(mod2)

plot(df$Home.Value ~ df$Year)
abline(mod2, col="Red")

mod3= aov(df$Home.Value ~ df$Year + df$region)
summary(mod3)

mod4= aov(df$Home.Value ~ df$Year * df$region)
summary(mod4)

mod5= aov(df$Home.Value ~ df$Year * df$region * df$State * df$Qrtr)

summary(mod5)

mod6= aov(df$Home.Value ~ df$Year * df$region * df$State + df$State:df$region + df$Qrtr)
summary(mod6)

anova(mod5,mod6)

sum(mod5$residuals^2)
sum(mod6$residuals^2)

rm(mod5)



df2=read.delim("Data/US_Biome_Diversity.tsv")


plot(df2)
names(df2)

summary(df2)

str(df2)

plot(x=df2$Biome, y=df2$Diversity)
levels(df2$Biome)
levels(df2$Diversity)
levels(df2$State)

plot(x=df2$Diversity, y=df2$biome2z, col=df2$State)
as.character(df2$Biome)
biome2z=as.character(df2$Biome)
df2$Div2 = biome2z

png("./testplot.png")
plot(x=factor(df2$Div2), y=df2$Diversity, col=df2$State)
dev.off()



library(ggplot2)
ggplot(df, aes(x=Year, y=Home.Value,color=region)) + geom_point() + stat_smooth(method = "lm")
