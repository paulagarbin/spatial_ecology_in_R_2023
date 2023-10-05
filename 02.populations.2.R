# Code related to population ecology 

# A package is needed for point pattern analysis 
# install from outside source 
# To install package from CRAN we need to exit R and use "" 
install.packages ("spatstat")
library(spatstat)

#lets use the bei data:
#data description: link
bei
plot(bei)

#points are too big so we need to change dimensions 
#changing dimension - cex
plot(bei, cex=0.5)   #decreasing by 0.5
plot(bei, cex=0.2)

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
