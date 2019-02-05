
# Principal Components
 
# We will use the 'USArrests' data

dimnames(USArrests)
apply(USArrests,2,mean)
apply(USArrests,2, var)



# We see that 'Assault' has a much larger variance than the other variables.

# It would dominate the principal components, so we choose to standardize the variables when we perform PCA.


pca.out=prcomp(USArrests, scale=TRUE)
pca.out
names(pca.out)
biplot(pca.out,scale = 0,cex=.6)
