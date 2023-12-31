# Indices derived from RS imagery
#vegetation indices 

library(imageRy) # package developed at unibo
library(terra)

# library(ggplot2) (for Thursday)
# library(viridis)

im.list()

# we will use matogrosso_l5...

##### If we want the information about the data we are using:
# if we want information about the description of the files - go to repository in Duccio's github - and go into data.description 
# important for matogrosso - images from the NASA Earth Observatory 
# or copy the name of the image - matogrosso_l5... and put in in the internet - all the information are there 
# matogrosso is a place in Brasil - deforestation

im.import("matogrosso_l5_1992219_lrg.jpg")    # maintain the quotes 
                                              # landsat image - earth at 30 m resolution
                                              # 3 bands: 1 = NIR (near infra red), 2=RED, 3= GREEN
                                              # the band associated with number 1 is the colour showed on the image as reflectance 

# name the image m1992 since it was taken in 1992 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") 
im.plotRGB(m1992, r=1, g=2, b=3)              # near infra red is on top of the red
im.plotRGB(m1992, 1, 2, 3)                    # the same thing, but better to put name of bands (r,g,b) for better understanding 

# the whole area in 1992 - complete tropical forest, already started to destroy it on the southern part

# green on the top
im.plotRGB(m1992, r=2, g=1, b=3)             # vegetation in green - ultra dense forest plus some bare soil 
                                             # everything reflecting in infra red is becoming green 

# blue on the top
im.plotRGB(m1992, r=2, g=3, b=1)             # high amount of solid particles - water is in the middle - it should become black in infra red images
                                             # vegetation in blue - bare soil is yellow 

# import the recent image 
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=1, g=3, b=2)             # vegetation in red - much less 
im.plotRGB(m2006, r=2, g=3, b=1)             # yellow is overtaking - good to use yellow as soil 
                                             # humans managed to destroy everything 


# build a multiframe (blue band) with 1992 and 2006 images using par function
par(mfrow=c(1,2))                   # opens multiframe with 1 row 2 columns
im.plotRGB(m1992, r=2, g=3, b=1)    # sets 1992 in blue band as 1st element of the multiframe
im.plotRGB(m2006, r=2, g=3, b=1)    # sets 2006 in blue band as 2nd element of the multiframe


dev.off()

# plot range of reflectance 
plot(m1992[[1]])                   # first band in near infra red - range from 0 to 255 

# bits- shannon information - binary code - 0 or 1 
# 2 bits of information - 4 combinations of light switching when there are 2 lights in the room - this is 2 bits 
# with 1 bit there are 2 informations 

# what happens with 3 lights? 
3 bits - 8 information 
4 bits - 16 information 

# it is all 2 elevated on certain point, 2^2, 2^3, (2^4 - 16 information but 4 bits)
# at 8 bit it is 256 


# We will use the image to build vegetation index and see how pixels changed in time 
#### DVI 1992 
# not a function but real operation - making difference between two bands
# difference between infra red and red band 

dvi1992 = m1992 [[1]] - m1992 [[2]]        # difference between the two bands (infra red is first band [[1]] and red is another band [[2]])
plot(dvi1992)                              # between 0 and minus is something else, suffering vegetation or soil

# lets change color 
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)       # dark red is okay here - bright red, orange, yellow, is bad from vegetation point of view (suffering vegetation or bare soil)
plot (dvi1992, col=cl)                                                      # plot dvi1992 in color ramp palette 

## Excercise - calculate dvi of 2006 
dvi2006 = m2006 [[1]] - m2006 [[2]]                                         # here earthy vegetation is small part in dark red with respect to suffering vegetation
plot (dvi2006)                            
plot (dvi2006, col=cl)  

# these images cannot be compared with each other since they are in different ranges 
# 1992 higher range than in 2006 
# need to standardise DVI - normalization
# normalize on top of the range you have - on top of the sum of the two bands
# dvi - difference between near infra red and infra red divided by their sum 

# NDVI - normalized deviation vegetation index (range from -1 to 1)
# 230 - 10 / 230 + 10 = 0.91 - range (DVI)   # 1st image 1992
# 3-1 / 3+1 = 0.5                            # 2nd image 2006 

# 0 - 255 / 0 +255 = -1 
# 255 - 0 / 255 + 0 = 1 

# if you need to compare images with different bits - you need to use NDVI (not DVI) - it always ranges from -1 to 1

##### NDVI 

ndvi1992 = (m1992 [[1]] - m1992 [[2]]) /  (m1992 [[1]] + m1992 [[2]])  # this is the formula for ndvi - 2 bands 1 minuts the other divided by one plus the other - like above
ndvi1992 = dvi1992 /  (m1992 [[1]] + m1992 [[2]])
plot(ndvi1992, col= cl)                                                # new range is from -1 to 1 - now it can be compared to any kind of image


ndvi2006 = (m2006 [[1]] - m2006 [[2]]) /  (m2006 [[1]] + m2006 [[2]]) 
ndvi2006 = dvi2006 /  (m2006 [[1]] + m2006 [[2]])
plot(ndvi2006, col= cl)     

# lets plot these two together (par) 
par(mfrow= c(1,2))                     # now we can plot them together and compare since they are at the same range from -1 to 1 (NDVI)
plot(ndvi1992, col= cl) 
plot(ndvi2006, col= cl) 


# scientifically meaningful image for everyone! - anyone can see this
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100)          # specifying a color scheme

par(mfrow= c(1,2))
plot(ndvi1992, col= clvir)
plot(ndvi2006, col=clvir)

# speeding up calculation 
ndvi2006a <- im.ndvi (m2006, 1, 2)      # calculated with ndvi, same thing as above - 1 and 2 mean 1st and 2nd band 
                                        # function im.ndvi will calculate it itself we dont need to do this ((m2006 [[1]] - m2006 [[2]]) /  (m2006 [[1]] + m2006 [[2]])) 
plot(ndvi2006a, col=cl)

