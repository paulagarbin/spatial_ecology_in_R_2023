#vegetation properties 2016 s 
fcover_2015 <- rast("c_gls_FCOVER-RT6_201507100000_GLOBE_PROBAV_V2.0.2.nc")
plot(fcover_2015)

plot(fcover_2015[[1]])
ext <- c(28,34,23,33)    
fcover_2015_crop <- crop(fcover_2015, ext)
plot(fcover_2015_crop[[1]])

# vegetation properties 2020
fcover <- rast("fcover.nc")
plot(fcover)

plot(fcover[[1]])
ext <- c(28,34,23,33)   
fcover_crop <- crop(fcover, ext)
plot(fcover_crop[[1]])

## plotting the two together 
par(mfrow=c(1,2))             # this will build empty frame with two slots  
plot(fcover_2015_crop[[1]]) 
plot(fcover_crop[[1]])

## soil water index - 2015
soilwater_index <- rast("c_gls_SWI_201512161200_GLOBE_ASCAT_V3.1.1.nc")
plot(soilwater_index)

plot(soilwater_index[[2]])
ext <- c(28,34,23,33)  
soilwater_index_crop <- crop(soilwater_index, ext)
plot(soilwater_index_crop[[2]])

dev.off()

## soil water index - 2020
soilwater_index2020 <- rast("c_gls_SWI_202007191200_GLOBE_ASCAT_V3.1.1.nc")
plot(soilwater_index2020)

plot(soilwater_index2020[[2]])
ext <- c(28,34,23,33)  
soilwater_index2020_crop <- crop(soilwater_index2020, ext)
plot(soilwater_index2020_crop[[2]])

# plotting the two together 
cl <- colorRampPalette(c("lightgreen","darkgreen","darkblue")) (100)
par(mfrow=c(1,2))              
plot(soilwater_index_crop[[2]], col=cl) 
plot(soilwater_index2020_crop[[2]], col=cl)

dev.off()

## dry matter productivity - 2015
drymatter_2015 <- rast("c_gls_DMP-RT6_201508310000_GLOBE_PROBAV_V2.0.1.nc")
plot(drymatter_2015)

plot(drymatter_2015[[1]])
ext <- c(28,34,23,33)  
drymatter_2015_crop <- crop(drymatter_2015, ext)
plot(drymatter_2015_crop[[1]])


## dry matter productivity - 2020
drymatter_2020 <- rast("c_gls_DMP-RT2_202005100000_GLOBE_PROBAV_V2.0.1.nc")
plot(drymatter_2020)

plot(drymatter_2020[[1]])
drymatter_2020_crop <- crop(drymatter_2020, ext)
plot(drymatter_2020_crop[[1]])

## plotting the two together 
par(mfrow=c(1,2))
plot(drymatter_2015_crop[[1]]) 
plot(drymatter_2020_crop[[1]])

dev.off()

# calculating the difference in dry matter productivity
diff.drymatter <- drymatter_2020_crop - drymatter_2015_crop
cl1 <- colorRampPalette(c("white","gray","black")) (100)
plot(diff.drymatter[[1]], col=cl1) 

