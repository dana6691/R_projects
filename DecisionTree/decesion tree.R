#------------------------------------------------------------------#
#decision tree
#------------------------------------------------------------------#
# Classification Tree with rpart
library(rpart)

#import file
library(readxl)
in4 <- read_excel("N:/DaheeKim/survival_SAS/in4.xlsx")
View(in4)
# grow tree 
fit <- rpart(cause ~  race + srvtime + age + stage,
             method="anova", data=in4)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# plot tree 
plot(fit, uniform=TRUE, 
     main="Classification Tree for Kyphosis")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# create attractive postscript plot of tree 
post(fit, file = "c:/tree.ps", 
     title = "Classification Tree for Kyphosis")
#------------------------------------------------------------------#
# prune the tree 
pfit<- prune(fit, cp=   fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])

# plot the pruned tree 
plot(pfit, uniform=TRUE, 
     main="Pruned Classification Tree for Kyphosis")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)
post(pfit, file = "c:/ptree.ps", 
     title = "Pruned Classification Tree for Kyphosis")
#------------------------------------------------------------------#
# Regression Tree Example
library(rpart)

# grow tree 
fit <- rpart(cause ~  race + srvtime + age + stage,
             method="anova", data=in4)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# create additional plots 
par(mfrow=c(1,2)) # two plots on one page 
rsq.rpart(fit) # visualize cross-validation results  	

# plot tree 
plot(fit, uniform=TRUE, 
     main="Regression Tree for Mileage ")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# create attractive postcript plot of tree 
post(fit, file = "c:/tree2.ps", 
     title = "Regression Tree for Mileage ")
#------------------------------------------------------------------#
# prune the tree 
pfit<- prune(fit, cp=0.01160389) # from cptable   

# plot the pruned tree 
plot(pfit, uniform=TRUE, 
     main="Pruned Regression Tree for Mileage")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)
post(pfit, file = "c:/ptree2.ps", 
     title = "Pruned Regression Tree for Mileage")
#------------------------------------------------------------------#
# Conditional Inference Tree for Kyphosis
library(party)
fit <- ctree(cause ~  race + srvtime + age + stage, 
             data=in4)
plot(fit, main="Conditional Inference Tree for Kyphosis")
#------------------------------------------------------------------#
# Conditional Inference Tree for Mileage
library(party)
fit2 <- ctree(srvtime~cause + race + age + stage, 
              data=in4)
plot(fit2, main="Conditional Inference Tree for Kyphosis")
#------------------------------------------------------------------#
# Random Forest prediction of Kyphosis data
library(randomForest)
fit <- randomForest(cause ~  race + srvtime + age + stage,   data=in4)
print(fit) # view results 
importance(fit) # importance of each predictor
