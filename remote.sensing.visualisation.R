# Remote sensing 

# This is a script to visualize satellite data

install.packages("devtools")
library(devtools) # packages in R are also called libraries

# install the imageRy package from GitHub
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)

install.packages("terra")
library(terra)

im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")   # importing band 2 of Sentinel 2 
