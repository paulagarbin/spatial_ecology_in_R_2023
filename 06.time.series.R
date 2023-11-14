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

difg <- stackg[[1]] - stackg[[4]]       # here we [[]] mark position
plot(difg, col=cldif)                   # losing low temperatures from the middle - that part particularly sensitive to changes 
                                        # since second image had lower values we have minus on the scale - negative change, losing low temperatures 
                                        # higher surface temperature and ice melt in 15 years !
# or 
# difg <- g2000 - g2015


##### EARTH OBSERVATORY OR COPERNICUS - for the project!!!!!!! 
