#Final script including all the different scripts during lectures 

# -------------------
# Summary:
# 01 Beginning
# 02.1 Population Density
# 02.2 Population Distribution
# 03.1 Community Multivariate Analysis   
# 03.2 Community Overlap
# 04 Remote Sensing Visualisation
# 05 Spectral Indices 
# 06 Time Series 
# 07 External Data Import 
# 08 Copernicus Data Temperature
# 09 Classification
# 10 Variability 
# 11 Principal Component 
# -------------------

# -------------
# 01 Beginning 

# Here I can write anything I want! Everyone can see the code and we need to write comments.
# R as a calculator 
2+3

# Assign to an object 
zima <- 2+3
zima

duccio <- 5+3 
duccio 

final <- zima*duccio 
final

final^2

# array 
sofi <- c(10, 20, 30, 50, 70) #microplastics 
                              #functions have parenthesis and inside of them are arguments making an array 

paula <- c(100, 500, 600, 1000, 2000)   #people 

plot(paula, sofi)
plot(paula, sofi, xlab="number of people", ylab="microplastics")

#assigning to the other object to plot easier
people <- paula 
microplastics <- sofi

plot(people, microplastics)
#to add the filled circles we add pch = there is an explanation online and you can pick any number
plot(people, microplastics, pch=19)
plot(people, microplastics, pch=19, cex=2)                 #cex is size of the data points
plot(people, microplastics, pch=19, cex=2, col="yellow")   #colour change is col="colour"

# -----------------------
# 02.1 Population Density

# Code related to population ecology 

# A package is needed for point pattern analysis 
# install from outside source 
# To install package from CRAN we need to exit R and use "" 
install.packages ("spatstat")
library(spatstat)

#lets use the bei data:
#data description: link - that is how we link our data to the code
bei                  # huge amount of data 
plot(bei)            # huge data points, we need to sort that 

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
                  # one is elevation, and one is called grad
                  # we only need elevation, so only one element of the dataset

#let's use only part of the dataset: elev
bei.extra$elev         # linking elevation to the dataset 
plot(bei.extra$elev)   # it will plot only elevation
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

cl <- colorRampPalette (c("black", "red", "orange", "yellow"))(4)   # no continuity, clear colours                   

# there are many colors in R we can just open it in google and use any of those - like sandybrown, seagrass etc

# lets build our own colorramp palete     
cl <- colorRampPalette (c("burlywood", "darkgray", "coral", "darkorchid"))(100)     
# never use rainbow palette 


# let's plot extra information                   
plot(bei.extra)               # one variable is gradient and other is elevation  
elev <- bei.extra [[1]]       # this is elevation data - first one so we extract it like this we can also use 
									            # bei.extra$elev
plot(elev)                    # plots only elevation 

                  
#### multiframe 
par(mfrow=c(1,2))             # this will build empty frame with two slots                                
plot(elev)
plot(densitymap)              # if we run all three lines - they show together in the frame - one image with both elev and density map 

par(mfrow=c(2,1))             # by selecting 2,1 this time they will show one on top of the other - 2 rows 1 column    
plot(elev)
plot(densitymap)              # makes sense becuse if we go higher in elevataion we have less trees       
									
# now we want three images - one next to each other - bei, densitymap, and then elev 
par(mfrow=c(1,3))    # one row 3 columns 
plot(bei)
plot(densitymap)
plot(elev)                  


# ----------------------------       
# 02.2 Population Distribution
                  
# Population Distribution 
# Why populations disperse over the landscape in a certain manner? 

# install.packages("sdm")        # species distribution model
# install.packages("terra")      # predictors
# install.packages("rgdal")      # already in terra package now - species

library(sdm)                     # library - no quotes, already inside R
library(terra)                   # deals with spatial data
library(rgdal)                   # already in terra package

file <- system.file("external/species.shp", package="sdm")   
                                 # catches name of the file in the R system, search for certain file in folders you just installed 
                                 # based on our computer
                                 # select the path, then declare from which package you are using these files
                                 # this is a file containing some information that we want to use 
                                 # vector files - series of coordinates 
rana <- vect(file)               # rana-frog, vect - function from the terra package !!!! dealing with vectors 
rana                             # dealing with points, gives coordinates as well, one column called occurrence (200,1)

