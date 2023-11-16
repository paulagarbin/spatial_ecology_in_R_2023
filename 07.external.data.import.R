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

# im.plotRGB before we would use this but not plotRGB
plotRGB(naja, r=1, g=2, b=3) 
