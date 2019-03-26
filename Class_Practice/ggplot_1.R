# load packages
library(tidyverse)
library(wesanderson)


# load data
data(mtcars)
df = mtcars

# clean data
df$am = factor(df$am)

# custom palette
pal = c("#41711f", "#fff838") #google color picker and copy the code they gve you 


# initial plot
p1 = ggplot(df, aes(x=hp, y=mpg, color=am)) +
  geom_point(size=15,alpha=.5)
p1

p1 = p1 + labs(title = "MPG vs HP", x="Horsepower", y="Miles per Gallon", color="Auto/Man")

p1 + scale_color_discrete(labels = c("Auto", "Man")) +
  scale_color_manual(values = pal) #this allows you to choose the colors you want to use
#it changed our labels so we switched the code to all be in this. 


p1 = p1 + scale_color_manual(labels = c("Auto", "Man"), values = pal) 

#reviewer 2 wants your soul


p2 = p1 + scale_color_manual(labels = c("Auto", "Man"), values = pal) +
  theme(plot.title = element_text(face = "italic",hjust = .5),
        panel.background = element_rect(fill = "Black"),
        axis.ticks = element_line(color = NULL),
        panel.grid = element_line(color = "Black"),
        legend.background = element_rect(fill = "Black"),
        legend.key = element_rect(fill = "Red",color = "Black"),
        legend.text = element_text(color = "White"),
        legend.title = element_text(color = "White"))

#italicise the legend except per
p2 + labs(x=expression(~italic(Horsepower)), y=expression(~italic(Miles)~ 'per' ~italic(Gallon)))


p3 = ggplot(df, aes(x=am,y=mpg))

p3 + geom_boxplot()
p3 + geom_violin() + geom_point(alpha=.5)

# Zahn used the data from salaries that I don't have here
# ggplot(long, aes(x=Rank, y=Salary, fill=Tier, color=Tier)) +
#   geom_boxplot() + geom_point(alpha=.5, position = "jitter") +
# scale_color_manual(values = wesanderson::wes_palette(3)) +
# scale_fill_manual(values = wesanderson::wes_palette(3))


devtools::install_github("wilkelab/cowplot")
install.packages("colorspace", repos = "http://R-Forge.R-project.org")











