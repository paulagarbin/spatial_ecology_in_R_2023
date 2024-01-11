# simulating colour blind vision
library(devtools)
library(colorblindr)
library(ggplot2)

devtools::install_github("clauswilke/colorblindr")  # function install github - this function is coming from devtools 

iris
head(iris)

fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha = 0.7)
fig

cvd_grid(fig)
