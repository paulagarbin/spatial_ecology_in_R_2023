# measuring variability from RS imagery
# important from geological and biological point of view 
# if large biological variability - probably tropics etc. and tundra very small variability and few species

library(terra)
library(imageRy)
library(viridis)

im.list()     # list of all possible images in the package

sent <- im.import("sentinel.png")     # 4th band is a control band we dont use 

# lets make calculation on this image
                                      # first plot 'sent' image in first band near infra red, 2nd is red, 3rd is green 
im.plotRGB(sent, r=1, g=2, b=3)       # black part is lake 
                                      # different type of geological structures - vegetation, mixed forest (red), light red is pasture
                             
im.plotRGB(sent, r=2, g=1, b=3)       # enhance vegetaion in green - you can see all the rocks in violet 

# now calculate variability - can be only on one variable (ex.age)

# let's use only in near infra red (NIR)
nir <- sent[[1]]        # nir = first element of the 'sent' image 
plot(nir)               # near infra red - green parts vegetation, bare soil is pinkish 
                        # 8 bit image - scale from 0-250 

# calculate variability over space 
# moving window
# calculation 
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
                  # nir is the band we are using 
                  # now we need to describe dimension of the moving window - matrix
                  # composed of 9 pixels - 1/9 meaning from 1 to 9 
                  # how pixels are distributed 
                  # function = standard deviation - sd 
                  # avoid using just sd as name since it means standard deviation in r

viridis <- colorRampPalette(viridis(7))(255)        # 7 colors and 255 amount of different inner-colors used 
plot(sd3, col=viridis)                              # we can see what is the probability in space of near infra red - ultra complex geology is green - very dangerous in glaciar environment
                                                    # also nice ridges where vegetation is present - contrasting element with the rest of the landscape 
                                                    # northwest highest variability 

# stacking nir and sd
stacknv <- c(nir, sd3)
plot(stacknv, col=viridis)

### Exercise: Calculate variability in a 7x7 moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)        # final number of pixels is now 49 so 1/49 
plot(sd7, col=viridis)                               # we can now see more 

# Exercise: plot together via par(mfrow()) the 3x3 and the 7x7 standard deviation
together <- par(mfrow=c(1,2))
plot(sd3, col=viridis)           # very local calculation if standard deviation is 3x3 - in infrared only suble differences
plot(sd7, col=viridis)           # if window enlarged including additional pixels (49 now) - bigger moving window, higher variability in this image 
                                 # same situation as we will include additional people to the analysis 

# original image plus the 7x7 sd
par(mfrow=c(1,2))                # high geological or species variability 
im.plotRGB (sent, r=2, g=1 , b=3)
plot(sd7, col=viridis)

# change the moving window
sd5 <- focal(nir, matrix(1/25, 5, 5), fun=sd)
stacknv <- c(nir, sd3, sd5)
plot(stacknv, col=viridis)

# change the moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
stacknv <- c(nir, sd3, sd5, sd7)
plot(stacknv, col=viridis)

