##########################################################################################################################
#Original data with all replication 
##########################################################################################################################
library(readxl)
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data")
head(data)
data <- data[which(data$Day >2 ),]
head(data)
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data3") #only cell of day 4 and 5
head(data)
data$pH <- data$pH*8000000
data$'Control (cells/mL)' <- data$'Control (cells/mL)'*20

library(reshape2)
data_s <- melt(data,id=c("Rep","Treatment","Day"))
head(data_s)

data1 <- data_s[which(data_s$Rep == 1),]
data2 <- data_s[which(data_s$Rep == 2),]
library(ggplot2)
ggplot() +
  geom_point(data=data1, aes(x=Day,y=value,  color=variable, shape=variable))+
  geom_line(data=data1, aes(x=Day,y=value,  color=variable))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(legend.position = "bottom",
        legend.title = element_blank())

ggplot() +
  geom_point(data=data2, aes(x=Day,y=value,  color=variable, shape=variable))+
  geom_line(data=data2, aes(x=Day,y=value,  color=variable))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(legend.position = "bottom",
  legend.title = element_blank())
options(digits = 3, scipen = -2)
####################################################################
#Correlation Test
####################################################################
#raw data
my_data <- data[, c(1,2,3,5,6)]
library("Hmisc")
cor_2 <-round(cor(as.matrix(my_data), method = "kendall"),2) 
cor_2
#split data by replication
data1 <- data[which(data$Rep ==1),]
data2 <- data[which(data$Rep ==2),]
data11 <- data1[, c(1,2,3,5)]
data22 <- data2[, c(1,2,3,5)]
cor_2 <-round(cor(as.matrix(data11), method = "kendall"),2) 
cor_2
cor_2 <-round(cor(as.matrix(data22), method = "kendall"),2) 
cor_2
####################################################################
#ANOVA test
####################################################################
library(PMCMRplus)
kruskal.test(data$pH ~ data$Treatment, data = data)
kruskal.test(data$`Heterotrophic (Cells/L)` ~ Treatment, data = data)
kruskal.test(data$`Control (cells/mL)` ~ Treatment, data = data)
#P-value is small - smaller than 0.05, say - we can reject the null hypothesis.
kruskal.test(data1$pH ~ data1$Treatment, data = data1)
kruskal.test(data1$`Heterotrophic (Cells/L)` ~ Treatment, data = data1)
kruskal.test(data1$`Control (cells/mL)` ~ Treatment, data = data1)

kruskal.test(data2$pH ~ data2$Treatment, data = data2)
kruskal.test(data2$`Heterotrophic (Cells/L)` ~ Treatment, data = data2)
kruskal.test(data2$`Control (cells/mL)` ~ Treatment, data = data2)
####################################################################
#post-hoc (Dunn test)
####################################################################
library(FSA)
data$Treatment <- as.factor(data$Treatment)
DT = dunnTest(data$pH, data$Treatment,method="bh") 
PT = DT$res
PT
library(rcompanion)
cldList(P.adj ~ Comparison,
        data = PT,
        threshold = 0.05)
print(DT,dunn.test.results=TRUE)

data$Treatment <- as.factor(data$Treatment)
DT = dunnTest(data$`Control (cells/mL)`, data$Treatment,method="bh") 
PT = DT$res
PT
library(rcompanion)
cldList(P.adj ~ Comparison,
        data = PT,
        threshold = 0.05)
print(DT,dunn.test.results=TRUE)

data$Treatment <- as.factor(data$Treatment)
DT = dunnTest(data$`Heterotrophic (Cells/L)`, data$Treatment,method="bh") 
PT = DT$res
PT
library(rcompanion)
cldList(P.adj ~ Comparison,
        data = PT,
        threshold = 0.05)
print(DT,dunn.test.results=TRUE)

#Pairwise Mann-Whitney U-test
PT1 = pairwise.wilcox.test(data$pH, data$Treatment,p.adjust.method="none")
PT1 = PT1$p.value
library(rcompanion)
PT11 = fullPTable(PT1)
library(multcompView)
multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)

PT1 = pairwise.wilcox.test(data$`Heterotrophic (Cells/L)`, data$Treatment,p.adjust.method="none")
PT1 = PT1$p.value
PT11 = fullPTable(PT1)
multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)

PT1 = pairwise.wilcox.test(data$`Control (cells/mL)`, data$Treatment,p.adjust.method="none")
PT1 = PT1$p.value
PT11 = fullPTable(PT1)
multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)


PT1 = pairwise.wilcox.test(data2$pH, data2$Treatment,p.adjust.method="none")
PT1
PT2 = pairwise.wilcox.test(data1$`Heterotrophic bacterial (cells/L)`, data1$Treatment,p.adjust.method="none")
PT2
wilcox.test(data$pH, data$Treatment, paired=TRUE)
wilcox.paired.multcomp(data$pH~data$Treatment)


