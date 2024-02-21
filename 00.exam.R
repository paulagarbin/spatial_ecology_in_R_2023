# R PROJECT FOCUSING ON TEMPORAL ANALYSIS OF FRACTION OF GREEN VEGETATION COVER (FCOVER) AND NORMALIZED DIFFERENCE VEGETATION INDEX (NDVI) IN NILE DELTA 

# Packages

library (ncdf4)      # to import.nc files 
library (terra)      # geospatial data analysis for raster data
library (viridis)    # inclusive color palette for color blind people
library (ggplot2)    # to create appropriate graphs 
library (tidyterra)  # interface between terra and tidyverse
                     # to avoid issues with ggplot, error in fortify

# Setting working directory

setwd("C:/Users/Paula/Desktop/Spatial ecology in R/Project") 



## TEMPORAL ANALYSIS OF FRACTION OF GREEN VEGETATION COVER IN NILE DELTA FOR 2015-2019

# Importing data from Copernicus with function: rast()

fcover_2015 <- rast("fcover2015.nc")
fcover_2019 <- rast("fcover2019.nc")

# Cutting the map define the extent of the research

ext <- c(29,33,29.5,32) 
fcover2015.crop <- crop(fcover_2015, ext)
fcover2019.crop <- crop(fcover_2019, ext)

# Extracting FCOVER layer from the data

fcover_layer2015 <- fcover2015.crop[["FCOVER"]]
fcover_layer2019 <- fcover2019.crop[["FCOVER"]]

plot(fcover_layer2015)
plot(fcover_layer2019)

# Plotting using ggplot2

ggplot2015 <- ggplot() + 
  geom_raster(fcover_layer2015, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") + 
  ggtitle("Fraction of Green Vegetation Cover 2015") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9),  plot.title = element_text(size = 11))

ggplot2019 <- ggplot() + 
  geom_raster(fcover_layer2019, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") + 
  ggtitle("Fraction of Green Vegetation Cover 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9),  plot.title = element_text(size = 11))

ggplot2015
ggplot2019

# Calculating difference between years to see the changes 

dif2015_2019 <- fcover_layer2019 - fcover_layer2015

# Plotting the difference between 2015 and 2019 using ggplot2

ggplot_dif2015_2019 <- ggplot() + 
  geom_raster(dif2015_2019, mapping = aes(x = x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") + ggtitle("FCOVER Change: 2015 - 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9)) 

ggplot_dif2015_2019

# Pixel estimation
# Total pixel estimation

total_pixels_2015 <- ncell(fcover_layer2015)
total_pixels_2019 <- ncell(fcover_layer2019)

# Calculation of n. of pixels for values in FCOVER higher than 0 
# Data extraction and exclusion of missing values

vegetation_pixels_2015 <- sum(fcover2015.crop[["FCOVER"]][] > 0, na.rm = TRUE)
vegetation_pixels_2019 <- sum(fcover2019.crop[["FCOVER"]][] > 0, na.rm = TRUE)

# Calculation of the percentage of vegetation cover over the total pixels

percentage_cover_2015 <- (vegetation_pixels_2015 / total_pixels_2015) * 100
percentage_cover_2019 <- (vegetation_pixels_2019 / total_pixels_2019) * 100

percentage_cover_2015   # 65.88 % 
percentage_cover_2019   # 65.53 %


# Difference in percentage cover in 4 years 

percentage_cover_2019 - percentage_cover_2015  
                       # - 0.35 % 



## SEASONAL ANALYSIS OF FCOVER DURING WINTER-SUMMER SEASONS

## 2015 

summer_2015 <- rast("fcover2015summer.nc")
winter_2015 <- rast("fcover2015winter.nc")

# Cutting the map define the extent of the research

ext <- c(29,33,29.5,32) 
summer_2015.crop <- crop(summer_2015, ext)
winter_2015.crop <- crop(winter_2015, ext)

# Extracting FCOVER layer from the data

summer_layer2015 <- summer_2015.crop[["FCOVER"]]
winter_layer2015 <- winter_2015.crop[["FCOVER"]]

plot(summer_layer2015)
plot(winter_layer2015)

# Creating a multiframe to visualise the difference 

par(mfrow= c(1,2)) 
plot(summer_layer2015, main="summer 2015", cex.main = .8)
plot(winter_layer2015, main="winter 2015", cex.main = .8)

# Plotting using ggplot2

ggplot_summer2015 <- ggplot() + 
  geom_raster(summer_layer2015, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Fraction of Green Vegetation Cover in Summer 2015") +
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 10, face = "bold"))

ggplot_winter2015 <- ggplot() + 
  geom_raster(winter_layer2015, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Fraction of Green Vegetation Cover in Winter 2015") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 10, face = "bold"))

ggplot_summer2015
ggplot_winter2015

# Calculating difference between years to see the changes 

dif_seasons_2015 <- winter_layer2015 - summer_layer2015

# Plotting the differences using ggplot2 

ggplot_dif_seasons_2015 <- ggplot() + 
  geom_raster(dif_seasons_2015, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("FCOVER Seasonal Change in 2015") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 12, face = "bold"))

ggplot_dif_seasons_2015   # An increase in vegetation during winter season in Egypt is due to extreme
                          # temperatures and very low precipitation in summer months.

# Pixel estimation
# Total pixel estimation

total_pixels_summer2015 <- ncell(summer_layer2015)
total_pixels_winter2015 <- ncell(winter_layer2015)

# Calculation of n. of pixels for values in FCOVER higher than 0.5  
# Data extraction and exclusion of missing values

vegetation_pixels_summer2015 <- sum(summer_2015.crop[["FCOVER"]][] > 0.5, na.rm = TRUE)
vegetation_pixels_winter2015 <- sum(winter_2015.crop[["FCOVER"]][] > 0.5, na.rm = TRUE)

# Calculation of the percentage of vegetation cover over the total pixels

percentage_cover_summer2015 <- (vegetation_pixels_summer2015 / total_pixels_summer2015) * 100
percentage_cover_winter2015 <- (vegetation_pixels_winter2015 / total_pixels_winter2015) * 100

percentage_cover_summer2015  #  4.89 % 
percentage_cover_winter2015  # 11.96 %
                             # FCOVER < 0.5 is roughly the same in both seasons
                             # but the values > 0.5 are much higher in winter months 


## 2019

summer_2019 <- rast("fcover2019summer.nc")
winter_2019 <- rast("fcover2019winter.nc")

# Cutting the map define the extent of the research

ext <- c(29,33,29.5,32) 
summer_2019.crop <- crop(summer_2019, ext)
winter_2019.crop <- crop(winter_2019, ext)

# Extracting FCOVER layer from the data

summer_layer2019 <- summer_2019.crop[["FCOVER"]]
winter_layer2019 <- winter_2019.crop[["FCOVER"]]

plot(summer_layer2019)
plot(winter_layer2019)

# Plotting using ggplot2

ggplot_summer2019 <- ggplot() + 
  geom_raster(summer_layer2019, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Fraction of Green Vegetation Cover in Summer 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 10, face = "bold"))

