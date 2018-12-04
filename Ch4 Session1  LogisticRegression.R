

heartfit <- glm(chd~., data = heart, family = binomial)
summary(heartfit)

