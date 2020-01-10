##########################################################################
#Tank Assignment(randomizr package)
##########################################################################
library(randomizr)
library(readxl)
data <- read_excel("N:/DaheeKim/December/TankAssignment.xlsx",sheet="Adjusted_Data")
data = na.omit(data)
data = data[,-6]
data$Location3 <- paste(data$Location, "_", data$Location2)

loop <- 1
pvalue <- 0.8
while(pvalue < 0.9){
  data$Treatment <- block_ra(blocks = data$Location3, num_arms = 18
                ,conditions = c("A","B","C","D","E","F","G","Ctrl_1", "Ctrl_2","H","K","L","P","Q","R","X","Y","Z"))
  table(data$Location3, data$Treatment)
  
  a1 <- aov(Individual ~ Treatment,data) 
  pvalue <- summary(a1)[[1]][["Pr(>F)"]][1]
  print(pvalue)
  loop = loop+1
  print(loop)
}
boxplot(Individual ~ Treatment, data=data, main="treatments")  # clear pattern is noticeable.
outlier_values <- boxplot.stats(data$'Individual')$out  # outlier values.
boxplot(data$'Individual', main="Pressure Height", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)

#coeeficient of variance 
library(goeveg)
cv(data$Group_Weight, na.rm = TRUE)
####################################################################
#one way ANOVA
###################################################################
a1 <- aov(Individual ~ (data$Treatment),data) 
summary(a1)
TukeyHSD(a1)

library(dplyr)
data %>%
  group_by(Treatment) %>%
  summarise(mean=mean(Weight))

library(multcomp)
data$Treatment2 <- as.factor(data$Treatment)
init.aov <- aov(Individual ~ Treatment2, data = data)
init.glt <- summary(glht(init.aov, linfct = mcp(Treatment2 = "Tukey")))
init.cld <- cld(init.glt)
plot(init.cld)
plot(init.aov)

kruskal.test(Individual ~ Treatment, data = data)
pairwise.wilcox.test(data$Individual, data$Treatment,
                     p.adjust.method = "BH")
##########################################################################
skew <- function(x) {
  m3 <- mean((x-mean(x))^3)
  skew <- m3/(sd(x)^3)
  skew
}
skew(data$'Individual')
kurtosis <- function(x) {
  m4 <- mean((x-mean(x))^4)
  8
  kurt <- m4/(sd(x)^4)-3
  kurt
}
kurtosis(data$'Individual')
##########################################################################
#QQplot
library(ggplot2)
qqnorm(data$'Individual')
qqline(data$'Individual',col="red")

# 90% confidence interval
SE.x = sd(data$Individual) / sqrt(length(data$Individual))
mean.int.90 <- mean(data$Individual) + qt( c(0.05, 0.95), length(data$Individual) - 1) * SE.x
mean.int.90
# 80% confidence interval
mean.int.80 <- mean(data$Individual) + qt( c(0.1, 0.9), length(data$'Individual') - 1) * SE.x
mean.int.80

#Outlier
boxplot(Individual ~ Treatment, data=data, main="treatments")  # clear pattern is noticeable.
outlier_values <- boxplot.stats(data$'Individual')$out  # outlier values.
boxplot(data$'Individual', main="Pressure Height", boxwex=0.1)
mtext(paste("Outliers: ", paste(outlier_values, collapse=", ")), cex=0.6)
##########################################################################
#Tank Assignment for Finished Experiment
##########################################################################
library(randomizr)
library(readxl)
data <- read_excel("N:/DaheeKim/December/Copy of Termination data.xlsx",sheet="Sheet2")
data <- subset(data, select=-c(Treatment,Treatment2))
head(data)
#Top only
#Initial significant, ADG is not
data <- subset(data[data$Location =="Top",])
i <- 1
while (i < 100) {
  Z <- block_ra(blocks = data$Location3, num_arms = 18
                ,conditions = c("A","B","C","D","E","F","G","Ctrl_1", "Ctrl_2","H","K","L","P","Q","R","X","Y","Z"))
  blocks <- rep(c("Left_Top","Right_Top"), times = c(36,36))
  table(blocks, Z)
  dt <- data.frame(blocks,Z)
  #head(dt)
  dt$Location3 <- dt$blocks
  #str(scored_policies)
  #left join
  new <-data.frame(data[,c("In ind weight","Final ind weight",   "ADG",   "FCR")],dt)
  a1 <- aov(In.ind.weight ~ (new$Z),new) 
  pvalue <- summary(a1)[[1]][["Pr(>F)"]][1]
  a2 <- aov(ADG ~ (new$Z),new) 
  pvalue1 <- summary(a2)[[1]][["Pr(>F)"]][1]
  if (pvalue > 0.05 & pvalue1 < 0.05){
    print(c(pvalue, pvalue1))
  }
  i = i+1
}

