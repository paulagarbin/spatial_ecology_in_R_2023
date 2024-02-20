#### Temporal analysis of vegetation cover and the extent of farmland areas in the Nile Delta 

# Packages 
library(ncdf4)   # library we need to read .NC files 
library(terra)   # package needed for importing data from outside 
library(viridis)
library(imageRy) # package developed at unibo
library(ggplot2)
library(tidyterra)
# Setting working directory 
setwd("C:/Users/Paula/Desktop/Spatial ecology in R/Project") # always change backslash to slash 

### Temporal analysis of Vegetation Cover in the area of Nile Delta for 2015-2020
## Importing data from Copernicus with function: rast()

fcover_2015 <- rast("fcover_2015.nc")
fcover_2020 <- rast("fcover_2020.nc")

# Cutting the map define the extent of the research

ext <- c(29,33,29.5,32) 
fcover2015.crop <- crop(fcover_2015, ext)
fcover2020.crop <- crop(fcover_2020, ext)

#extracting FCOVER layer from the data

fcover_layer2015 <- fcover2015.crop[["FCOVER"]]
fcover_layer2020 <- fcover2020.crop[["FCOVER"]]

plot(fcover_layer2015)
plot(fcover_layer2020)

# Plot using ggplot2
ggplot2015<-ggplot() + 
  geom_raster(fcover_layer2015, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("FRACTION OF GREEN VEGETATION COVER 2015")

ggplot2020<-ggplot() + 
  geom_raster(fcover_layer2020, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("FRACTION OF GREEN VEGETATION COVER 2020")

ggplot2015
ggplot2020
############################################################################################################









clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100)  

plot(fcover_2015[[1]])
ext <- c(29,33,29.5,32)    
fcover_2015_crop <- crop(fcover_2015, ext)
plot(fcover_2015_crop[[1]], col=clvir)

plot(fcover_2020[[1]])
ext <- c(29,33,29.5,32)    
fcover_2020_crop <- crop(fcover_2020, ext)
plot(fcover_2020_crop[[1]], col=clvir)

# Plotting them together for comparison
par(mfrow=c(1,2))         # building an empty frame with 1 row 2 columns  

delta2015 <- plot(fcover_2015_crop[[1]],
          main = "Vegetation Cover 2015", cex.main=0.7,
          xlab = "Longitude", ylab = "Latitude", col=clvir)

delta2020 <- plot(fcover_2020_crop[[1]],
          main = "Vegetation Cover 2020", cex.main=0.7, 
          xlab = "Longitude", ylab = "Latitude", col=clvir)


# Summary statistics for vegetation cover in 2015
summary_2015 <- summary(values(fcover_2015_crop))

# Summary statistics for vegetation cover in 2020
summary_2020 <- summary(values(fcover_2020_crop))

# Output the summary statistics
print("Summary Statistics for Vegetation Cover in 2015:")
print(summary_2015)

print("Summary Statistics for Vegetation Cover in 2020:")
print(summary_2020)
# Calculating the difference between 2020 and 2015
change_map <- fcover_2020_crop - fcover_2015_crop

# Visualizing the change map
plot(change_map[[1]], 
     main = "Change in Vegetation Cover (2020 - 2015)",  col=clvir)              # mainly negative values (from -0.1 to -0.3)) in delta area 
                             # indicating decrease in vegetation cover over the specified time period


#############################################################################
#pixel estimation
pixel2015 <- ncell(delta2015)
pixel2015

pixel2020<-ncell(delta2020)
pixel2020











#############################################################################


# Extracting vegetation cover values for 2015 and 2020
vegetation_cover_2015 <- values(fcover_2015_crop)
vegetation_cover_2020 <- values(fcover_2020_crop)

# Performing the paired t-test
t_test_result <- t.test(vegetation_cover_2015, vegetation_cover_2020, paired = TRUE)

# Output the test results
print(t_test_result)   # no significant difference 





### Temporal Analysis of disappearing farming areas in the area of Nile Delta due to urbanization
## Importing images from Earth Observatory with function: rast()

# Farming 1984
farming_1984 <- rast("niledeltaurban_tm5_1984207_1.jpg") 
plot(farming_1984)

# Farming 2019
farming_2019 <- rast("niledeltaurban_oli_2021228_1.jpg")
plot(farming_2019)

# Calculating DVI
plot(farming_1984)
im.plotRGB(farming_1984, r=1, g=2, b=3)        # near infra red is on top of the red
im.plotRGB(farming_1984, 1, 2, 3)  
# green on the top
im.plotRGB(farming_1984, r=2, g=1, b=3)        # vegetation in green - ultra dense forest plus some bare soil 
                                               # everything reflecting in infra red is becoming green 
# blue on the top
im.plotRGB(farming_1984, r=2, g=3, b=1)        # high amount of solid particles 
                                               # vegetation in blue - bare soil is yellow 

plot(farming_2019)
im.plotRGB(farming_2019, r=1, g=3, b=2)        # vegetation in red - much less 
im.plotRGB(farming_2019, r=2, g=3, b=1)        # yellow is overtaking - good to use yellow as soil 

par(mfrow=c(1,2))                              # opens multiframe with 1 row 2 columns
im.plotRGB(farming_1984, r=2, g=3, b=1)        # sets 1992 in blue band as 1st element of the multiframe
im.plotRGB(farming_2019, r=2, g=3, b=1)  

# plot range of reflectance 
plot(farming_1984[[1]])                        # first band in near infra red - range from 0 to 255 

# difference in infra red and red band 
dvi1984 = farming_1984 [[1]] - farming_1984 [[2]]    # difference between the two bands (infra red is first band [[1]] and red is another band [[2]])
plot(dvi1984, col=clvir)                             # between 0 and minus is suffering vegetation or soil

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)       # dark red is okay here - bright red, orange, yellow, is bad from vegetation point of view (suffering vegetation or bare soil)
plot (dvi1984, col=cl)                                                      # plot dvi1984 in color ramp palette 

