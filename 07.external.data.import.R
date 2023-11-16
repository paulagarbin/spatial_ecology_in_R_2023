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
