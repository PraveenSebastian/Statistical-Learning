
# Ridge Regression and the Lasso
# We will use the package 'glmnet' which does not use the model formula language, so we will set up an 'x' and 'y'
#install.packages("glmnet")
library(glmnet)
x=model.matrix(Salary~.-1, data=Hitters)
y=Hitters$Salary

# First we will fit a ridge-regression model. This is achieved by calling 'glmnet' with 'alpha=0'
# There is also a 'cv.glmnet' function which will do the cross-validation for us.

fit.ridge=glmnet(x,y,alpha=0)
plot(fit.ridge,xvar="lambda",label=TRUE)
cv.ridge=cv.glmnet(x,y,alpha=0)
plot(cv.ridge)

# Now we fit a laso model : for this we use the default 'alpha=1'

fit.lasso=glmnet(x,y)
plot(fit.lasso,xvar="lambda", label=TRUE)
cv.lasso=cv.glmnet(x,y)
plot(fit.lasso,xvar="dev",label=TRUE)
plot(cv.lasso)
coef(cv.lasso)

# Suppose we want to use our earlier train/validation division to select the 'lambda' for the lasso.
# This is easy to do.

lasso.tr=glmnet(x[train,],y[train,])
lasso.tr
pred=predict(lasso.tr,x[-train,])
dim(pred)
rmse=sqrt(apply((y[-train]-pred)^2,2,mean))
plot(log(lasso.tr$lambda),rmse,type="b",xlab="Log(lambda)")
lam.best=lasso.tr$lambda[order(rmse)[1]]
lam.best
coef(lasso.tr,s=lam.best)










  