# calculate dvi of 2019
dvi2019 = farming_2019 [[1]] - farming_2019 [[2]]                           # here vegetation is small part in dark red with respect to suffering vegetation in yellow
plot (dvi2019)                            
plot (dvi2019, col=cl)  

# plot them together - 2019 is way more yellow!!!
par(mfrow=c(2,1)) 
plot(dvi1984, col=cl)
plot(dvi2019, col=cl)

dev.off()

## Calculating NDVI
# NDVI for 1984
ndvi1984 = (farming_1984 [[1]] - farming_1984 [[2]]) /  (farming_1984 [[1]] + farming_1984 [[2]])  # this is the formula for ndvi 
ndvi1984 = dvi1984 /  (farming_1984 [[1]] + farming_1984 [[2]])    # short formula
plot(ndvi1984, col= cl) 
plot(ndvi1984, col = cl, main = "NDVI of 1984", cex.main = .7)

#NDVI for 2019
ndvi2019 = (farming_2019 [[1]] - farming_2019 [[2]]) /  (farming_2019 [[1]] + farming_2019 [[2]])  # this is the formula for ndvi 
ndvi2019 = dvi2019 /  (farming_2019 [[1]] + farming_2019 [[2]])
plot(ndvi2019, col= cl)   
plot(ndvi2019, col = cl, main = "NDVI of 2019", cex.main = .7)

# Multiframe 
# Now we plot them together and compare since they are at the same range from -1 to 1 (NDVI)
par(mfrow= c(2,1))                   
plot(ndvi1984, col= cl, main = "NDVI of 1984", cex.main = .7) 
plot(ndvi2019, col= cl, main = "NDVI of 2019", cex.main = .7) 

dev.off()

# Most of the study area reflects NDVI values between -0.6 and 0.0 in 1984, suggesting 
# the presence of high or mid-high canopy cover with high vigour 
# As values decrease towards 0, the vegetation can both decrease in size or be more stressed. 
# Considering the high temperatures and the vast area that is 
# experiencing the decrease in NIR reflection, the most probable option for this phenomenon 
# is the increase in stressed leaves. 
# Around 0 values the soil is bare, as suggested by the shape of the riverbed. 
# Brown and so negative values are occupied by water bodies such as lakes and big rivers. 
# In 5 years the main change consists in a little decrease in the vegetation cover or stress of 0.1 or 0.2 NDVI values.

# Classification over time

farming1984class <- im.classify(farming_1984, num_clusters=3)

class_names <- c("absent", "stressed", "healthy")

plot(farming1984class[[1]], main = "Classes in 1984", type = "classes", levels = class_names)


farming2019class <- im.classify(farming_2019, num_clusters=3)

plot(farming2019class[[1]], main = "Classes in 2019", type = "classes", levels = class_names)


par(mfrow=c(2,1))
plot(farming1984class[[1]], main = "Classes in 1984", type = "classes", levels = class_names)
plot(farming2019class[[1]], main = "Classes in 2019", type = "classes", levels = class_names)
dev.off()

tabout <- data.frame(farming1984class, farming2019class)        # 2 columns 
tabout


