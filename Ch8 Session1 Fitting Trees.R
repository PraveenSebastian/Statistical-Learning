


# Decision Trees

# We will have a look at the 'Carseats' data using the 'tree' package in R, as in the 
 # lab in the book.
 
# We create a binary response variable 'High' (for high sales), amd we include it in
# the same dataframe.

require(ISLR)
require(tree)
attach(Carseats)
hist(Sales)
High=ifelse(Sales <=8, "No", "Yes")
Carseats=data.frame(Carseats, High)
colnames(Carseats)


# Now we fit a tree to these data, and summarize and plot it. Notice that we have to exclude

# 'Sales' from the right-hand side of the formula, because the response is derived from it.

tree.carseats=tree(High~.-Sales, data = Carseats)
summary(tree.carseats)
plot(tree.carseats)  
text(tree.carseats, pretty=0)
# For a detailed summary of the tree print it
tree.carseats

# Let's create a training and test set (250, 150) split of the 400 observations, grow
# the tree on the training set, and evaluate its performance on the test set.
set.seed(1011)
train=sample(1:nrow(Carseats),250)
tree.carseats=tree(High~.-Sales, data =Carseats,subset = train )
plot(tree.carseats);text(tree.carseats,pretty=0)
tree.pred=predict(tree.carseats, Carseats[-train,], type = "class")
with(Carseats[-train,],table(tree.pred,High))
(72+33) / 150

# This tree was grown to full depth, and might be too variable. We now use CV to prune it.

cv.carseats=cv.tree(tree.carseats, FUN=prune.misclass)
cv.carseats
plot(cv.carseats)

prune.carseats=prune.misclass(tree.carseats, best=13)
plot(prune.carseats);text(prune.carseats,pretty=0)

# Now let's evaluate this pruned tree on the test data.
tree.pred=predict(prune.carseats, Carseats[-train,], type = "class")
with(Carseats[-train,],table(tree.pred,High))

# It has done about the same as our original tree. So pruning did not hurt us wrt
# misclassification errors, and gave us a simpler tree.










