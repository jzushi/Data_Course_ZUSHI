# Assignment Week 3




# topics:   type conversions, factors, plot(), making a data frame from "scratch",
#           reordering, 


# vector operations!

vector1 = c(1,2,3,4,5,6,7,8,9,10)
vector2 = c(5,6,7,8,4,3,2,1,3,10)

vector1*vector2



dat = read.csv("../../../Data_Course/Data/thatch_ant.csv")
names(dat)

#why are these plots different???
plot(x=dat$Headwidth..mm., y=dat$Mass)

plot(x=dat$Size.class, y=dat$Mass)


#check the classes of these vectors
class(dat$Headwidth..mm.)
class(dat$Size.class)

# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat)

dat$Headwidth == "41mm"# Two of them are "Factor" ....why is the column "Headwidth" a factor? It looks numeric!

which(dat$Headwidth == "41mm")# we can try to coerce one format into another with a family of functions
dat[which(dat$Headwidth == "41mm"),"Headwidth"] <- "41.000"# as.factor, as.matrix, as.data.frame, as.numeric, as.character, as.POSIXct, etc....
dat[which(dat$Headwidth == "41mm"),"Headwidth"] <- "41.000"
dat[which(dat$Headwidth == "41mm"),"Headwidth"] <- "41.000"
dat[which(dat$Headwidth == ""),"Headwidth"] <- NA
dat$Headwidth = as.numeric(dat$Headwidth)
#make a numeric vector to play with:
nums = c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9)
class(nums) # make sure it's numeric

# convert to a factor
as.factor(nums) # show in console
nums_factor = as.factor(nums) #assign it to a new object as a factor
class(nums_factor) # check it

#check it out
plot(nums) 
plot(nums_factor)
# take note of how numeric vectors and factors behave differently in plot()

# Let's modify and save these plots. Why not!?
?plot()

plot(nums, main = "My Title", xlab = "My axis label", ylab = "My other axis label")


?jpeg()



dev.off()



# back to our ant data...
dat$Headwidth
levels(dat$Headwidth) # levels gives all the "options" of a factor you feed it

# I notice a couple weird ones in there: "" and "41mm"
# The "" means a missing value, basically. The "41mm" sure looks like a data entry error.
                                            # It should probably be "41.000"

# FIND WHICH ONES HAVE "41mm"



# CONVERT THOSE TO "41.000"



# DO THE SAME FOR "", BUT CONVERT THOSE TO "NA"



# NOW, REMOVE ALL THE ROWS OF "dat" THAT HAVE AN "NA" VALUE
na.omit(dat)


# NOW, CONVERT THAT PESKY "Headwidth" COLUMN INTO A NUMERIC VECTOR WITHIN "dat"



# LET'S LEARN HOW TO MAKE A DATA FRAME FROM SCRATCH... WE JUST FEED IT VECTORS WITH NAMES!

# make some vectors *of equal length* (or you can pull these from existing vectors)
col1 = c("hat", "tie", "shoes", "bandana")
col2 = c(1,2,3,4)
col3 = factor(c(1,2,3,4)) # see how we can designate something as a factor             

# here's the data frame command:
data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # colname = vector, colname = vector....

df1 = data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # assign to df1
df1 # look at it...note column names are what we gave it.



# Make a data frame from the first 20 rows of the ant data that only has "Colony" and "Mass"
# save it into an object called "dat3"


str(dat)
col1 = dat$Colony
col2 = c("1-20")
dat3 = data.frame(Colony = dat$Colony, Mass = dat$Mass)
dat3[,"test"]
dat3$Colony
plot(x=dat3$Colony,y=dat3$Mass,col=dat3$Colony)



###### WRITING OUT FILES FROM R #######
write.csv(dat3)



# Write your new object "dat3" to a file named "LASTNAME_first_file.csv" in your PERSONAL git repository
getwd()


# setwd("/Users/jzushi/Desktop/Data_Course_ZUSHI/Assignments/Assignment_3")
write.csv(dat3, file = "ZUSHI_josh_file.csv")


### for loops in R ###

#simplest example:
for(i in 1:10){print(i)}

#another easy one
for(i in levels(dat$Size.class)){
  print(i)
}

# can calculate something for each value of i ...can use to subset to groups of interest
for(i in levels(dat$Size.class)){
  print(mean(dat[dat$Size.class == i,"Mass"]))
}

# more complex:
# define a new vector or data frame outside the for loop first
new_vector = c() # it's empty
# also define a counter
x = 1

for(i in levels(dat$Size.class)){
  new_vector[x] = mean(dat[dat$Size.class == i,"Mass"])
  x = x+1 # add 1 to the counter (this will change the element of new_vector we access each loop)
}
  
#check it
new_vector



# PUT THIS TOGETHER WITH THE LEVELS OF OUR FACTOR SO WE HAVE A NEW DATA FRAME:
# FIRST COLUMN WILL BE THE FACTOR LEVELS....
# SECOND COLUMN WILL BE NAMED "MEAN" AND WILL BE VALUES FROM  new_vector

#fill it in
size_class_mean_mass = data.frame(...)



summary(dat$Colony)
dat$Colony < 3

dat[dat$Colony]
dat[dat$Colony %in% c(1,2),]

dat[dat$Mass >= 100,]

dat[dat$Colony %in% c(1,4,7),]
headwidth_vs_mass= plot(x=dat3$Colony,y=dat3$Mass,col=dat3$Colony)


############ YOUR HOMEWORK ASSIGNMENT ##############

# 1.  Make a scatterplot of headwidth vs mass. See if you can get the points to be colored by "Colony"

str(dat)
dat4 = data.frame(Headwidth = dat$Headwidth..mm., Mass = dat$Mass, Colony = dat$Colony)
dat4$Colony
plot(x=dat4$Headwidth, y=dat4$Mass, col=dat4$Colony)

headwidth_vs_mass= plot(x=dat4$Headwidth, y=dat4$Mass, col=dat4$Colony)

# 2.  Write the code to save it (with meaningful labels) as a jpeg file

jpeg(file= "headwidth_vs_mass.jpeg") #file name and location there are three lines min. for doing a jpeg
plot(dat$Colony) #give it information
dev.off() #turn off plot

sink(file = "test.txt")
dat$Colony
sink(NULL)

getwd()
# 3.  Subset the thatch ant data set to only include ants from colony 1 and colony 2
dat5= dat[dat$Colony %in% c(1,2),]

# 4.  Write code to save this new subset as a .csv file

write.csv(dat5, file = "Colonies_1_and_2.csv")

# 5.  Upload this R script (with all answers filled in and tasks completed) to canvas
      # I should be able to run your R script and get all the plots created and saved, etc.
