library(readxl)
vs  <- read_excel("N:/DaheeKim/August/NH3/Versa Star Data Collection_22.xlsx", 
                                            sheet = "Sheet2")

vs <- read_excel("N:/DaheeKim/August/NH3/Versa Star Data Collection_22.xlsx", 
                                            sheet = "A")
View(vs)
library(ggplot2)
library(BlandAltmanLeh)
#with outlier
attach(vs)
#scatter plot
plot(Probe, Hach, main="Scatter plot")
abline(0,1)
#bland,altman
pl <- bland.altman.plot(Probe, Hach, graph.sys="ggplot2", conf.int=.95, ylab="Differences")
print(pl)
#mean-difference plot
plot((Probe+Hach)/2, Probe-Hach, main="Mean-Difference-Plot",xlab="Mean")





#without
vs1 <- vs[-66,]

detach(vs)
attach(vs1)
pl1 <- bland.altman.plot(Probe, Hach, graph.sys="ggplot2", conf.int=.95, ylab="Differences",main="Bland Altman Plot")
print(pl1)
bland.altman.plot(Probe, Hach, graph.sys="ggplot2", conf.int=.95, ylab="Differences",main="Bland Altman Plot")
#ggplot
library(ggplot2)
pl <- bland.altman.plot(Probe, Hach, graph.sys = "ggplot2")
print(pl)
#scatter
plot(Probe, Hach, main="Scatter plot")
abline(0,1)
#mean-difference plot
plot((Probe+Hach)/2, Probe-Hach, main="Mean-Difference-Plot",xlab="Mean")

#passing bablock regression
library(mcr)
PB.reg <- mcreg(Probe, Hach, method.reg = "PaBa")
PB.reg@para
MCResult.plot(PB.reg, alpha=0.05,equal.axis = TRUE, 
              x.lab = "Probe method", y.lab = "Hach method", points.col = "#FF7F5060", points.pch = 19, 
              ci.area = TRUE, ci.area.col = "#0000FF50", main = "Passing Bablok Regression", sub = "", 
              add.grid = FALSE, points.cex = 1)