ggplot_winter2019 <- ggplot() + 
  geom_raster(winter_layer2019, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("Fraction of Green Vegetation Cover in Winter 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 10, face = "bold"))

ggplot_summer2019
ggplot_winter2019

# Calculating difference between years to see the changes 

dif_seasons_2019 <- winter_layer2019 - summer_layer2019

# Plotting the differences using ggplot2 

ggplot_dif_seasons_2019 <- ggplot() + 
  geom_raster(dif_seasons_2019, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("FCOVER Seasonal Change in 2019") +  
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 12, face = "bold"))

ggplot_dif_seasons_2019   

# Gaining FCOVER in winter months 

# Pixel estimation
# Total pixel estimation

total_pixels_summer2019 <- ncell(summer_layer2019)
total_pixels_winter2019 <- ncell(winter_layer2019)

# Calculation of n. of pixels for values in FCOVER higher than 0.5 
# Data extraction and exclusion of missing values

vegetation_pixels_summer2019 <- sum(summer_2019.crop[["FCOVER"]][] > 0.5, na.rm = TRUE)
vegetation_pixels_winter2019 <- sum(winter_2019.crop[["FCOVER"]][] > 0.5, na.rm = TRUE)

# Calculation of the percentage of vegetation cover over the total pixels

percentage_cover_summer2019 <- (vegetation_pixels_summer2019 / total_pixels_summer2019) * 100
percentage_cover_winter2019 <- (vegetation_pixels_winter2019 / total_pixels_winter2019) * 100

percentage_cover_summer2019   # 5.68 % 
percentage_cover_winter2019   # 9.95 %
                              # FCOVER values > 0.5 are still higher in winter months
                              # however, summer FCOVER has increased from 2015 and winter has decreased 
                              # Smaller range suggests the extreme temperatures in summer and milder winters
                              # as a consequence of climate change. 



## NDVI ASSESSMENT OF NILE  DELTA FOR 2015-2019

# Importing data from Copernicus with function: rast()

NDVI_2015 <- rast("NDVIdecember2015.nc")
NDVI_2019 <- rast("NDVIdecember2019.nc")

# Cutting the map define the extent of the research

NDVI2015.crop <- crop(NDVI_2015, ext)
NDVI2019.crop <- crop(NDVI_2019, ext)

# Extracting FCOVER layer from the data

NDVI_layer2015 <- NDVI2015.crop[["NDVI"]]
NDVI_layer2019 <- NDVI2019.crop[["NDVI"]]

plot(NDVI_layer2015)
plot(NDVI_layer2019)

# ggplot
ggplotNDVI2015 <- ggplot() + 
  geom_raster(NDVI_layer2015, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "mako") +
  ggtitle("Normalized Difference Vegetation Index 2015") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 11, face = "bold"))

ggplotNDVI2019 <- ggplot() + 
  geom_raster(NDVI_layer2019, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "mako") +
  ggtitle("Normalized Difference Vegetation Index 2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 11, face = "bold"))

ggplotNDVI2015
ggplotNDVI2019

# Calculating difference between years to see the changes 

dif_NDVI <- NDVI_layer2019 - NDVI_layer2015

# Plotting the differences using ggplot2 

ggplot_dif_NDVI <- ggplot() + 
  geom_raster(dif_NDVI, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "magma") + ggtitle("NDVI Change: 2015-2019") + 
  labs(x = "Longitude", y = "Latitude") + theme(axis.text = element_text(size = 7),
  axis.title = element_text(size = 9), plot.title = element_text(size = 11, face = "bold")) 

ggplot_dif_NDVI