rana$Occurrence                  # gives 0101010110110 (200 points), presence and absence data- 0 means no rana, 1 is rana found 
                                 # it is only important if they are there 0,1,0 - occurance, if it matters the number, it is abundance
                                 # 0 is a problem - uncertain data - maybe you missed it 
plot(rana, cex=0.5)              # cex = 0.5 is smaller dots 
                                 # this plot shows both 1s and 0s - absences and presences 
                                 # we need to select either absence or presence 

# Selecting presences 
pres <- rana[rana$Occurrence==1,]       # []used to select elements, a comma at the end to close the query, in SQL it is ; but here it is , 
                                        # , is a closing in a language - works sometimes without 
                                        # selects all presences 
plot (pres, cex=.5)                     # fewer points now since it is just presence 


# Select absences and call them abse 
abse <- rana[rana$Occurrence ==0,]          # select only absences 
abse <- rana[rana$Occurence !=1,]           # the same thing - not equal to 1
plot(abse, cex=.5)                          # plots absences 

# plot absences and presences: one plot beside the other 
par(mfrow=c(1,2))                           # creates empty dataframe with two slots next to each other - 1 row
plot(pres, cex=0.5)
plot(abse, cex=0.5)                         # higehr amount of absences than presences 

#close the dataframe
dev.off()                                   # NULL the device - R

# plot presences and absences together with 2 colours 
plot(rana[rana$Occurrence == 1,],col='darkgreen', cex=0.7, pch=16)  
points(rana[rana$Occurrence == 0,],col='lightgreen',pch=16)

# first plot function to have a plot - then add points to it to add second data 
# if we do plot for both second one will overtake the previous one and it wont be on the same plot

# predictors: environmental variables - look at the path 
# to see what is the path of my data 

### elevation predictor 
elev <- system.file("external/elevation.asc", package="sdm")   # now we are dealing with rasters - so we dont use vector function vec

# system function - taking the data elevation.asc inside the folder external - asc is an extension meaning asci - type of file - raster data - image file

elevmap <- rast(elev)    # rast is a function from terra package - set to be called elevmap
elevmap
plot(elevmap) 
points (pres,cex=.5)     # on top of elevation plot presences 

# you can see that rana loves a little bit of elevation so it is not too hot - but also they dont prefer the highest elevation - cannot survive - too cold in winter
# it is not able to make long distances - living in some sites with medium elevation throughout the year 

### temperature predictor 
temp <- system.file("external/temperature.asc", package="sdm")   # path from my computer to the file 
tempmap <- rast(temp)                                            # make raster data of temp - to be called tempmap
plot(tempmap)                                                    # plot the data
points(pres, cex=0.5)                                            # add presences on top 

# rana is avoiding very cold tempreatures 

### do the same with vegetation cover 
veg <- system.file("external/vegetation.asc", package="sdm") 
vegmap <- rast(veg) 
plot(vegmap)
points(pres, cex=0.5)

# rana will prefer places with high vegetation cover - since it guarantees avoiding predators 

### precipitation cover 
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) 
plot(precmap)
points(pres, cex=0.5)

# rana will prefer more precipitation

### plot everything together in a multiframe 
# opening a new frame with par
par(mfrow=c(2,2))             # we will have 2 rows and 2 columns since there is 4 raster images 

#elevation - elev
plot(elevmap)
points (pres,cex=.5)

#temperature - temp
plot(tempmap)                                             
points(pres, cex=0.5) 

#vegetation - veg
plot(vegmap)
points(pres, cex=0.5)

# precipitation - prec
plot(precmap)
points(pres, cex=0.5)

# run all together from par to the end - all the plots !!! 

# ------------------------
# 03.1 Community Multivariate Analysis               
                
install.packages("vegan")   # vegetational analysis - vegan 
library(vegan)              # premute and lattice 

                            # two sets - one is related to dunes and plants in dunes - dataset called dunes 
# recall the data (dunes)
data(dune)                  # recall the data
dune                        # gives back the whole table in columns different species with their abundance in dunes 

head(dune)                  # header: it only gives back first 6 rows of data - like the preview of the beggining of the data
                            # and all the columns - 6 rows 

ord <- decorana(dune)       # assign decorana to an object (ord)
ord

# Call:
# decorana(veg = dune) 

