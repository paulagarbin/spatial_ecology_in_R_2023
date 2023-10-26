# Remote sensing 

# This is a script to visualize satellite data

install.packages("devtools")
library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")      # just like we do install.packages in cran for github it is install_github 
                                                        # in cran it is controlled, in github anyone can use it at any time
library(imageRy)

install.packages("terra")
library(terra)

#list the data
im.list()         #list of all files that are within imagery 

# we will use sentinel dolomites band 2
im.import("sentinel.dolomites.b2.tif")       # importing band 2 of Sentinel 2 
b2 <- im.import("sentinel.dolomites.b2.tif") # assign it to an object

clb <- colorRampPalette(c("dark grey", "grey", "light grey")) (100)     # colorpalete with 3 colours light grey being the highest - clb is the name 
plot(b2, col=clb)      

# import the green band from Sentinel-2 (band 3) 
b3 <- im.import("sentinel.dolomites.b3.tif" )                           # dark is absorbing green colour - light grey reflecting the green
clb <- colorRampPalette(c("dark grey", "grey", "light grey")) (100)     # colorpalete with 3 colours light grey being the highest - clb is the name 
plot(b3, col=clb)      
