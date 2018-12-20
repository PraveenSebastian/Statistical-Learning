
library(ISLR)
summary(Hitters)

Hitters=na.omit(Hitters)
with(Hitters, sum(is.na(Salaray)))

# Best Subset regression

install.packages("leaps")
library(leaps)

regfit.full=regsubsets(Salary~.,  data = Hitters)
summary(regfit.full)

regfit.full=regsubsets(Salary~., data = Hitters, nvmax=19)
reg.summary=summary(regfit.full)
names(reg.summary)

plot(reg.summary$cp, xlab = "Number of variables", ylab = "Cp")
which.min(reg.summary$cp)
points(10,reg.summary$cp[10],pch=20,col="red")

plot(regfit.full,scale = "Cp")
coef(regfit.full,10)
 


