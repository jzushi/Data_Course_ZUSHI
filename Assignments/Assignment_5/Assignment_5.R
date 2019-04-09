# Load packages
library(tidyverse)
library(ggplot2)

# 1. Load in data
data("mtcars")
str(mtcars)
?mtcars

# 2. Subset for automatic transmissions only 
autos=mtcars %>%
  filter(am == 0) 


# 3. Save as a new file in Assignment_5 directory
write.csv(autos, file = "./../Assignment_5/automatic_mtcars.csv")


# 4. Plot of HP vs MPG
ggplot(data = autos, mapping = aes(x= autos$hp, y= autos$mpg, xlab = "Horse Power", ylab = "MPG")) +
  geom_point()

# 5. Save this plot as a png

HPplot <- ggplot(autos, aes(hp, mpg)) + geom_point()

print(HPplot + labs(title = "Horse Power vs MPG in Automatic Transmissions", y="MPG", x = "Horse Power"))

png(filename = "./../Assignment_5/mpg_vs_hp_auto.png")
print(HPplot + labs(title = "Horse Power vs MPG in Automatic Transmissions", y="MPG", x = "Horse Power"))
dev.off()


# 6. Plots wt vs mpg
Wtplot <- ggplot(autos, aes(wt, mpg)) + geom_point()
print(Wtplot + labs(title = "Weight vs MPG in Automatic Transmissions", y= "MPG", x= "Weight"))

# 7. Save as a tiff
tiff(filename = "./../Assignment_5/mpg_vs_wt_auto.tiff")
print(Wtplot + labs(title = "Weight vs MPG in Automatic Transmissions", y= "MPG", x= "Weight"))
dev.off()


# 8. Subset displacements less than or equal to 200
summary(mtcars)

Disp <- subset(mtcars, disp <= 200)

Disp

# 9. Save as csv
csv(filename= "./../Assignment_5/mtcars_max200_displ.csv")
Disp <- subset(mtcars, disp <= 200)
dev.off()

write.csv(Disp, "mtcars_max200_displ.csv")

# 10. Calculate the max HP for each of the dataframes 
MaxHPoriginal <- max(mtcars$hp)
MaxHPautos <- max(autos$hp)
MaxHP200 <- max(Disp$hp)

# 11. Prints the calculations in readable format
MaxHP <- c(MaxHPoriginal, MaxHPautos, MaxHP200)

HPRows <- make.names(c("MaxHPoriginal", "MaxHPautos", "MaxHP200"), unique = TRUE)
# HPCol <- make.names(c("Data_frame", "MaxHP"), unique = TRUE)
write.table(MaxHP, file = "hp_maximums.txt", sep = "\t", 
            row.names = HPRows, col.names = as.character("Data_Frame_and_HP"))