data <- read_excel("N:/DaheeKim/December/Copy of Termination data.xlsx",sheet="Sheet2")
#Bottom only
data <- subset(data[data$Location =="Bottom",])
i <- 1
while (i < 1000) {
  Z <- block_ra(blocks = data$Location3, num_arms = 18
                ,conditions = c("A","B","C","D","E","F","G","Ctrl_1", "Ctrl_2","H","K","L","P","Q","R","X","Y","Z"))
  blocks <- rep(c("Left_Top","Right_Top"), times = c(36,36))
  table(blocks, Z)
  dt <- data.frame(blocks,Z)
  #head(dt)
  dt$Location3 <- dt$blocks
  #str(scored_policies)
  #left join
  new <-data.frame(data[,c("In ind weight","Final ind weight",   "ADG",   "FCR")],dt)
  a1 <- aov(In.ind.weight ~ (new$Z),new) 
  pvalue <- summary(a1)[[1]][["Pr(>F)"]][1]
  a2 <- aov(ADG ~ (new$Z),new) 
  pvalue1 <- summary(a2)[[1]][["Pr(>F)"]][1]
  if (pvalue > 0.05 & pvalue1 < 0.05){
    print(c(pvalue, pvalue1))
  }
  i = i+1
}
##########################################################################
#Count how many are cases are fit to our condition (loop of 10 times)
#Condition: initial is not significant, ADG is significant
k<-1
while(k<11){
  data <- read_excel("N:/DaheeKim/December/Copy of Termination data.xlsx",sheet="Sheet2")
  i <- 1
  j<-1
while (i < 1000) {
  Z <- block_ra(blocks = data$Location3, num_arms = 18
                ,conditions = c("A","B","C","D","E","F","G","Ctrl_1", "Ctrl_2","H","K","L","P","Q","R","X","Y","Z"))
  table(blocks, Z)
  dt <- data.frame(blocks,Z)
  #head(dt)
  dt$Location3 <- dt$blocks
  #str(scored_policies)
  #left join
  new <-data.frame(data[,c("In ind weight","Final ind weight",   "ADG",   "FCR")],dt)
  a1 <- aov(In.ind.weight ~ (new$Z),new) 
  pvalue <- summary(a1)[[1]][["Pr(>F)"]][1]
  a2 <- aov(ADG ~ (new$Z),new) 
  pvalue1 <- summary(a2)[[1]][["Pr(>F)"]][1]
  if (pvalue > 0.5 & pvalue1 < 0.15){
      #print(c(pvalue1, j))
      j =j+1
    }
    i = i+1
  }
  print(j)
  k=k+1
}


#Count how many are cases are fit to our condition
#Condition: ADG is significantly different
k<-1
while(k<11){
  data <- read_excel("N:/DaheeKim/December/Copy of Termination data.xlsx",sheet="Sheet2")
  i <- 1
  j<-1
  while (i < 1000) {
    blocks <- rep(c("Left_Top","Right_Top","Left_Bottom","Right_Bottom"), times = c(36,36,36,36))
    Z <- block_ra(blocks = data$Location3, num_arms = 18
                  ,conditions = c("A","B","C","D","E","F","G","Ctrl_1", "Ctrl_2","H","K","L","P","Q","R","X","Y","Z"))
    table(blocks, Z)
    dt <- data.frame(blocks,Z)
    dt$Location3 <- dt$blocks
    #left join
    new <-data.frame(data[,c("In ind weight","Final ind weight",   "ADG",   "FCR")],dt)
    a2 <- aov(ADG ~ (new$Z),new) 
    pvalue1 <- summary(a2)[[1]][["Pr(>F)"]][1]
    if (pvalue1 < 0.05){
      #print(c(pvalue1, j))
      j =j+1
    }
    i = i+1
  }
  print(j)
  k=k+1
}

#str(summary(a1))
head(new)
table(new$Z, new$blocks)
##########################################################################

