library(dplyr)


# Model selection using a validtation set
# Let's make a training and validation set, so that we can choose a good subset model

dim(Hitters)
set.seed(1)
train=sample(seq(263),180, replace = FALSE)

regfit.frwd=regsubsets(Salary~.,data = Hitters[train,],nvmax=19,method="forward")


#Let's make predictions now.There is no predict method for regsubsets
val.errors=rep(NA,19)
x.test=model.matrix(Salary~.,data=Hitters[-train])
for(i in 1:19){
  coefi=coef(regfit.frwd,id=i)
  pred=x.test[, names(coefi)]%*% coefi
  val.errors[i]=mean((Hitters$Salary[-train]-pred)^2)
}

plot(sqrt(val.errors), ylab = "Root MSE",ylim = c(300,400),pch=19,type = "b")
points(sqrt(regfit.frwd$rss[-1]/180),col="blue",pch=19,type="b")
legend("topright",legend = c("Training","validation"),col=c("blue","black"), pch=19)

#Training error goes down as the model gets bigger but not so for testing error

# We will write a function for predict
predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form,newdata)
  coefi=coef(object,id=id)
  mat[,names(coefi)]%*%coefi
}



