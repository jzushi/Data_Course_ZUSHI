library(readxl)
df1 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 1)
df2 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 2)
df3 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 3)

df1$Sheet <- "COS"
df2$Sheet <- "BUS"
df3$Sheet <- "ENG"

df = rbind(df1,df2,df3)

rm(df1,df2,df3)

# What have I done here?
#people make stupid surveys and don't know how to do data collection. Each excel sheet had a bunch of different sheets organized into college of science, business, and engineering. He first took each sheet and assigned it to its own data frame.
#He then took each data frame and changed the sheet name to fit in with where it goes with.
#he then binded all of the data frames into a whole new data frame. 
#he then removed the individual dataframes and kept the bounded one. 
class(df)
View(df)


# Subset this full data frame to include only rows where the answer to the question:
# `Do you anticipate using the lab next semester?` is "No"

df[df$`Do you anticipate using the lab next semester?`=="No",]
dfno = df[df$`Do you anticipate using the lab next semester?`=="No",]
View(dfno)

# What is different between these "No" students and the "Yes" students?


table(df$`Studying in the lab is an efficient use of your limited study time.`)
table(df$`Do you anticipate using the lab next semester?`)
dfno$`Studying in the lab is an efficient use of your limited study time.`
df$`The tutoring lab has contributed to your success in this course.`
?complete.cases
dfno=dfno[complete.cases(dfno),]
library(tidyverse)
df$`The tutoring lab has contributed to your success in this course.`
ggplot(df, aes(x=df$`The tutoring lab has contributed to your success in this course.`, fill= 'Do you anticipate using the lab next semester?')) +
  geom_bar(stat = "count", position = "dodge")
ggplot2::aes()


data("mtcars")
df=mtcars
df
glimpse(df)

plot(df$mpg ~ df$cyl)
plot(df$mpg ~ df$hp)

view(mtcars)

ggplot(df, mapping = aes(x=drat, y=mpg, color=factor(cyl))) +
  geom_point()+
  geom_smooth(method = "lm", se=FALSE) +
  geom_smooth(aes(color=NULL))

ggplot(df, mapping = aes(x=drat, y=mpg, color=factor(cyl))) +
  geom_point(df, mapping = aes(color=factor(cyl))) +
  geom_smooth(aes(color=NULL))


ggplot(df, mapping = aes(x=drat, y=mpg, fill=factor(am))) +
  geom_violin() +
  geom_point(aes(color=factor(vs)))
ggsave("ilovethisfunction.png", dpi = 300, width = 12, height = 10)

safari "ilovethisfunction.png"
