library(readxl)
library(ggplot2)
library(BlandAltmanLeh)
vs1  <- read_excel("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2018/August/NH3/Versa Star Data Collection_22.xlsx", sheet = "Sheet2")
vs2  <- read_excel("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2018/August/NH3/Versa Star Data Collection_22.xlsx",sheet="A")

# With Outliers
head(vs1)
# Without Outliers
vs2 <- vs1[-66,]
#########################################
# difference plot - Bland Altman
#########################################
pl1 <- bland.altman.plot(vs1$probe, vs1$hach, graph.sys="ggplot2", conf.int=.95, ylab="Differences",main="Bland Altman Plot")
print(pl1)
pl2 <- bland.altman.plot(vs2$probe, vs2$hach, graph.sys = "ggplot2", conf.int=.95, ylab="Differences",main="Bland Altman Plot without outliers")
print(pl2)
#scatter
plot(vs2$probe, vs2$hach, main="Scatter plot")
abline(0,1)
#mean-difference plot
plot((vs1$probe+vs1$hach)/2, vs1$probe-vs1$hach, main="Mean-Difference-Plot",xlab="Mean")
plot((vs2$probe+vs2$hach)/2, vs2$probe-vs2$hach, main="Mean-Difference-Plot",xlab="Mean")

#########################################
#Kruskal-Wallis
#########################################
data <- read_excel("~/VScode_project/R_projects/Data/TSCW200102.xlsx")
colnames(data)
data <- data[, c(7,10,13,14,18,19)]

library(agricolae)
outKruskal <- with(data,kruskal(ADG ,Treatment, alpha = 0.05, group=TRUE, main="ADG", console=TRUE))
print(outKruskal$statistic)
print(outKruskal$group)
out <- with(data,kruskal(ADG ,Treatment, alpha = 0.05, group=FALSE, main="ADG", console=TRUE))
print(out$comparison)
attach(data)
a <- with(data,kruskal(ADG ,Treatment, alpha = 0.05, group=FALSE, main="ADG", console=TRUE))$statistics
for (i in 2:6){
  name <- colnames(data)[i]
  outKruskal <- with(data,kruskal(data[[i]] ,Treatment, alpha = 0.05, group=TRUE, main="ADG", console=TRUE))
  statistic <- outKruskal$statistic
  print(name, statistic)
}
magic_result_as_dataframe()
for (i in 2:6){
  name <- colnames(data)[i]
  kruskal <- kruskal.test(data[[i]]~Treatment,data=data)
  nopram_stat <- round(kruskal$statistic,2)
  nonpram_DF <- kruskal$parameter
  nonpram_pvalue <- round(kruskal$p.value,3)
  print(name, nonpram_DF, nopram_stat,nonpram_pvalue)
}
magic_result_as_dataframe()
#########################################
#Post-hoc Analysis
#########################################
library(PMCMR)
#c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none")
posthoc.kruskal.dunn.test( round(data$`Average Initial Weight`,2) ~ as.factor(Treatment), data = data, p.adjust="none")
posthoc.kruskal.dunn.test( data$`Average Final Weight`~ as.factor(Treatment), data = data, p.adjust="none")
posthoc.kruskal.dunn.test( data$`ADG`~ as.factor(Treatment), data = data, p.adjust="none")
posthoc.kruskal.dunn.test( data$`FCR`~ as.factor(Treatment), data = data, p.adjust="none")
posthoc.kruskal.dunn.test( data$`Survival`~ as.factor(Treatment), data = data, p.adjust="none")