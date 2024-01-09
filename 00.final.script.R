#Final script including all the different scripts during lectures 
# -------------------
# Summary:
# 01 Beginning
# 02.1 Population density
# 02.2 Population distribution
# 03.1 Community Multivariate Analysis   
# 03.2 Community overlap
# -------------------

# 01:Beginning 

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

# 02.1 Population density

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
                  
# 02.2 Population distribution
                  
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

# 03.2 Community overlap 
                  
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
                  


