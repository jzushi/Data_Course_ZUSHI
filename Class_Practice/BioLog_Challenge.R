library(tidyverse)
df = read.csv("./Data/BioLog_Plate_Data.csv")

glimpse(df)
?mapvalues
?plyr::mapvalues()

geoff = c("geoff", "goeff", "geoffreey")
plyr::mapvalues(geoff, from = geoff, to = rep("Geoff", 3))

# write a command the subsets the BioLog data to Clear_Creek samples, with dilution of 0.01, and only "Glycogen"
df2=df %>%
  filter(Sample.ID == "Clear_Creek") %>%
  filter(Substrate == "Glycogen") %>%
  filter(Dilution == 0.01) %>%
  gather(key = "Hour", value = "Concentration", 6:8)
  

# Now plot those three replicates over time
hours = c("Hr_24", "Hr_48", "Hr_144")

Hour <- as.numeric(plyr::mapvalues(hours, from = c("Hr_24", "Hr_48", "Hr_144"),
                     to = c(24,48,144)))
Rep = as.factor(df2$Rep)
df2$Rep <- factor(df2$Rep)


hours<- as.numeric(plyr::mapvalues(df2$Hour, from = c("Hr_24", "Hr_48", "Hr_144"),
                to = c(24,48,144)))
df2$Hour <- hours





ggplot(data = df2, mapping = aes(x=Hour, y=df2$Concentration, col=Rep)) +
  geom_point(mapping = aes(color = Rep))

# Make a plot of Tween 80 utilization over time for ALL the samples, colored by Sample.ID

long <- df %>% gather(key = Hour, value = Abs, c("Hr_24", "Hr_48", "Hr_144"))
long$Hour <-as.numeric(plyr::mapvalues(long$Hour, from = c("Hr_24", "Hr_48", "Hr_144"),
                           to = c(24,48,144)))
tween <- long %>% filter(Substrate=="Tween 80 ")

ggplot(data = tween, mapping = aes(x=Hour, y=Abs, col= Sample.ID)) +
  geom_point(mapping = aes(color= Sample.ID))+
  geom_smooth()+
  facet_wrap(~Sample.ID)

# Now, same plot, but combine both soils and both waters into soil and water groups and color by soil vs water
water = tween
water$Sample.ID= plyr::mapvalues(tween$Sample.ID, from = c("Clear_Creek", "Waste_Water", "Soil_1", "Soil_2"), to = c("water","water","soil","soil"))


ggplot(data = water, mapping = aes(x=Hour, y=Abs, col= Sample.ID)) +
  geom_point(mapping = aes(color= Sample.ID))+
  geom_smooth()+
  facet_wrap(~Sample.ID)

# Make a table of summary statistics: for each combination of Sample.ID and Substrate, give:
# -- Number of observations
# -- Mean absorbance value

# Example output ....

# Sample.ID     Substrate                       N Mean
# <fct>         <fct>                       <int> <dbl>
# 1 Clear_Creek 2-Hydroxy Benzoic Acid         27 0.0562
# 2 Clear_Creek 4-Hydroxy Benzoic Acid         27 0.247 
# 3 Clear_Creek D-Cellobiose                   27 0.403 
# 4 Clear_Creek D-Galactonic Acid γ-Lactone    27 0.314 
# 5 Clear_Creek D-Galacturonic Acid            27 0.385 
# 6 Clear_Creek D-Glucosaminic Acid            27 0.154 
# 7 Clear_Creek D.L -α-Glycerol Phosphate      27 0.0335
# 8 Clear_Creek D-Mallic Acid                  27 0.170 
# 9 Clear_Creek D-Mannitol                     27 0.346 
# 10 Clear_Creek D-Xylose                       27 0.0323
# 

stats = long %>%
  group_by(Sample.ID, Substrate)%>%
  summarise(N= n(), Mean= mean(Abs))

        
            

  
  
  
  
 
  
  
  
