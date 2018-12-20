
require(ISLR)
attach(Wage)

# First we will use polynomials, and focus on a single predictor age:

fit=lm(wage~poly(age,4), data=Wage)
summary(fit)

# The 'poly' function generates a basis of *orthogonal polynomials*.
# Let's make a plot of the fitted function, along with the standard errors of the fit

agelims = range(age)
age.grid=seq(from=agelims[1],to=agelims[2])
preds=predict(fit,newdata = list(age=age.grid),se=TRUE)
se.bands=cbind(preds$fit+2*preds$se,preds$fit-2*preds$se)
plot(age,wage,col="darkgrey")
lines(age.grid,preds$fit,lwd=2,col="blue")
matlines(age.grid,se.bands,col="blue",lty=2)

# There are other more direct ways of doing this in R. For example
fita=lm(wage~age+I(age^2)+I(age^3)+I(age^4), data=Wage)
summary(fita)

plot(fitted(fit), fitted(fita))
summary(fit)

fita=lm(wage~education, data = Wage)
fitb=lm(wage~education+age, data = Wage)
fitc=lm(wage~education+poly(age,2), data = Wage)
fitd=lm(wage~education+poly(age,3),data = Wage)
anova(fita,fitb,fitc,fitd)

###Polynomial logistic regression

# # Now we fit a logistic regression model to a binary  response variable,
# constructed from 'wage'. We code the big earners (>'250K') as 1, else 0

fit=glm(I(wage>250) ~ poly(age,3), data=Wage, family="binomial")
summary(fit)
preds=predict(fit,list(age=age.grid),se=T)
se.bands=preds$fit + cbind(fit=0, lower=-2*preds$se, upper=2*preds$se)
se.bands[1:5,]

# ## We have done the compuatations on the logit scale. To
# transform we need to apply the inverse logit mapping

# p=frac{e^\eta}{1+e^\eta}
# We can do this simultaneously for all three columns of 'se.bands'

prob.bands=exp(se.bands)/(1+exp(se.bands))
matplot(age.grid,prob.bands,col="blue",lwd=c(2,1,1),lty=c(1,2,2),
        type="1",ylim=c(0,0.1))
points(jitter(age),I(wage>250)/10,pch="I",cex=0.5)













  
  






