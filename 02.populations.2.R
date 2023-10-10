# Code related to population ecology 

# A package is needed for point pattern analysis 
# install from outside source 
# To install package from CRAN we need to exit R and use "" 
install.packages ("spatstat")
library(spatstat)

#lets use the bei data:
#data description: link - that is how we link our data to the code
bei            # huge amount of data 
plot(bei)      # huge data points, we need to sort that 

#points are too big so we need to change dimensions 
#changing dimension - cex
plot(bei, cex=0.5)   #decreasing by 0.5
plot(bei, cex=0.2)   # all points are trees in the landscape 
                     # from this we can create density map

#changing the symbol - pch (19 is filled points)
plot (bei, cex=0.2, pch=19)

#additional datasets 
bei.extra
plot(bei.extra)   # two maps - raster file
                  #one is elevation, and one is called grad
                  # we only need elevation, so only one element of the dataset

#let's use only part of the dataset: elev
bei.extra$elev         #linking elevation to the dataset 
plot(bei.extra$elev)   #it will plot only elevation
# $ is linking just elevation to the dataset

elevation <- bei.extra$elev
plot(elevation)

bei.extra   #elevation was the first element among the two

#second method to select elements 
elevation2 <- bei.extra [[1]] #selecting first element and assign it to a variable
plot(elevation2)


#### density map 
# passing from points to a continuous surface 
#density is a function in spatstat dataset
densitymap <- density(bei)     # from points before (bei) now we are dealing with pixels  

plot (densitymap)   # we get density of trees over the area in coloured image 

# let's put points on top of the image 
# points function is adding on top of something (image)

points(bei, cex=.2)

# let's change colour since it is not good to have red blue and green in the same map for daltonic people 
colorRampPalette (c("black", "red", "orange", "yellow")(100)    # R and P are capital sensitive 
                  
# colours stored in " " 
# c is a function to merge colours together and use them all
# 100 is number of colours passing from black to red to orange etc...

cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(100) 
plot(densitymap, col=cl)
                   
