# RS data

library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")  # from devtools

library(imageRy)
library(terra)
# in case you have not terra
# install.packages("terra")

# list the data
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif") 

cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(b2, col=cl)

# import the green band from Sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=cl)

# import the red band from Sentinel-2 (band 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=cl)

# import the NIR band from Sentinel-2 (band 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=cl)

# multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stack images
stacksent <- c(b2, b3, b4, b8)
dev.off() # it closes devices
plot(stacksent, col=cl)

plot(stacksent[[4]], col=cl)

# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)

dev.off () # closes the device, clears the workspace in R

# RGB space
# stacksent: 
# band2 blue element 1, stacksent[[1]] 
# band3 green element 2, stacksent[[2]]
# band4 red element 3, stacksent[[3]]
# band8 nir element 4, stacksent[[4]]

im.plotRGB(stacksent, r=3, g=2, b=1)           # red band is number 3, blue is number 1, green is 2 
im.plotRGB (stacksent, r=4, g=3, b=2)          # infrared - dark red part is broad leaf forest, light red is pasture - everyhing red is vegetation (red band above others)
                                               # you can discriminate between vegetation and water for example would be coloured black
                                               # possible to see additional things 
im.plotRGB (stacksent, r=3, g=4, b=2)          # changing the green above the red - everything that is becoming green is vegetation
                                               # white and violet is bare soils, rocks, urban sites, roads, etc. - it is not water 
                                               # now we can se what we didnt see in red band = 4 and that is the fact it is not water on the image - it is white - bare rock
im.plotRGB (stacksent, r=3, g=2, b=4)          # now everything reflecting in infrared is becoming blue
                                               # all vegetation is blue, soil is yellow-ish, cities are in yellow (useful for urban areas) 


# How much bands are correlated to each other? - we want to see that
?pairs 
# if you have 20 bands - you want to find correlation 20*19
# 4 bands here which is 4*3  (12 correlations to measure correlation between each one of them with each one)
# half of that are the distances - here there are 6 distances for 4 bands

pairs(stacksent)          # wait for it - plotting many data 
                          # graphs - Piersons correlation coefficients (ranging from -1 to 1) 
                          # green graphs are visible bands (green, blue, infra-red, near infra red)
                          # graphs bringing more or less same information 
                          # all bands correlated (positively) to each other - all between 0.7 and 1.00 
                          # values of reflectance in integer - black scatter plots 
                          # first column blue band 
                          # histogram - representing frequency of every value of reflectance - in blue band several pixels with
                          # smaller reflectance and small amount with higher reflectance 


##### DIFFERENCE VEGETATION INDEX (DVI)
# INDEX is a single layer 
# difference since its a difference between layers
# you can look at change over time - repeat process after some time and see the change 

# healthy tree (plant)
# healthy leaves - near infra red - highly reflectance
# healthy leaves - absorb infra red - low reflectance 
# lets compare them 
# high value in near infra red - up to 100 (1-100 is reflectance)
# low value in infra red since it is absorbed - around 20
# take near infra red value (high one) minus the infra red information 
# 100-20 = 80 - difference 

# tree in suffering
# in another place tree is suffering - drought 
# reflectance in near infra red is lower - 60 
# in this case tree is suffering so its capability of photosynthesis is lower - higher reflectance in red (lower absorption) 
# infra red - 50 
# 60 - 50 = 10 is the difference 

# we can look at the same bands over the same period 
# how earthy is the vegetaiton - look at the same difference at same place 
# if DVI is going from 80 to 10 - forest is getting destroyed - important to ACT or STOP the activity 




                          


