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