# Detrended correspondence analysis with 26 segments.
# Rescaling of axes with 4 iterations.

#                   DCA1   DCA2
# Eigenvalues     0.5117 0.3036
# Decorana values 0.5360 0.2869
# Axis lengths    3.7004 3.1166            # we want to know the range of data on all axis 
#                    DCA3    DCA4
# Eigenvalues     0.12125 0.14267
# Decorana values 0.08136 0.04814
# Axis lengths    1.30055 1.47888

ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

## percentage of the range of each axis 

# percentage of length of dc1 

pldc1 = ldc1 * 100/total
pldc2 = ldc2 * 100/total
pldc3 = ldc3 * 100/total
pldc4 = ldc4 * 100/total

pldc1 
pldc2 
pldc3
pldc4

pldc1+pldc2  # 71.03683 is the percentage of range of data in axis 1 and 2 - we only take those 2 and deal with them

# final output we will receive 
plot(ord)            # space defind by ldc1 and ldc2 
                     # species are plotted in a graph with 2 axis - moved from different plots in a new dimension 
                     # we can describe species in different systems - some stay together and are plotted one on the other 

# from the table we cannot see how species stay together and grow in the same area - but from the plots it is clear 
# for that we cannot use the whole dimensions (4 in this case) - we can only use 2 - 71% ones ldc1 and ldc2 and use it for multivariate analysis 
# in parts of the graph different species staying together in (grassland, wetland, etc.) 
# it is important to see how species overlap with each other in order to manage their conservation



# --------------------
# 03.2 Community Overlap 
                  
# camera traps data
# data from Kerinci-Seblat National Park in Sumatra, Indonesia (Ridout and Linkie, 2009)
# Ridout MS, Linkie M (2009). Estimating overlap of daily activity patterns from camera trap data. 
# Journal of Agricultural, Biological, and Environmental Statistics, 14(3), 322–337.

install.packages("overlap")
library(overlap)     # https://cran.r-project.org/web/packages/overlap/vignettes/overlap.pdf  we are using part of the vignette - and we will build some of those graphs

# relation among species in space - use multivariate analysis (previous lecture)
# relation among species in time 

# data
data(kerinci)
head(kerinci)       # first 6 rows - it shows zone - species - time 
kerinci             # to see the whole dataset 
summary (kerinci)   # general information about the dataset - we dont need it its just to see

# let's see how species 'tiger' has moved throughout the day 
# tiger
tiger <- kerinci[kerinci$Sps == "tiger",]       # now we need the comma at the end of parenthesis to end 
                                                # in sequel - final symbol is ; but in R is just comma , 
tiger                                           # new data set with only data connected to "tiger" 

# we should pass time to radians - multiply original time by 2*pi 
# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: 
kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi       # add new colum with this calculation 

# to add a new column in the datset you assign calculation to a new object
# then it is immediatly in the dataset since you put it kerinci$timeRad - new name assigned in the dataset

head(kerinci)       # new column aded - time passed to radians (ratio between a line and radius of a circumfernece) 

# now remake tiger 
tiger <- kerinci[kerinci$Sps == "tiger",] 
head(tiger)                        # new dataset tiger with additional column 

# final plot of the "tiger" 
plot(tiger$timeRad)                # plot tiger and time radians 


timetig <- tiger$timeRad           # assigning the tiger and time to timetig 
densityPlot(timetig, rug=TRUE)     # function showing amount of time in analysis 
                                   # density of tiger in 24 h - radians are now clockwise (24hour clock)
                                   # in the plot night - sleeping - peak in the morning - hunting - relax - increaase again- decrease sleep again 


# exercise: select only the data on "macaque"
macaque <- kerinci [kerinci$Sps == "macaque",]
head(macaque)

timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)    # different from tigers - they had 2 peaks during the day 
                                  # macaque sleeps a lot more than tiger - and then wakes up and peaks around noon and slowly falls down - one peak


# what is the moment when it is dangerous for macaque - when tiger is awake and hunting
# overlap!
overlapPlot(timetig, timemac)  # coloured part of the graph is both distributions overlap - dangerous for macaque and lunchtime for tigers 
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')    

                  
                
# ------------------------
# 04 Remote Sensing Visualisation
		  
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


# ---------------------
# 05 Spectral Indices 

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

# -----------------------		  
# 06 Time Series 
		  
