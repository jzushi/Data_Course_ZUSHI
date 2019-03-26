library(tidyverse)
df<- read.csv("../../Desktop/Data_Course/Exercises/ugly_data2.csv", stringsAsFactors = FALSE)
names(df)

df1<- df[1:9,]
df2<- df[20:28,]
df1$Gender <- "Male"
df2$Gender <- "Female"

df<- full_join(df1,df2)

df<- gather(df,AgeGroup,Count,2:5) 

df$AgeGroup = str_remove(df$AgeGroup, "m")
df$AgeGroup = str_remove(df$AgeGroup, "f")

age1 = str_sub(df$AgeGroup,1,2)
age2 = str_sub(df$AgeGroup,3,4)
df$AgeGroup = paste(age1, "-", age2)
library(readr)
write.csv(df, "../../Desktop/Data_Course_ZUSHI/Class_Practice/ugly_data2_cleaned.csv", row.names= FALSE, quote= FALSE)

