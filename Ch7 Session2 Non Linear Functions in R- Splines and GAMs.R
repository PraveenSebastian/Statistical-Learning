

# Regression splines

# splines are more flexible than polynomials, but the idea is rather similar.
# 
# Here we will explore the cubic splines.

require(ISLR)
attach(Wage)
require(splines)
agelims = range(age)
age.grid=seq(from=agelims[1],to=agelims[2])

fit=lm(wage~bs(age, knots = c(25,40,60)), data = Wage)
plot(age,wage,col="darkgrey")
lines(age.grid, predict(fit,list(age=age.grid)),col="darkgreen",lwd=2)
abline(v=c(25,40,60), lty=2, col="darkgreen")


# The smoothing splines does not require knot selection, but it does have a smoothing 
# parameter, which can conveniently be specified via the effective degrees of freedom or 'df'

fit=smooth.spline(age,wage,df=16)
lines(fit, col="red", lwd=2)


# Or we can use the LOO cross-validation to select the smoothing paratmeter for us automatically.

fit=smooth.spline(age,wage,cv=TRUE)
lines(fit,col="purple",lwd=2)
fit



# Generalized Additive Models

# So far we have focused on fitting models with mostly single nonlinear terms.
 
# The 'gam' package makes it easier to work with multiple nonlinear terms. In addition it knows how to plot these functions and their standard errors.

#install.packages("gam")
require(gam)
gam1=gam(wage~s(age,df=4)+s(year,df=4)+education, data=Wage)

par(mfrow=c(1,3))
plot(gam1,se=T)
gam2=gam(I(wage>250)~s(age,df=4)+s(year,df=4)+education, data = Wage, family = binomial)

plot(gam2)

# Let's see if we need a nonlinear terms for year

gam2a=gam(I(wage>250)~s(age,df=4)+year+education, data = Wage, family = binomial)

anova(gam2a,gam2,test="Chisq")

#  One nice feature of the 'gam' package is that it knows how to plot the functions nicely,
# even for models fit by 'lm' and 'glm
par(mfrow=c(1,3))
lm1=lm(wage~ns(age,df=4)+ns(year,df=4)+education, data = Wage)
plot.gam(lm1,se=T)


















