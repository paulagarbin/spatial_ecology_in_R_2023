install.packages("vegan")   # vegetational analysis - vegan 
library(vegan)              # premute and lattice 

                            # two sets - one is related to dunes and plants in dunes - dataset called dunes 
# recall the data (dunes)
data(dune)                  # recall the data
dune                        # gives back the whole table in columns different species with their abundance in dunes 

head(dune)                  # header: it only gives back first 6 rows of data - like the preview of the beggining of the data
                            # and all the columns - 6 rows 

ord <- decorana(dune)       # assign decorana to an object (ord)
ord

# Call:
# decorana(veg = dune) 

# Detrended correspondence analysis with 26 segments.
# Rescaling of axes with 4 iterations.

#                   DCA1   DCA2
# Eigenvalues     0.5117 0.3036
# Decorana values 0.5360 0.2869
# Axis lengths    3.7004 3.1166            # we want to know the range of data on all axis 
#                    DCA3    DCA4
# Eigenvalues     0.12125 0.14267
# Decorana values 0.08136 0.04814
# Axis lengths    1.30055 1.47888

ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1 + ldc2 + ldc3 + ldc4

## percentage of the range of each axis 

# percentage of length of dc1 

pldc1 = ldc1 * 100/total
pldc2 = ldc2 * 100/total
pldc3 = ldc3 * 100/total
pldc4 = ldc4 * 100/total

pldc1 
pldc2 
pldc3
pldc4

pldc1+pldc2  # 71.03683 is the percentage of range of data in axis 1 and 2 - we only take those 2 and deal with them

# final output we will receive 
plot(ord)            # space defind by ldc1 and ldc2 
                     # species are plotted in a graph with 2 axis - moved from different plots in a new dimension 
                     # we can describe species in different systems - some stay together and are plotted one on the other 

# from the table we cannot see how species stay together and grow in the same area - but from the plots it is clear 
# for that we cannot use the whole dimensions (4 in this case) - we can only use 2 - 71% ones ldc1 and ldc2 and use it for multivariate analysis 
# in parts of the graph different species staying together in (grassland, wetland, etc.) 
