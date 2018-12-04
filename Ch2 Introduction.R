

setwd("E:/R/Stanford")

x= c(2,7,5)

x

y = seq(from = 4, length = 3, by = 3)

?seq


y[2:3]

x/y

x+y

x*y


y[2]


# Remove element at 2nd position from vector y
y[-2]


z <- matrix(seq(1:12),4,3)

z

z[3:4,2:3]

z[,2:3]


z[,1]

z[,1,drop = FALSE]

dim(z)

ls()

rm(y)

ls()

x=runif(50)

x

y=rnorm(50)

y

plot(x,y)

plot(x,y, xlab = "Random Uniform", ylab = "Random Normal", pch = "*", col = "blue")

par(mfrow = c(2,1))

plot(x, y)

hist(y)

par(mfrow = c(1,1))

plot(x,y)

hist(y)

search()

help(summary)
