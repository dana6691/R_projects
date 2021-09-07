library(readxl)
library(ggplot2)
library(BlandAltmanLeh)
vs1  <- read_excel("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2018/August/NH3/Versa Star Data Collection_22.xlsx", sheet = "Sheet2")
vs2  <- read_excel("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2018/August/NH3/Versa Star Data Collection_22.xlsx",sheet="A")

# With Outliers
head(vs1)
# Without Outliers
vs2 <- vs1[-66,]
# Bland Altman
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