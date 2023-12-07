# training set
# claster is a set of individual objects having same characteristics - for ex. agricultural areas, forests, or water (like groups)
# no classed pixel in the image - how to classify it? - use smallest distance from nearest class - blue very close on the graph(water), smallest distance
# this pixel is attained (most probable to be related) to that class 
# based on distance you can classify any pixel - first assign clasters 
#### method that we are using to clasify pixels

##### Procedure for classifying remote sensing data
# Classifying satellite images and estimate the amount of change of different classes

library(terra)
library(imageRy)       # in imagery there is a function im.list()

im.list()              # lists all the images we can use 

# file related to the sun - last one - areas of Sun with peculiarly high energy
# im import to bring that picture
# assign the name 
# using 3 bands 
# gases of the sun visible - based on colors 3 levels of energy - high yellow, middle - brownish, lower energy - black

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# explain software number of clasters only
sunc <- im.classify(sun , num_clusters=3)       # sun classified (sunc) - function is im.classify(image, number of clusters)
plot(sunc)                                      # need new version of imageRy - plots same graph 3 times
                                                # white is highest energy - classes change when plotted again

#classify satellite data 

im.list()

# Import the data
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")


# Classification of 1992
m1992c <- im.classify(m1992, num_clusters=2)
plot(m1992c)           

# classes of 1992:
# class 1: forest (white)
# class 2: agricultural area (green)
# this can be different 

#classification of second image - 2006

m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)

# classes of 2006:
# class 1: agricultural areas
# class 2: forest
# how things change with time - way more agricultural areas 

# plot together - doesn't work because we get 3 images - reinstall imageRy
par(mfrow=c(1,2))
plot(m1992c)
plot(m2006c)

# only select first element for it to work
par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

# calculating frequency of pixels of certain class (freq)
# 1992
f1992 <- freq(m1992c)
f1992                     # we get table of frequencies

# 2006  
f2006 <- freq(m2006c)
f2006

# percentages
tot1992 = ncell(m1992)    # ncel calculating number of pixels in image
#1800000                  # total number of pixels
perc1992 = f1992 * 100 / tot1992     # frequency of 1992 * 100 divided by total number of pixels
perc1992                  # look under count  
                          # 1992: forest = 83.08%, agriculture = 16.91%

tot2006 = ncell(m2006)    # frequency of the image of 2006 
# 7200000
perc2006 = f2006 * 100 / tot2006
perc2006                  # 2006: forest = 45.31%, agriculture = 54.69%


# we want to make a graph out of this - but first make a table 
# building the output table
# final table
class <- c("forest", "human")
p1992 <- c(83.08, 16.91)
p2006 <- c(45.31, 54.69)

# now build data frame 
tabout <- data.frame(class, p1992, p2006)        # 3 columns 
tabout

### tabout - final data frame 
#   class p1992 p2006
# 1 forest 83.08 45.31
# 2  human 16.91 54.69


# now we will make final plot
library(ggplot2)
# ggplot function, aes (x = class, y= column related to year, color = related to class)
# bars = histograms, can be related to statistics, stats = identity, we use direct values, filling it with white but can be any color

# final plot
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1+p2

# rather then using continuous data we classified it to 2 and plotted it

# final plot - rescaled
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2