library(multcomp)
data$Treatment <- as.factor(data$Treatment)
Hetero.aov <- aov(data$`Heterotrophic (Cells/L)` ~ Treatment, data = data)
Cell.aov <- aov(data$`Control (cells/mL)` ~ Treatment, data = data)
plot(Cell.aov)
Hetero.glt <- summary(glht(Hetero.aov, linfct = mcp(Treatment = "Tukey")))
Cell.glt <- summary(glht(Cell.aov, linfct = mcp(Treatment = "Tukey")))
plot(cld(Hetero.glt))
title(ylab="Control Density(cells/mL)")
a <- cld(Cell.glt,yname="Control Density(cells/mL)")
plot(cld(Cell.glt))
old.par <- par(mai=c(1,1,1.25,1), no.readonly = TRUE)
### plot
plot(a)
par(old.par)

##########################################################################################################################
#Mean of two replication data 
##########################################################################################################################
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data2")
colors <- c("pH" = "red", "Heterotrophic (Cells/L)" = "darkolivegreen4", "Control (cells/mL)" = "dodgerblue4")
ggplot() +
  geom_point(data=data, aes(x=Day,y=pH*9500000,color="pH"), shape=19,size=2.5)+
  geom_point(data=data, aes(x=Day,y=pH*9500000), shape=19,size=5,color="grey80",alpha=0.4)+
  geom_line(data=data, aes(x=Day,y=pH*9500000))+
  geom_point(data=data, aes(x=Day,y=data$`Heterotrophic (Cells/L)`,color="Heterotrophic (Cells/L)"), shape=15,size=2)+
  geom_line(data=data, aes(x=Day,y=data$`Heterotrophic (Cells/L)`,color="Heterotrophic (Cells/L)"))+
  geom_point(data=data, aes(x=Day,y=data$`Control (cells/mL)`*20,color="Control (cells/mL)"), shape=17,size=2)+
  geom_line(data=data, aes(x=Day,y=data$`Control (cells/mL)`*20,color="Control (cells/mL)"))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_color_manual(values =colors)+
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(panel.border = element_blank(),
        legend.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")

colors <- c("pH" = "red", "Heterotrophic (Cells/L)" = "darkolivegreen4", "Control (cells/mL)" = "dodgerblue4")
ggplot() +
  geom_point(data=data, aes(x=Day,y=pH*120000,color="pH"), shape=19,size=2.5)+
  geom_point(data=data, aes(x=Day,y=pH*120000), shape=19,size=5,color="grey80",alpha=0.4)+
  geom_line(data=data, aes(x=Day,y=pH*120000))+
  geom_point(data=data, aes(x=Day,y=data$`Control (cells/mL)`,color="Control (cells/mL)"), shape=19,size=2)+
  geom_line(data=data, aes(x=Day,y=data$`Control (cells/mL)`,color="Control (cells/mL)"),size=1)+
  geom_bar(data=data, aes(x=data$Day,y=data$`Control (cells/mL)`,alpha=0.4),stat="identity")+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_color_manual(values =colors)+
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./120000, name = "pH"))  +
  facet_grid(~Treatment)+
  theme(panel.border = element_blank(),
        legend.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")+ 
  scale_alpha(guide = 'none')#remove unnecessary legend



ggplot() +
  geom_point(data=data, aes(x=Day,y=pH*7500000,color="pH"), shape=19,size=2.5)+
  geom_point(data=data, aes(x=Day,y=pH*7500000), shape=19,size=5,color="grey80",alpha=0.4)+
  geom_line(data=data, aes(x=Day,y=pH*7500000))+
  geom_point(data=data, aes(x=Day,y=data$`Heterotrophic (Cells/L)`,color="Heterotrophic (Cells/L)"), shape=19,size=2)+
  geom_line(data=data, aes(x=Day,y=data$`Heterotrophic (Cells/L)`,color="Heterotrophic (Cells/L)"),size=1)+
  geom_bar(data=data, aes(x=data$Day,y=data$`Heterotrophic (Cells/L)`,alpha=0.4 ),stat="identity")+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_color_manual(values =colors)+
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./7500000, name = "pH"))  +
  facet_grid(~Treatment)+
  theme(panel.border = element_blank(),
        legend.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position = "bottom")+ 
  scale_alpha(guide = 'none') #remove unnecessary legend
####################################################################
#Correlation Test
####################################################################
my_data <- data[, c(1,2,3,4)]
library("Hmisc")
cor_2 <-round(cor(as.matrix(my_data), method = "kendall"),2) 
cor_2
####################################################################
#ANOVA test
####################################################################
#Pairwise Mann-Whitney U-test
PT1 = pairwise.wilcox.test(data$pH, data$Treatment,p.adjust.method="none")
PT1 = PT1$p.value
library(rcompanion)
PT11 = fullPTable(PT1)
library(multcompView)
multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)

PT1 = pairwise.wilcox.test(data$`Heterotrophic (Cells/L)`, data$Treatment,p.adjust.method="none")
PT1 = PT1$p.value
PT11 = fullPTable(PT1)
multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)


pH.aov <- aov(pH ~ Treatment, data = data)
library(multcomp)
head(data)
data$Treatment <- as.factor(data$Treatment)
Hetero.aov <- aov(data$`Heterotrophic (Cells/L)` ~ Treatment, data = data)
Cell.aov <- aov(data$`Control (cells/mL)` ~ Treatment, data = data)

Hetero.glt <- summary(glht(Hetero.aov, linfct = mcp(Treatment = "Tukey")))
Cell.glt <- summary(glht(Cell.aov, linfct = mcp(Treatment = "Tukey")))

cld(Hetero.glt)
cld(Cell.glt)