#### Time series analysis
# how NO2 (air pollution) variated during Covid - comparison of January and March

library(imageRy)
library(terra)

im.list() 

# import the first image
EN01 <- im.import("EN_01.png")   # you can see NO2 high level mainly in Italy in red
                                 # before Covid - January
                                 # also large levels during this period of NO2 in large capital cities like Madrid 
EN13 <- im.import("EN_13.png")   # in March situation - low amount of NO2 - nitrogen 

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)           # auto - automatically selects 3 bands
im.plotRGB.auto(EN13)           # plots 1 column 2 rows - difference between JANUARY and MARCH

# Difference between the two images - using the first element (band) [1]
dif = EN01[[1]]-EN13[[1]]

def.off()  # clear the previous image

plot(dif)   # hard to read 

# change the color ramp palette
cldif <- colorRampPalette(c("blue","white", "red")) (100)
plot(dif, col=cldif)          # blue continued working - high values
                              # red colour - places where number was higher in January (many places) 
                              # we stopped to use cars in big cities like Madrid and Rome 
                              # Adriatic Sea - way smaller emissions in March 


##### New example: Greenland increase of temperature
# Land surface temperature - LST

g2000 <- im.import("greenland.2000.tif")      # at 16 bits - not 8 like usual
                                              # one layer -just to see how it appears in 2000
clg <- colorRampPalette(c("blue","white", "red")) (100)
plot(g2000, col=clg)                          # situation in 2000 - very wide inner area with almost all covered with ice and snow - temperature of the surface
                                              # middle of Greenland - large area with very low temperature 
                                              # outside of these area higher temperatures (in red)

# import all the images of Greenland together

g2005 <- im.import("greenland.2005.tif") 
g2010 <- im.import("greenland.2010.tif") 
g2015 <- im.import("greenland.2015.tif") 

plot(g2015, col=clg)          # deep blue in central part is decreasing - it is still blue so add another colour for the middle of Greenland (lowest values)

# add black in color ramp palette in the middle 
clg <- colorRampPalette(c("black","blue","white", "red")) (100)
plot(g2015, col=clg)    

# plot together 2000 and 2015 to see the difference 
par(mfrow=c(2,1))          
plot(g2000, col=clg)
plot(g2015, col=clg)


# stacking the data and plotting all 4 images together 
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

# period of 2005 was one of the worst for temperature - large increase in temperature in 2003 

#### Excercise: make the difference between the first and the final elements of the stack
gdif = g2000-g2015                      # no need for [[1]] because it is only one band image
dev.off()
plot(gdif)

difg <- stackg[[1]] - stackg[[4]]       # here we [[]] mark position in stackg
plot(difg, col=cldif)                   # losing low temperatures from the middle - that part particularly sensitive to changes 
                                        # since second image had lower values we have minus on the scale - negative change, losing low temperatures 
                                        # higher surface temperature and ice melt in 15 years !
# or 
# difg <- g2000 - g2015


##### EARTH OBSERVATORY OR COPERNICUS - data for the project!!!!!!! 

### we can use 3 images to make RGB plot 
# take 2000 and put it in RED channel   # if high values in 2000 - they will become red 
# 2005 put in the GREEN channel         # if high values in 2005 - they will become green
# 3rd element in BLUE                   # if high values in 2015 - they will become blue - if it becomes blue-ish means that temperature is higher in the final period

### Excercise: make a RGB plot using different years 

im.plotRGB(stackg, r=1, g=2, b=3)   # western part higher temperatures 
                                    # green on top - start to increase in 2005 
                                    # middle - blue-ish - temperature higher in last period - if it was red it would mean temperature was higher in the first period (red band)

# possibility of seeing changes in landscape - monitoring in person is difficult - use satellite imagery 

# -----------------------		  
# 07 External Data Import 
		  
# External data
# download image (JPEG in this case) to your computer from the web
# set working directory - folder in which we will be working from now on - we can set it with funcition "setwd"

library(terra)       # always put library packages on top of the code

# setting working directory based on your path 
# change backslashh to slash / 
setwd("C:/Users/Paula/Desktop/Spatial ecology in R")

# we can use rast function from terra - going to create the image - import it from outside R
rast("najafiraq_etm_2003140_lrg.jpg")              # Windows masking the extension - add .jpg
naja <- rast("najafiraq_etm_2003140_lrg.jpg")      # name it 

