# Here I can write anything I want! Everyone can see the code and we need to write comments.

# R as a calculator 
2+3

# Assign to an object 
zima <- 2+3
zima

duccio <- 5+3 
duccio 

final <- zima*duccio 
final

final^2

# array 
sofi <- c(10, 20, 30, 50, 70) #microplastics 
                              #functions have parenthesis and inside of them are arguments making an array 

paula <- c(100, 500, 600, 1000, 2000)   #people 

plot(paula, sofi)
plot(paula, sofi, xlab="number of people", ylab="microplastics")

#assigning to the other object to plot easier
people <- paula 
microplastics <- sofi

plot(people, microplastics)
#to add the filled circles we add pch = there is an explanation online and you can pick any number
plot(people, microplastics, pch=19)
plot(people, microplastics, pch=19, cex=2)     #cex is size of the data points
plot(people, microplastics, pch=19, cex=2, col="yellow")   #colour change is col="colour"