# proportion of the classes
farming_1984prop <- freq(farming1984class[[1]])
farming_1984prop

#     layer value  count
#  1     1     1   25603
#  2     1     2   242619
#  3     1     3   77378

farming_2019prop <- freq(farming2019class[[1]])
farming_2019prop

#    layer value  count
# 1     1     1   92488
# 2     1     2   46730
# 3     1     3   206382

# total number of pixels
tot1984 <- ncell(farming1984class[[1]])
tot1984    # 345600

tot2019<-ncell(farming2019class[[1]])
tot2019    # 345600

# percentage
p1984 <- farming_1984prop * 100 / tot1984
p1984

#      layer        value     count
# 1 0.0002893519 0.0002893519  7.408275
# 2 0.0002893519 0.0005787037 70.202257
# 3 0.0002893519 0.0008680556 22.389468

p2019 <- farming_2019prop * 100 / tot2019
p2019

#     layer        value      count
# 1 0.0002893519 0.0002893519 26.76157
# 2 0.0002893519 0.0005787037 13.52141
# 3 0.0002893519 0.0008680556 59.71701

# In conclusion, vegetation classes in 1984 had the following proportions: absent = 7.41 %, stressed = 70.20 %, healthy = 22.39 %.
# In 2019 the proportions were: absent = 26.76 %, stressed = 13.52 %, healthy = 59.72 %.
# Classes were chosen from the environmental elements that could be recognized by the images:
# absent vegetation is represented by cities and urban settlements, stressed one is represented by the fields where the canopy is absent due to regular cut of the grass,
# while healthy vegetation is represented by the farmland.


par(mfrow=c(2,1))
plotRGB(farming_1984, r=1, g=2, b=3) 
plotRGB(farming_2019, r=1, g=2, b=3)

# plot them with RGB in different bands
plotRGB(farming_1984, r=1, g=2, b=3)
plotRGB(farming_1984, r=2, g=3, b=1)
plotRGB(farming_1984, r=2, g=1, b=3)
plotRGB(farming_1984, r=3, g=2, b=1)

plotRGB(farming_2019, r=1, g=2, b=3)
plotRGB(farming_2019, r=2, g=3, b=1)
plotRGB(farming_2019, r=2, g=1, b=3)
plotRGB(farming_2019, r=3, g=2, b=1)

# multitemporal change detection 
farmingdif = farming_2019[[1]] - farming_1984 [[1]]   # diference
plot(farmingdif, col=cl) 

# select single bands 
plot(farming_1984[[1]]) # red
plot(farming_1984[[2]]) # green
plot(farming_1984[[3]]) # blue
plot(farming_1984[[1]]) # NIR

plot(farming_2019[[1]]) # red
plot(farming_2019[[2]]) # green
plot(farming_2019[[3]]) # blue
plot(farming_2019[[1]]) # NIR

# multiframe
c1 <- colorRampPalette(c("white", "darkblue", "black")) (100)
c2 <- colorRampPalette(c("white", "darkgreen", "black")) (100)
c3 <- colorRampPalette(c("white", "darkred", "black")) (100)
c4 <- colorRampPalette(c("white", "lightyellow", "tomato", "darkred")) (100)

par(mfrow=c(2,2)) #different bands from 2019
plot(farming_1984[[1]], col = c3) # red
plot(farming_1984[[2]], col = c2) # green
plot(farming_1984[[3]], col = c1) # blue
plot(farming_1984[[1]], col = c4) # NIR
dev.off()

par(mfrow=c(2,2)) #different bands from 2023
plot(farming_2019[[1]], col = c3) # red
plot(farming_2019[[2]], col = c2) # green
plot(farming_2019[[3]], col = c1) # blue
plot(farming_2019[[1]], col = c4) # NIR
dev.off()

# Pearson correlation between the bands
stack_farming_1984 <- c(farming_1984[[1]], farming_1984[[2]], farming_1984[[3]], farming_1984[[1]]) #1984
names(stack_farming_1984) <- c("red_1984","green_1984","blue_1984","NIR_1984")

stack_farming_2019 <- c(farming_2019[[1]], farming_2019[[2]], farming_2019[[3]], farming_2019[[1]]) #2019
names(stack_farming_2019) <- c("red_2019","green_2019","blue_2019","NIR_2019")

pairs(stack_farming_1984)
pairs(stack_farming_2019)

# Pearson correlation coefficient: the oblique line shows the graphical representation of the bands chosen.
# Under it, the correlation between the bands are portrayed: it is higher  between the visible bands, 
# while NIR adds more information. Over the oblique line, there are the values of the correlation 
# coefficient between the bands.