# im-plotRGB - plot this 
plotRGB(naja, r=1, g=2, b=3) 

## Excercise: download the second image from the same site and import it in R 
# save in the same folder
rast ("najafiraq_oli_2023219_lrg.jpg")
najaaug <- rast ("najafiraq_oli_2023219_lrg.jpg")

#plot the image
plotRGB(najaaug, r=1, g=2, b=3)

# plot them together one above the other 
par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3) 
plotRGB(najaaug, r=1, g=2, b=3)

dev.off()        # clear the plots

# multitemporal change detection 
najadif = naja[[1]] - najaaug [[1]]          # diference
cl=colorRampPalette (c("brown", "grey", "orange")) (100)
plot(najadif, col=cl) 

##### Excercise: download your own preffered image 
# venice in 2000
rast ("venice.jpg")
venice <- rast ("venice.jpg")

#plot in different bands
plotRGB(venice, r=1, g=2, b=3)
plotRGB(venice, r=2, g=1, b=3)
plotRGB(venice, r=3, g=2, b=1)


# plot from 2013
rast ("venice_2013.jpg")
ven2013 <- rast ("venice_2013.jpg")
plotRGB(ven2013, r=1, g=2, b=3)

# plot them together 
par(mfrow=c(1,2))
plotRGB(venice, r=1, g=2, b=3) 
plotRGB(ven2013, r=1, g=2, b=3)

dev.off()

# multitemporan change detection 
# vendif = venice [[1]] - ven2013[[1]]          - doesnt work because extents are not the same
# cl=colorRampPalette (c("brown", "grey", "orange")) (100)
# plot(vendif, col=cl) 


### the Mato Grosso image can be downloaded directly from EO-NASA: 

# mato <- rast("matogrosso_l5_lala.jpg") 
# plotRGB(mato, r=1, g=2, b=3)

# download the package
install.packages ("ncdf4")


# --------------------
# 08 Copernicus Data Temperature 

# Data available at:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)  # library we need to read .NC files 
library(terra)  # package needed for importing data from outside R

# explain to R where the Data will be stored 
# set working directory - image in downloads
setwd("C:/Users/Paula/Desktop/Spatial ecology in R") # always change backslash to slash 

soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")

plot(soilm2023)

# there are two elements so let's use the first one
# plot(raster[[1]])
plot(soilm2023[[1]])     # only the first element

# change the color palette
cl <- colorRampPalette(c("red","orange","yellow")) (100)
plot (soilm2023[[1]], col =cl)

### we want to crop our image, we need to specify the extent of the image 
ext <- c(22,23,55,57)                           # minlongitude, maxlong, minlatitude, maxlat  
                                                # defining the extent in space which you want 
soilm2023crop <- crop(soilm2023,ext)            # crop crops the image you want, ext means to that extent you set previously and name it new variable

plot(soilm2023crop[[1]], col=cl)                # selecting first element with [[1]]


### CROP!!!
# if you use burned areas - small parts of the planet - you should crop them !! 
# or huge landsat images that you want to crop 

# new image 
soilm2023_14 <- rast ("c_gls_SSM1km_202311120000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_14)

soilm2023_14_crop <- crop(soilm2023_14, ext)
plot(soilm2023_14_crop[[1]], col=cl)       # here nothing is showing up maybe white for the area

# plot different image with same extent (EXT) - so you have 2 images of the same extent

# -----------------------
# 09 Classification
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
# balanced in 2006 

# now we need 2 more things 
# library(ggplot2)
# library(patchwork)

# now we will make final plot
library(ggplot2)
# ggplot function, aes (x = class, y= column related to year, color = related to class)
# bars = histograms, can be related to statistics, stats = identity, we use direct values, filling it with white but can be any color

# final plot
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1+p2           # if we want to see the plots one next to each other 
                # different scales so we can't understand the impact - used in newspaper to soften the news  
                # rather then using continuous data we classified it to 2 and plotted it

# final plot - rescaled
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))      # limit in y different than above - rescale
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2

# this graph shows great part of the forest that was lost from 1992 until 2006 
# in statistics it has to be the same scale to be able to visualise the change 

#### This lesson takeaway:
# we wanted to measure how big the change in Matogrosso was - how much forest was lost in percentage % 
# take 2 images and made a graph to see the change 
		  
