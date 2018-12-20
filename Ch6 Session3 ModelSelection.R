
# Model Selection bu Cross-Validation

# We will do 10-fold cross validation
library(ISLR)
head(Hitters)
library(leaps)
set.seed(11)
folds=sample(rep(1:10,length=nrow(Hitters)))
folds
table(folds)
cv.errors=matrix(NA,10,19)
for(k in 1:10){
 best.fit=regsubsets(Salary~.,data=Hitters[folds!=k,], nvmax=19,method="forward")
for(i in 1:19) {
  pred=predict(best.fit,Hitters[folds==k,],id=i)
  cv.errors[k,i]=mean( (Hitters$Salary[folds==k]-pred)^2)
}
}
rmse.cv=sqrt(apply(cv.errors,2,mean))
plot(rmse.cv,pch=19,type="b")
