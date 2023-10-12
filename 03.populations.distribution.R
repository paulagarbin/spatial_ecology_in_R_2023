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