# ------------------------- 
# 10 Variability 
		  
# measuring variability from RS imagery
# important from geological and biological point of view 
# if large biological variability - probably tropics etc. and tundra very small variability and few species

library(terra)
library(imageRy)
library(viridis)

im.list()     # list of all possible images in the package

sent <- im.import("sentinel.png")     # 4th band is a control band we dont use 

# lets make calculation on this image
                                      # first plot 'sent' image in first band near infra red, 2nd is red, 3rd is green 
im.plotRGB(sent, r=1, g=2, b=3)       # black part is lake 
                                      # different type of geological structures - vegetation, mixed forest (red), light red is pasture
                             
im.plotRGB(sent, r=2, g=1, b=3)       # enhance vegetaion in green - you can see all the rocks in violet 

# now calculate variability - can be only on one variable (ex.age)

# let's use only in near infra red (NIR)
nir <- sent[[1]]        # nir = first element of the 'sent' image 
plot(nir)               # near infra red - green parts vegetation, bare soil is pinkish 
                        # 8 bit image - scale from 0-250 

# calculate variability over space 
# moving window
# calculation 
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
                  # nir is the band we are using 
                  # now we need to describe dimension of the moving window - matrix
                  # composed of 9 pixels - 1/9 meaning from 1 to 9 
                  # how pixels are distributed 
                  # function = standard deviation - sd 
                  # avoid using just sd as name since it means standard deviation in r

viridis <- colorRampPalette(viridis(7))(255)        # 7 colors and 255 amount of different inner-colors used 
plot(sd3, col=viridis)                              # we can see what is the probability in space of near infra red - ultra complex geology is green - very dangerous in glaciar environment
                                                    # also nice ridges where vegetation is present - contrasting element with the rest of the landscape 
                                                    # northwest highest variability 

# stacking nir and sd
stacknv <- c(nir, sd3)
plot(stacknv, col=viridis)

### Exercise: Calculate variability in a 7x7 moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)        # final number of pixels is now 49 so 1/49 
plot(sd7, col=viridis)                               # we can now see more 

# Exercise: plot together via par(mfrow()) the 3x3 and the 7x7 standard deviation
together <- par(mfrow=c(1,2))
plot(sd3, col=viridis)           # very local calculation if standard deviation is 3x3 - in infrared only suble differences
plot(sd7, col=viridis)           # if window enlarged including additional pixels (49 now) - bigger moving window, higher variability in this image 
                                 # same situation as we will include additional people to the analysis 

# original image plus the 7x7 sd
par(mfrow=c(1,2))                # high geological or species variability 
im.plotRGB (sent, r=2, g=1 , b=3)
plot(sd7, col=viridis)

# change the moving window
sd5 <- focal(nir, matrix(1/25, 5, 5), fun=sd)
stacknv <- c(nir, sd3, sd5)
plot(stacknv, col=viridis)

# change the moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
stacknv <- c(nir, sd3, sd5, sd7)
plot(stacknv, col=viridis)
		  
# ---------------------------
# 11 Principal Component 
		  
### Multivariate analysis
# Principal component analysis 

library(imageRy)
library(viridis)
library(terra)

im.list()

sent <- im.import("sentinel.png")
pairs(sent)         # hard to read 
                    # red and the green are corellated to each other by 0.98 pearson coefficient - from 0 to 1 ranges 
                    # near infra red is less correlated to other bands - adding additional information
                    # last row - sent 4 is just control - can be removed or kept as constant

# perform PCA on sent 
sentpc <- im.pca2(sent)     
sentpc              # we can see first component is called PC1 and we can isolate it

pc1 <- sentpc$PC1 
plot(pc1)

# let's use viridis legend 
viridisc <- colorRampPalette(viridis(7)) (255)
plot(pc1, col=viridisc)

# Calculating standard deviation on top of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) 
plot(pc1sd3, col=viridisc)                       # similar to infra red but calculated to objectively selected layer 

# plot in 7x7 window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)


### plot all of them together
par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)      # near infra red on top of the green
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)     # 7 images inside final plot

# stack all the standard deviation layers 
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7) 
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")      # adding names to all 4 plots 
plot(sdstack, col=viridisc)

# -----------------------------		  
		  
