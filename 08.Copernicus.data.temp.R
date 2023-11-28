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




