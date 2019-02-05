
# Nonlinear SVM

# Instead, we will run the SVM on some data where a non-linear boundary is called for.
# We will use the mixture data from ESL

load(url("http://www-stat.stanford.edu/~tibs/ElemStatLearn/datasets/ESL.mixture.rda"))

names(ESL.mixture)
rm(x,y)
attach(ESL.mixture)

# These data are also two dimensional. Lets plot them and fit a
# non linear SVM, using a radial kernel.

plot(x,col=y+1)
dat=data.frame(y=factor(y),x)
fit=svm(factor(y)~.,data=dat,scale=FALSE,kernel="radial",cost=5)

# Now we are going to create a grid, as before, and make predictions on the grid.
# These data have the grid points for each variable included on the data frame.

xgrid=expand.grid(X1=px1,X2=px2)
ygrid=predict(fit,xgrid)
plot(xgrid,col=as.numeric(ygrid),pch=20,cex=.2)

points(x,col=y+1,pch=19)

# We can go further, and have the predict function produce the actual function estimates at each of our
# grid points. We can include the actual decision boundary on the plot by making use of the contour function.
# On the data frame is also 'prob', which is the true probability of class 1 for these data, at the gridpoints.
# 
# If we plot its 0.5 contour, that will give us the _Bayes Decision Boundary_, which is the best one could ever do.

func=predict(fit,xgrid,decision.values = TRUE)
func=attributes(func)$decision
xgrid=expand.grid(X1=px1,X2=px2)
ygrid=predict(fit,xgrid)

plot(xgrid,col=as.numeric(ygrid),pch=20,cex=.2)
points(x,col=y+1,pch=19)

contour(px1,px2,matrix(func,69,99),level=0,add=TRUE)
contour(px1,px2,matrix(prob,69,99),level=.5,add=TRUE,col="blue", lwd=2)


























