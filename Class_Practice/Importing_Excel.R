library(readxl)
df1 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 1)
df2 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 2)
df3 = read_xlsx("./Data/Student_Survey_Fall_2017.xlsx", sheet = 3)

df1$Sheet <- "COS"
df2$Sheet <- "BUS" #make a collumn of each one of these need to do before so know which row goes to where
df3$Sheet <- "ENG"

df = rbind(df1,df2,df3) #sticks all together via rows

class(df)

rm(df1,df2,df3)
# What have I done here? Already made them into one data frame so just clearing it out
View(df) #when making a survey, USE A DROP DOWN OPTION TO PREVENT MISSSPELLING and stupid stuff


# Subset this full data frame to include only rows where the answer to the question:
# `Do you anticipate using the lab next semester?` is "No"



df[df$`Do you anticipate using the lab next semester?` == "No",]
dfno=df[df$`Do you anticipate using the lab next semester?` == "No",]
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
ggplot(df, aes(x=df$`The tutoring lab has contributed to your success in this course.`, fill = `Do you anticipate using the lab next semester?`  )) + geom_bar(stat = "count", position = "dodge")
ggplot2::aes()



data("mtcars")
df = mtcars
df

?mtcars
glimpse(df)


plot(df$mpg ~ df$cyl)

plot(df$mpg ~ df$hp)

view(mtcars)


#+ is baically saying and... so without adding a + it won't add any points/graph/whatever we want(also to this plot add...)

ggplot(df, mapping = aes(x=drat, y=mpg, color=factor(cyl))) + 
  geom_point() +
  geom_smooth(method = "lm", se=FALSE) +
  geom_smooth(aes(color=NULL))

ggplot(df, mapping = aes(x=drat, y=mpg)) + 
  geom_point(df, mapping=aes(color=factor(cyl))) +
  geom_smooth(method = "lm", se=FALSE) 
  

ggplot(df, mapping = aes(x=factor(cyl), y=mpg, fill=factor(am), color=factor(am))) +
  geom_violin() +
  geom_point(aes(color=factor(vs)))
ggsave("ilovethisfunction.png", dpi = 300, width = 12, height = 10)





firefox "ilovethisfunction.png" #terminal to firefox


#+ is baically saying and... so without adding a + it won't add any points/graph/whatever we want(also to this plot add...)



