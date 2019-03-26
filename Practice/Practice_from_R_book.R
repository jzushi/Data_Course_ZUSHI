#install packages use install.package() add a c() to bind multiple packages


install.packages(c("nycflights13", "gapminder", "Lahman")) 

#just simple math practice
1+2

#If an error message isn't in English use this
Sys.setenv(LANGUAGE = "en")

#error messages try using stackoverflow.com and add [R] to restrict it to only R
# to make a reproducible example (reprex) make sure that you include packages at the top of the script. Include data in a question use dput() like recreate from mtcars
#1. run dput(mtcars)
#2. copy the output
#3. In reproducible script, type mtcars<- then paste


#Ch. 1 Data Visualization with ggplot2
library(tidyverse)
library(ggplot2)
ggplot2::mpg
?mpg
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))
#ggolot() creates a coordinate system to add layers to. 
#first argument of ggplot() is the dataset to use the graph   so basically add a dataset
#then you add geo,_point() which adds a layer of points to plot and creates a scatter plot. 
#include a mapping argument mapping = aes(x=, y=) to specify which variables to map the axes.


#reusable template for making graphs with ggplot2
#ggplot(data = <DATA>) +
  #<GEOM_FUNCTION>(mapping + aes(<MAPPINGS>))


#Exercises

ggplot2:: mpg
# I see a table 
summary(ggplot2::mpg)
#234 rows and 11 collumns 
?mpg
#it is telling us if it is front wheel drive, rear wheel drive, or 4wd

ggplot(data = mpg)+
  geom_point(mapping = aes(x=class, y=drv))
#it isn't showing very useful things




#Aesthetic Mappings
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy, color=class))

#sucks because mapping an unordered variable to an ordered asethetic is not a good idea. 
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy, size=class))

#sucks but alpha controls the transparency of the points
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy, alpha=class))


#sucks but shape controls the shape of the points
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy, shape=class))

#ggplot2 doesnt create a legend but uses an axis line as a legend isntead
# we can change all the points to a specific color too. 
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y=hwy), color="blue")

#Set an aesthetic manually, set the aesthetic by name as an argument for your geom function, it goes outside of aes().
#name of a color as a character string ""
#size of a point in mm
#shape of a point as a number(R has 25 built-in shapes identified by numbers so google that ish if you wanna.)



#Exercises
ggplot(data = mpg)+
  geom_point(
    mapping = aes(x=displ, y=hwy, color = "blue"
  )

#need to get rid of the space and tab from mapping, and add a () to separate the x and y
ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y= hwy), color = "blue")

?mpg
#categorical: trans, drv, fl, class, manufacturer, model
#continuous: displ, year, cyl cty, 

ggplot(data =mpg)+
  geom_point(mapping = aes(x=year, y=cty), color="blue")

ggplot(data =mpg)+
  geom_point(mapping = aes(x=year, y=cyl), color="blue")
ggplot(data =mpg)+
  geom_point(mapping = aes(x=manufacturer, y=cty), color="blue")
#cantinuous doesn't show much while categorical is similar but plotting against each other shows the most info.

#mltiple aesthetics just add more layers to it.

?geom_point


ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y= hwy), color = "blue", stroke= 1.0)
#stroke lets you change the size of the dots

ggplot(data = mpg)+
  geom_point(mapping = aes(x= displ, y= hwy, color=displ <5))
# It changes the color for anything less than 5





ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~class, nrow=2)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_grid(drv~cyl)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_grid(.~cyl)

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_grid(drv~trans)
#It splits the graphs



ggplot(data=mpg)+
  geom_point(mapping = aes(x=drv, y=cyl))+
  facet_grid(drv~cyl)
#empty cells mean that there aren't cars with that drive and cylinder

ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_grid(drv~.)
# graph with a grid of drive as a function of nothing
ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_grid(.~cyl)

#a graph with a grid of nothing as a function of cylinder


ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~class, nrow = 2)
#you can make multiple graphs to show all of the info. It might make it easier to see alone but harder to compare. Larger data may make it easier if there is a lot but it depends on what you are graphing against
?facet_wrap
#nrow returns the number of columns or rows by x. ncol does the same thing. They treat them as vectors.

#facet_grid() put the variable with more unique levels in the columns so that they can plot easier. 




ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, linetype=drv))

?geom_smooth

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy))


ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy, group=drv))

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x=displ, y=hwy),
    show.legend = FALSE
  )


ggplot(data=mpg)  +
  geom_point(mapping=aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point() +
  geom_smooth()


ggplot(data = mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color=class)) +
  geom_smooth()

ggplot(data = mpg, mapping=aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color=class)) +
  geom_smooth(
    data = filter(mpg, class=="subcompact"),
    se=FALSE
  )


#Exercises

#geom_abline
#geom_boxplot
#geom_histogram
#geom_area

