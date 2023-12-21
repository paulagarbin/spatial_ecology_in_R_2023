### Multivariate analysis
# Principal component analysis 

library(imageRy)
library(viridis)
library(terra)

im.list()

sent <- im.import("sentinel.png")
pairs(sent)         # hard to read 
                    # red and the green are corellated to each other by 0.98 pearson coefficient - from 0 to 1 ranges 
                    # near infra red is less correlated to other bands - adding additional information
                    # last row - sent 4 is just control - can be removed or kept as constant

# perform PCA on sent 
sentpc <- im.pca2(sent)     
sentpc              # we can see first component is called PC1 and we can isolate it

pc1 <- sentpc$PC1 
plot(pc1)

# let's use viridis legend 
viridisc <- colorRampPalette(viridis(7)) (255)
plot(pc1, col=viridisc)

# Calculating standard deviation on top of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd) 
plot(pc1sd3, col=viridisc)                       # similar to infra red but calculated to objectively selected layer 

# plot in 7x7 window
pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)


### plot all of them together
par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)      # near infra red on top of the green
# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)     # 7 images inside final plot

# stack all the standard deviation layers 
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7) 
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")      # adding names to all 4 plots 
plot(sdstack, col=viridisc)

