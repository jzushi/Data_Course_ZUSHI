data("mtcars")
str(mtcars)
?mtcars
library(tidyverse)
autos=mtcars %>%
  filter(am == 0) 
write.csv(autos, file = "automatic_mtcars.csv")
library(ggplot2)
ggplot(data = autos, mapping = aes(x= autos$hp, y= autos$mpg, xlab = "Horse Power", ylab = "MPG")) +
  geom_point()

HPplot <- ggplot(autos, aes(hp, mpg)) + geom_point()

print(HPplot + labs(title = "Horse Power vs MPG in Automatic Transmissions", y="MPG", x = "Horse Power"))

png(filename = "./../Assignment_5/mpg_vs_hp_auto.png")
print(HPplot + labs(title = "Horse Power vs MPG in Automatic Transmissions", y="MPG", x = "Horse Power"))
dev.off()

Wtplot <- ggplot(autos, aes(wt, mpg)) + geom_point()
print(Wtplot + labs(title = "Weight vs MPG in Automatic Transmissions", y= "MPG", x= "Weight"))
?tiff

tiff(filename = "./../Assignment_5/mpg_vs_wt_auto.tiff")
print(Wtplot + labs(title = "Weight vs MPG in Automatic Transmissions", y= "MPG", x= "Weight"))
dev.off()

summary(mtcars)

Disp <- subset(mtcars, disp <= 200)

Disp

csv(filename= "./../Assignment_5/mtcars_max200_displ.csv")
Disp <- subset(mtcars, disp <= 200)
dev.off()

write.csv(Disp, "mtcars_max200_displ.csv")

MaxHPoriginal <- max(mtcars$hp)
MaxHPautos <- max(autos$hp)

MaxHP200 <- max(Disp$hp)

MaxHP <- c(MaxHPoriginal, MaxHPautos, MaxHP200)

write.table(MaxHP, file = "hp_maximums.txt", sep = "\t",
            row.names = TRUE, col.names = NA)