ggplot(
  data = mpg,
  mapping = aes(x=displ, y=hwy, color=drv)
)+
  geom_point()+
  geom_smooth(se=FALSE)

#it gets rid of the legend, just if you don't want it there
#se shows display confidence and FALSE removes it

ggplot(data = mpg, mapping = aes(x= displ, y=hwy))+
  geom_point()+
  geom_smooth()

ggplot()+
  geom_point(
    data = mpg,
    mapping = aes(x=displ, y=hwy)
  ) +
  geom_smooth(
    data = mpg,
    mapping = aes(x=displ, y=hwy)
  )
#They'll look the same
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point()+
  geom_smooth(se=FALSE)
 
ggplot(data = mpg, mapping = aes(x=displ, y=hwy, group=drv)) +
  geom_point()+
  geom_smooth(se=FALSE)

ggplot(data = mpg, mapping = aes(x=displ, y=hwy, group=drv, color= drv)) +
  geom_point()+
  geom_smooth(se=FALSE)
  
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping = aes(color= drv))+
  geom_smooth(se=FALSE) 

ggplot(data = mpg, mapping = aes(x=displ, y=hwy, class=drv)) +
  geom_point(mapping = aes(color= drv)) +
  geom_smooth(aes(linetype=drv))


ggplot(data = mpg, mapping = aes(x=displ, y=hwy, class=drv)) +
  geom_point(mapping = aes(color= drv))



#Statistical Transformations
ggplot(data = diamonds) +
  geom_bar(aes(x=cut))

ggplot(data = diamonds) +
  stat_count(aes(x=cut))

demo = tribble(
  ~a,     ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)

ggplot(data = demo) +
  geom_bar(
    mapping = aes(x=a, y=b), stat = "identity"
  )
  
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x=cut, y=..prop.., group = 1)
  )
  
 ggplot(data = diamonds) +
   stat_summary(
     mapping = aes(x=cut, y=depth),
     fun.ymin = min,
     fun.ymax = max,
     fun.y = median
   )
  
  # Exercises
 # 1. the default geom associated with stat_summary() is geom_stat count. geom_bar(stat = "identity")
 # 2. What does geom_col() do and how is it different from geom_bar()?
 # geom_cbar() Makes the height of the bar proportional to the number of cases in each group.
 # geom_col() makes the heights of the bars represent values in the data
 # 3. Read it
 # 4. What variables does stat_smooth() compute? What parameters control its behavior?
# y, ymin, ymax, se. Method, formula, na.rm
 # 5. you have to include group or else it will make them all the same height
 ggplot(data = diamonds) +
   geom_bar(aes(x=cut,y=..prop.., group = 1))

 ggplot(data = diamonds) +
   geom_bar(
     aes(x=cut, fill=color, y = ..prop.., group = 1)
   )
 
 
 
 #Position Adjustments
 ggplot(data = diamonds) +
   geom_bar(aes(x= cut, color = cut))
 
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill=cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill=clarity))

ggplot(
  data = diamonds,
  mapping = aes(x=cut, fill=clarity)
) +
  geom_bar(alpha=1/5, position = "identity")
 
 
 ggplot(
   data = diamonds,
   mapping = aes(x=cut, color=clarity)
 )+
   geom_bar(fill=NA, position="identity")
 
 
 ggplot(data = diamonds) +
   geom_bar(
     mapping = aes(x=cut, fill=clarity),
     position = "fill"
 )
 
 ggplot(data = diamonds) +
   geom_bar(
     mapping = aes(x=cut, fill=clarity),
     position = "dodge"
   )
 
 
 ggplot(data = mpg) +
   geom_point(
     mapping = aes(x=displ, y=hwy),
     position = "jitter"
   )
 
 # Exercises
 ggplot(data = mpg, mapping = aes(x=cty,y=hwy)) +
   geom_point()
 # overlapping. adding jitter
 ggplot(data = mpg) +
   geom_point( 
     mapping = aes(x=cty, y=hwy),
     position = "jitter"
   )
    
# width and height
 #jitter is random, count makes bigger the htings taht are more common
 # dodge2 
 ggplot(data = mpg, aes(x = drv, y = hwy, colour = class)) +
   geom_boxplot(position = "identity")
 
 
 # Coordinate Systems
 
 ggplot(data = mpg, aes(x = class, y = hwy)) +
   geom_boxplot()
 
 
 ggplot(data = mpg, aes(x = class, y = hwy)) +
   geom_boxplot() +
   coord_flip()
 ## coord_flip() switches x and y axes for horizontal boxplots or long labels that overlap
 library(maps)
 nz <- map_data("nz")


ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "Black")
 
 
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "Black") +
  coord_quickmap()
  
## coord_quickmap() is supposed to set the aspect ratio correctly for maps



