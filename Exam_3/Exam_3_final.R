# Skills Test 3

# Below are two data sets. Using these data, re-create the two plots in the exam_3 directory.
# Use ggplot
# export (using code) these two plots into your exam_3 directory. 
# They should be saved as .png files at 300 dpi with a width of 5 inches and height of 5 inches
# Naming convention should be LASTNAME_plot1.png and LASTNAME_plot2.png
# Push your R script and the two image files to GitHub.

# Load packages
library(tidyverse)
library(gapminder)

# creating a color palette for plot 1
pal = c("#6b5456","#ec8d1b","#6abf2a","#8b53b7","#70acbe","#01c95b","#c00014","#31332f","#f7d000","#abba00")

# generate data for plot 1
plot1.data = gapminder


# Make and export plot 1
# your code for plot1 goes here #
p1 = ggplot(plot1.data, aes(x = year, y = lifeExp, color = continent)) +
  geom_point(alpha = 0.5) + 
  scale_color_manual(values = pal) + 
  geom_smooth(se = FALSE)

p1 = p1 + labs(title = "Life Expectancy Over Time", subtitle = "Colored by Continent", x="Year", y="Life Expectancy", color="Continent")

p1 + 
  theme(panel.border = element_blank(),
        legend.background = element_rect(fill = "White"),
        legend.key = element_rect(fill = "White",color = "White")) +
  theme_bw() + 
  theme(axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        panel.border = element_blank())


ggsave("../Exam_3/ZUSHI_plot1.png", dpi = 300, width = 5, height = 5)

?element_line
# Generate data for plot 2 (run the following 5 lines only once to ensure we are all using identical data)
set.seed(123)
a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
plot2.data <- rbind(a,b,c)

# make and export plot2
# your code for plot2 goes here #
ggplot(plot2.data, aes(x=x, y=y) ) +
  geom_bin2d() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  theme_bw() + 
  theme(panel.border = element_blank(), 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())


ggsave("../Exam_3/ZUSHI_plot2.png", dpi = 300, width = 5, height = 5)
