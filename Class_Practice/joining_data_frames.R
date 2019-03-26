library(tidyverse)

# here are two data frames
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

df1
df2

# join them together #merges two data frames together
full_join(df1,df2, by="CustomerId") 
?full_join #return all rows and all cols from x and y. No matching values it will put "NA" for missing
left_join(df1,df2, by="CustomerId") #removes values from R that don't match data, creates new rows to match with multiples
#Return all rows from x and all cols from x and y. Rows in x that don't match in y will have "NA", multiple matches all combo of matches are turned
right_join(df1,df2, by="CustomerId")#removes values from L that don't match
#Return all rows from y and all cols from x and y. Rows in y with no match in x will have "NA",multiple matches all combo of matches are turned
inner_join(df1,df2, by="CustomerId")
#Return all rows from x where matches in y and cols from x and y. 
semi_join(df1,df2, by="CustomerId")#gets rid of redundencies this is awesome for data
#Return all rows from x where there are matching values in y. 
anti_join(df1,df2, by="CustomerId") #Comparing L from R and only saving things that don't match the R and keep the L

fully_anti_join = function(x,y,name){
anti= anti_join(df1,df2, by="CustomerId")
anti2= anti_join(df2,df1, by="CustomerId")
full_join(anti,anti2)
}

fully_anti_join(df1,df2,"CustomerId")






gather()

utah = read.csv("./Data/Utah_Religions_by_County.csv")
view(utah)
#How to store data TIDY:
#Row = observation, col = single variable, element = value, to get it to be rectangle (want in long format not wide )
#obs is columns, variables is rows

?gather()
utah.long= gather(utah, key = "Religion", value = "Proportion", -c(1:4))

utah.long$County = factor(str_remove(utah.long$County, " County"))

ggplot(utah.long, aes(x=County, y=Proportion, color=Religion)) +
  geom_boxplot() + coord_flip()


ggplot(utah.long, aes(x=County, y=Proportion, color=Religion)) +
  geom_boxplot() + coord_flip()

ggplot(utah.long, aes(x=County, y=Proportion, color=Religion)) +
  geom_boxplot() + facet_wrap(~County) + coord_flip()

ggplot(utah.long)+
  geom_boxplot(mapping = aes(x=County, y=Proportion, color=Religion)) + facet_wrap(~County) + coord_flip()
?ggplot










