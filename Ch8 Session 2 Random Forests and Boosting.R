
# Random Forests and Boosting
# 
# These methods use trees as building blocks to build more complex models. Here we
# will use the Boston housing data to explore ranom forests and boosting.These data are
# in the 'Mass' package.
# It gives housing values and other statistics in each of 506 suburbs of Boston based on
# a 1970 census.

# Random forests
# 
# Random forests build lots of bushy trees, and then average them to reduce the variance.


require(randomForest)
require(MASS)
set.seed(101)
dim(Boston)
train=sample(1:nrow(Boston), 300)
?Boston

# Lets fit a random forest and see how well it performs. We will use the response 'medv',
# the median housing value (in \$1K dollars)

rf.boston=randomForest(medv~., data=Boston, subset=train)
rf.boston

# The MSR and % variance explained are based on OOB or _out-of-bag_ estimates, a 
# very clever device in random forests to get honest error estimates. The model reports
# that 'mtry=4', which is the number of variables randomly chosen at each split. Since
# $p=13$ here, we could try all 13 possible values of 'mtry'. We will do so, record
# the results, and make a plot.

oob.err=double(13)
test.err=double(13)
for(mtry in 1:13){
  fit=randomForest(medv~.,data=Boston,subset=train,mtry=mtry,ntree=400)
  oob.err[mtry]=fit$mse[400]
  pred=predict(fit,Boston[-train,])
  test.err[mtry]1=with(Boston[-train,],mean((medv-pred)^2))
  cat(mtry, " ")
}
matplot(1:mtry,cbind(test.err,oob.err),pch=19,col=c("red","blue"),type="b",ylab="Mean Squared Error")
legend("topright",legend=c("OOB","Test"),pch=19,col=c("red","blue"))


# Not very difficult! Allthough the test-error curve drops below the OOB curve, these
# are estimates based on data, and so have their own standard errors(which are typically quite large.)
# Notice that the points at the end with 'mtry=13' correspond to bagging.

# Boosting

# Boosting builds lots of smaller trees. Unlike random forests,each new tree in boosting
# tries to patch up the deficiencies of the current ensemble.

install.packages("gbm")
require(gbm)
boost.boston=gbm(medv~.,data=Boston[train,],distribution="gaussian",n.trees=10000
                 ,shrinkage=0.01,interaction.depth=4)
summary(boost.boston)
plot(boost.boston,i="lstat")
plot(boost.boston,i="rm")

# Lets make a prediction on the test set. With boosting, the number of trees is a tuning
# parameter,and if we have too many we can overfit. So we should use cross-validation
# to select the number of trees.We will leave this as an exercise. Instead, we will compute
# the test error as a function of the number of trees, and make a plot.

n.trees=seq(from=100,to=10000,by=100)
predmat=predict(boost.boston,newdata=Boston[-train,],n.trees=n.trees)
dim(predmat)
berr=with(Boston[-train,],apply((predmat-medv)^2,2,mean))
plot(n.trees,berr,pch=19,ylab="Mean Squared Error", xlab="# Trees", main="Boosting Test error")
abline(h=min(test.err),col="red")











