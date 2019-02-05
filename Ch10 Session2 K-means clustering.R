
# K-means clustering

# K-means works in any dimension,but is most fun to demonstrate in two, because we can plot pictures.

# Let's make some data with clusters. We do this by shifting the means of the points around.

set.seed(101)
x=matrix(rnorm(100*2),100,2)
xmean=matrix(rnorm(8,sd=4),4,2)
which=sample(1:4,100,replace = TRUE)
x=x+xmean[which,]
plot(x,col=which,pch=19)


# We know the "true" cluster IDs, but we won't tell that to the 'kmeans' algorithm.

km.out=kmeans(x,4,nstart=15)
km.out
plot(x,col=km.out$cluster,cex=2,pch=1,lwd=2)
points(x,col=which,pch=19)
points(x,col=c(4,3,2,1)[which],pch=19)







