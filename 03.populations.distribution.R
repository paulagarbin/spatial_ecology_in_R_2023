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
