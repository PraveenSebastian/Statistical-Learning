
# Hierarchical Clustering.

# We will use these same data and use hierarchical clustering.

hc.complete=hclust(dist(x),method = "complete")
plot(hc.complete)
hc.single=hclust(dist(x) ,method = "single")
plot(hc.single)
hc.average=hclust(dist(x),method = "average")
plot(hc.average)

# Let's compare with the actually clusters in the data. We will use the function 'cuttree' to cut the tree at level 4.
# This will produce a vector of numbers from 1 to 4, saying which branch each observation is on. You will sometimes
# see pretty plots where the leaves of the dendrogram are closed. I searched a bit on the web for how to do this,
# and its a little too complicated for this demonstration.

# We can use 'table' to see how well they match:
  
hc.cut=cutree(hc.complete,4)
table(hc.cut,which)

table(hc.cut,km.out$cluster)


# Or we can use our group membership as labels for the leaves of the dendogram:

plot(hc.complete, labels = which)











