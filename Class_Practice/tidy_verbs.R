# The tidy verbs
library(tidyverse)

data(iris)
df=iris

#Average sepal length for each species of iris
df2= df %>%
  group_by(Species) %>%
  summarise(MeanSepalLength = mean(Sepal.Length), 
            N=n(),
            SDevSepalLength= sd(Sepal.Length),
            Min= min(Sepal.Length),
            Max= max(Sepal.Length)) %>%
  as.data.frame("data.frame")

df %>%
  select(starts_with("S"))
df %>%
  select(one_of(c("Petal.Length", "Sepal.Roundness")))

select(df, contains)

            


?mutate() # adds new variables that are functions of existing variables
?select() # picks variables based on their names.
?filter() # picks cases based on their values.
?summarise() # reduces multiple values down to a single summary.
?arrange() # changes the ordering of the rows.
?group_by() # allows you to perform any operation “by group”.

%>% # pipe!


