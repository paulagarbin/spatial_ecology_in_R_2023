# Indices derived from RS imagery

library(imageRy) # package developed at unibo
library(terra)

# library(ggplot2) (for Thursday)
# library(viridis)

im.list()

# we will use matogrosso_l5...

##### If we want the information about the data we are using:
# if we want information about the description of the files - go to repository in Duccio's github - and go into data.description 
# important for matogrosso - images from the NASA Earth Observatory 
# or copy the name of the image - matogrosso_l5... and put in in the internet - all the information are there 
# matogrosso is a place in Brasil - deforestation

im.import("matogrosso_l5_1992219_lrg.jpg")    # maintain the quotes 
                                              # landsat image - earth at 30 m resolution
                                              # 3 bands: 1 = NIR (near infra red), 2=RED, 3= GREEN

# name the image m1992 since it was taken in 1992 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") 
im.plotRGB(m1992, r=1, g=2, b=3)              # near infra red is on top of the red
im.plotRGB(m1992, 1, 2, 3)                    # the same thing, but better to put name of bands (r,g,b) for better understanding 

# the whole area in 1992 - complete tropical forest, already started to destroy it on the southern part

# green on the top
im.plotRGB(m1992, r=2, g=1, b=3)             # vegetation in green - ultra dense forest plus some bare soil 

# blue on the top
im.plotRGB(m1992, r=2, g=3, b=1)             # high amount of solid particles - water is in the middle - it should become black in infra red images
                                             # vegetation in blue

# import the recent image 
 m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=1, g=3, b=2)             # vegetation in red - much less 
im.plotRGB(m2006, r=2, g=3, b=1)             # yellow is overtaking - good to use yellow as soil 
                                             # humans managed to destroy everything 

# We will use this image to build vegetation index and see how pixels changed in time 



 






