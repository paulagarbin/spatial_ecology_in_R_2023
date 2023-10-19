# camera traps data
# data from Kerinci-Seblat National Park in Sumatra, Indonesia (Ridout and Linkie, 2009)
# Ridout MS, Linkie M (2009). Estimating overlap of daily activity patterns from camera trap data. 
# Journal of Agricultural, Biological, and Environmental Statistics, 14(3), 322–337.

install.packages("overlap")
library(overlap)     # https://cran.r-project.org/web/packages/overlap/vignettes/overlap.pdf  we are using part of the vignette - and we will build some of those graphs

# relation among species in space - use multivariate analysis (previous lecture)
# relation among species in time 

# data
data(kerinci)
head(kerinci)       # first 6 rows - it shows zone - species - time 
kerinci             # to see the whole dataset 
summary (kerinci)   # general information about the dataset - we dont need it its just to see

# let's see how species 'tiger' has moved throughout the day 
# tiger
tiger <- kerinci[kerinci$Sps == "tiger",]       # now we need the comma at the end of parenthesis to end 
                                                # in sequel - final symbol is ; but in R is just comma , 
tiger                                           # new data set with only data connected to "tiger" 

# we should pass time to radians - multiply original time by 2*pi 
# The unit of time is the day, so values range from 0 to 1. 
# The package overlap works entirely in radians: fitting density curves uses trigonometric functions (sin, cos, tan),
# so this speeds up simulations. The conversion is straightforward: 
kerinci$Time * 2 * pi
kerinci$timeRad <- kerinci$Time * 2 * pi       # add new colum with this calculation 

# to add a new column in the datset you assign calculation to a new object
# then it is immediatly in the dataset since you put it kerinci$timeRad - new name assigned in the dataset

head(kerinci)       # new column aded - time passed to radians (ratio between a line and radius of a circumfernece) 

# now remake tiger 
tiger <- kerinci[kerinci$Sps == "tiger",] 
head(tiger)                        # new dataset tiger with additional column 

# final plot of the "tiger" 
plot(tiger$timeRad)                # plot tiger and time radians 


timetig <- tiger$timeRad           # assigning the tiger and time to timetig 
densityPlot(timetig, rug=TRUE)     # function showing amount of time in analysis 
                                   # density of tiger in 24 h - radians are now clockwise (24hour clock)
                                   # in the plot night - sleeping - peak in the morning - hunting - relax - increaase again- decrease sleep again 


# exercise: select only the data on "macaque"
macaque <- kerinci [kerinci$Sps == "macaque",]
head(macaque)

timemac <- macaque$timeRad
densityPlot(timemac, rug=TRUE)    # different from tigers - they had 2 peaks during the day 
                                  # macaque sleeps a lot more than tiger - and then wakes up and peaks around noon and slowly falls down - one peak


# what is the moment when it is dangerous for macaque - when tiger is awake and hunting
# overlap!
overlapPlot(timetig, timemac)  # coloured part of the graph is both distributions overlap - dangerous for macaque and lunchtime for tigers 
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')    