bar <- ggplot(data = diamonds) +
  geom_bar(
    aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()

bar + coord_polar()
## coord_polar() uses polar coordinates helps with bar charg and a coxcomb chart (pie chart)



# Excercises
# 1. Use a bar chart + coord_polar() to make a pie chart
# 2. labs() lets you name you labels in you chart
# 3. coord_map projects a portion of the earth, which is approximately spherical, onto a flat 2D plane using any projection defined by the mapproj package. Map projections do not, in general, preserve straight lines, so this requires considerable computation. coord_quickmap is a quick approximation that does preserve straight lines. It works best for smaller areas closer to the equator.
# 4. They are both linear, the more city you get the more highway you get. coord_fixed gives an absolute ratio for the x and y axis making sure that they are all the same length. geom_abline plots a line with an intercept of 0 and a slope of 1
ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() +
  coord_fixed() 

# Layered Grammar of Graphics
## template for ggplot
ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(
    aes(<MAPPINGS>),
    stat = <STAT>,
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>

#########################

# Coding Basics

## as a calculator 
1/200 * 30
(59 + 73 + 2) /3
sin(pi / 2)

## creating new objects with <-
x <- 3 * 4

object_name <- value
# "object name gets value"
## alt - makes <- !!!! lol 


x


this_is_a_really_long_name <- 3.5
this_is_a_really_long_name

r_rocks <- 2 ^ 3
r_rocks


# CALLING FUNCTIONS #
function_name(arg1 = val1, arg2 = val2, ...)
seq(1,10)
x <- "hello world"
(y <- seq(1,10, length.out = 5))

# Exercises
# 1. it isn't spelt correctly
# 2. 
library(tidyverse)
ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy))
filter(mpg, cyl == 8)
filter(diamonds, carat > 3)

# 3. alt-shift-k shows all shortcuts 



### DATA TRANSFORMATION WITH dplyr ###
library(nycflights13)
library(tidyverse)
flights
## the Five Key dplyr functions ##
# 1. pick observations by their values (filter())
# 2. reorder the rows (arrange())
# 3. pick variables by their names (select())
# 4. create new variables with functions of existing variables (mutate())
# 5. collapse many values down to a single summary (summarize())
# 6. group_by() changes the scope of each function from operating on the entire dataset to operating on it group-by-group
# filter() subset observations based on their values

jan1 <- filter(flights, month == 1, day ==1)

# to print and save...
(dec25 <- filter(flights, month == 12, day == 25))

# boolean operators: & == and, | == or, ! == not
filter(flights, month == 11 | month == 12)

# x %in% y selects every row where x is one of the values in y
nov_dec <- filter(flights, month %in% c(11,12))

filter(flights, !(arr_delay >120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

# use is.na() for missing values

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1)
filter(df, is.na(x) | x > 1)

## Exercises

# Find flights that:
# Arrival delay of 2+ hours
filter(flights, arr_delay >= 120)
# flew to houston (IAH or HOU)
filter(flights, dest == "IAH" | dest == "HOU")
# were operated by united, american, or delta
filter(flights, carrier == "UA"| carrier == "AA"| carrier == "DL")
# departed in summer (July, august, september)
filter(flights, month == 7 | month == 8 | month == 9)
# arrived more than two hours late, but didn't leave late
filter(flights, arr_delay >= 120, dep_delay <= 0)
# were delayed by at least an hour, but made up over 30 min in flight
filter(flights, arr_delay <= 30, dep_delay >= 60)
# Departed between midnight and 0600
filter(flights, dep_time %in% c(0:600))
# easier in dplyr
filter(flights, between(dep_time, 0,600))
# How many flights are missing dep_time? What else is missing and why
filter(flights, dep_time == "NA")
summary(flights$dep_time == "NA")
# 8255
summary(flights)
# bunch of stuff but they never took off
#  Why is `NA ^ 0` not missing? Why is `NA | TRUE` not missing? Why is `FALSE & NA` not missing? Can you figure out the general rule?  (`NA * 0` is a tricky counterexample!)
# `NA ^ 0` evaluates to 1 because anything to the power of 0 is 1, so although we didn't know the original value, we know it's being taken to the zeroth power. 
# 
# With `NA | TRUE`, since the `|` operator returns `TRUE` if either of the terms are true, the whole expression returns true because the right half returns true. This is easier to see in an expression like `NA | 5<10` (since 5 is indeed less than 10).
# 
# For the next example, we know that `&` returns TRUE when both terms are true. So, for example, `TRUE & TRUE` evaluates to `TRUE`. In `FALSE & NA`, one of the terms is false, so the expression evaluates to `FALSE`. As does something like `FALSE & TRUE`.
# 
# `NA * 0` could be argued to be because the NA could represent `Inf`, and `Inf * 0` is `NaN` (Not a Number), rather than `NA`. However, I suspect that these results are dictated as much by what answer is natural, quick and sensible in C as by mathematical edge cases.
# 



## Arrange Rows with arrange()


