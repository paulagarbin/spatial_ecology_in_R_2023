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

#-----

im.list()

# Import the data
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Classification of 1992
m1992c <- im.classify(m1992, num_clusters=2)

# classes of 1992:
# class 1: agricultural areas
# class 2: forest

#2006

m2006c <- im.classify(m2006, num_clusters=2)

# classes of 2006:
# class 1: agricultural areas
# class 2: forest

# final estimates
# 1992
freq1992 <- freq(m1992c)
freq1992

# 2006
freq2006 <- freq(m2006c)
freq2006

# percentages
tot1992 = ncell(m1992)
perc1992 = freq1992 * 100 / tot1992
perc1992

# 1992: forest = 83.08%, agriculture = 16.91%

tot2006 = ncell(m2006)
perc2006 = freq2006 * 100 / tot2006
perc2006

# 2006: forest = 45.31%, agriculture = 54.69%

# building the output table
cover <- c("forest", "agriculture") 
perc1992 <- c(83.08, 16.91)
perc2006 <- c(45.31, 54.69)

# final table
p <- data.frame(cover, perc1992, perc2006)
p

# final plot
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white"))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white"))
p1+p2

# final plot - rescaled
p1 <- ggplot(p, aes(x=cover, y=perc1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(p, aes(x=cover, y=perc2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2
