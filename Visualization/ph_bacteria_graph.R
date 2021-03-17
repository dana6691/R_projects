##################################################################################################################
#A.	Separate graphs for each treatment pH vs cell density vs bacterial population. 
#B.	Comparative graph pH vs cell density among all the treatments
#C.	Comparative graph pH vs bacterial population among all the treatments
#D.	Comparative graph pH vs bacterial population vs cell density among all the treatment.  
##################################################################################################################

library(readxl)
data <- read_excel("C:/Users/daheekim/Desktop/pH-bacteria-graph.xlsx", 
                                sheet = "Sheet2")
library(ggplot2)
#A
ggplot() +
  geom_point(data=data, aes(x=data$Day, y=data$pH*7000000),color="black",size=2.5)+
  geom_point(data=data, aes(x=data$Day, y=data$pH*7000000),color="grey",size=5,alpha=0.4)+
  geom_line(data=data, aes(x=data$Day, y=data$pH*7000000, group=1))+
  geom_bar(data=data, aes(x=data$Day-0.24, y=data$"Heterotrophic bacterial population (Cells/L)"),stat="identity" ,fill="red",color="black",width=0.45)+
  geom_bar(data=data, aes(x=data$Day+0.24, y=data$"Treatment (cells/mL)"*25),stat="identity",fill="blue",color="black" ,width=0.45) +
  scale_y_continuous(name = expression("Heterotrophic bacterial population (Cells/L)"), sec.axis = sec_axis(~ ./25, name = "Treatment (cells/mL)"))  +
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  facet_wrap(~Treatment)+
  theme(plot.title = element_text(size=14, family = "Times",face="bold"),
        panel.background=element_rect(fill = "snow2"),
        axis.line = element_line(color="grey84", size = 0.5),
        plot.background = element_rect(fill = "snow1"),
        panel.grid.major = element_blank(),
        legend.title = element_blank()) +
  scale_color_brewer(palette="Dark2")
#B
ggplot() + 
  geom_point(data=data, aes(x=data$Day, y=data$pH*500000,color=Treatment),size=3)+
  geom_point(data=data, aes(x=data$Day, y=data$pH*500000),color="grey",size=5,alpha=0.3)+
  geom_line(data=data, aes(x=data$Day, y=data$pH*500000, group=Treatment,color=Treatment))+
  geom_bar(data=data, aes(x=data$Day, y=data$"Treatment (cells/mL)",fill=Treatment),stat="identity" )+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  ylab("Treatment (cells/mL)")+
  theme(plot.title = element_text(size=14, family = "Times",face="bold"),
        panel.background=element_rect(fill = "snow2"),
        axis.line = element_line(color="grey84", size = 0.5),
        plot.background = element_rect(fill = "snow1"),
        panel.grid.major = element_blank(),
        legend.title = element_blank()) +
  scale_color_brewer(palette="Dark2")

#C
ggplot() + 
  geom_point(data=data, aes(x=data$Day, y=data$pH*22000000,color=Treatment),size=3)+
  geom_point(data=data, aes(x=data$Day, y=data$pH*22000000),color="grey",size=5,alpha=0.3)+
  geom_line(data=data, aes(x=data$Day, y=data$pH*22000000, group=Treatment,color=Treatment))+
  geom_bar(data=data, aes(x=data$Day, y=data$"Heterotrophic bacterial population (Cells/L)",fill=Treatment),stat="identity" )+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  ylab("Heterotrophic bacterial population (Cells/L)")+
  theme(plot.title = element_text(size=14, family = "Times",face="bold"),
        panel.background=element_rect(fill = "snow2"),
        axis.line = element_line(color="grey84", size = 0.5),
        plot.background = element_rect(fill = "snow1"),
        panel.grid.major = element_blank(),
        legend.title = element_blank()) +
  scale_color_brewer(palette="Dark2")
##
#D  
ggplot()+  
  geom_point(data=data, aes(x="ph",y=data$pH*22000000,color=Treatment),size=2) +
  geom_bar(data=data, aes(x="Heterotrophic bacterial population (Cells/L)",y=data$"Heterotrophic bacterial population (Cells/L)",fill=Treatment),stat="identity",color="black",width=0.8,alpha=0.7) +
  geom_bar(data=data, aes(x="Treatment (cells/mL)", y=data$"Treatment (cells/mL)"*70,fill=Treatment),stat="identity",color="black" ,width=0.8, position = position_nudge(x = -0.1)) +
  facet_grid(~data$Day)+
  scale_y_continuous(name = expression("Heterotrophic bacterial population (Cells/L)"), sec.axis = sec_axis(~ ./70, name = "Treatment (cells/mL)")) +
  theme(panel.background=element_rect(fill = "snow2"),
        axis.title.x=element_blank(),
        axis.line = element_line(color="grey84", size = 0.5),
        plot.background = element_rect(fill = "snow1"),
        panel.grid.major = element_blank(),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.x=element_blank(),
        legend.position = "bottom") 
  
# D(2)
library(wesanderson)
names(wes_palettes)
#scale_fill_manual(values = wes_palette("GrandBudapest1", n = 4))+
ggplot() +
  geom_point(data=data, aes(x=data$Day, y=data$pH*40000000,color=Treatment),size=3, show.legend = F) +
  geom_point(data=data, aes(x=data$Day, y=data$pH*40000000),color="grey",size=5,alpha=0.2, show.legend = F) +
  geom_line(data=data, aes(x=data$Day, y=data$pH*40000000, group=Treatment,color=Treatment), show.legend = F) +
  scale_color_manual(values = wes_palette("Darjeeling1", n = 4))+
  geom_bar(aes(x=data$Day+0.25,y=data$"Heterotrophic bacterial population (Cells/L)",fill = data$Treatment),stat = "identity", position = "stack",width=0.4,alpha=0.7)+
  scale_fill_manual(values = wes_palette("Darjeeling1", n = 4))+
  geom_bar(aes(x=data$Day-0.25,y=data$"Treatment (cells/mL)"*80,fill=data$Treatment),stat = "identity", position = "stack",width=0.4,alpha=0.7)+
  scale_y_continuous(name = expression("Heterotrophic bacterial population (Cells/L)"), sec.axis = sec_axis(~ ./80, name = "Treatment (cells/mL)"))+ 
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  theme(panel.background=element_rect(fill = "snow2"),
        axis.line = element_line(color="grey84", size = 0.5),
        plot.background = element_rect(fill = "snow1"),
        panel.grid.major = element_blank(),
        legend.title = element_blank(),
        legend.position = "bottom") 

##################################################################################

library(reshape2)
data1 <- data[,c(1,2,4,5)]
data2 <- melt(data1, id=c("Treatment","Day"))

## D(3)
ggplot(data=data2, aes(x= factor(interaction(Treatment, variable)),y=value, fill = Treatment)) +
  geom_bar(stat="identity") + facet_grid(~ Day) 

library(RColorBrewer)
library(viridis)

####################################################################################################################################################################
library(readxl)
#Pure
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data")
head(data)
#Mean
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data2")
data$pH <- data$pH*8000000
data$'Control (cells/mL)' <- data$'Control (cells/mL)'*20

library(reshape2)
data_s <- melt(data,id=c("Rep","Treatment","Day"))
head(data_s)
str(data)

data1 <- data_s[which(data_s$Rep == 1),]
data2 <- data_s[which(data_s$Rep == 2),]
library(ggplot2)
ggplot() +
  geom_point(data=data1, aes(x=Day,y=value,  color=variable, shape=variable))+
  geom_line(data=data1, aes(x=Day,y=value,  color=variable))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(legend.position = "bottom")

ggplot() +
  geom_point(data=data2, aes(x=Day,y=value,  color=variable, shape=variable))+
  geom_line(data=data2, aes(x=Day,y=value,  color=variable))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(legend.position = "bottom")
options(digits = 3, scipen = -2)
ggplot()+  
  geom_point(data=data, aes(x=data$Day,y=data$`Heterotrophic (Cells/L)`,color=Treatment),size=2,shape=1) +
  geom_line(data=data, aes(x=data$Day,y=data$`Heterotrophic (Cells/L)`,color=Treatment)) +
  geom_point(data=data, aes(x=data$Day, y=data$pH*7000000, color=Treatment),shape=19)+
  geom_line(data=data, aes(x=data$Day,y=data$pH*7000000,color=Treatment)) +
  geom_point(data=data, aes(x=data$Day, y=data$'Control (cells/mL)'*40, color=Treatment),shape=3)+
  geom_line(data=data, aes(x=data$Day,y=data$'Control (cells/mL)'*40,color=Treatment)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./40, name = "Control (cells/mL)"))  +
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  facet_grid(~Treatment)

library(readxl)
data <- read_excel("N:/DaheeKim/February/Copy of pH-bacteria-graph.xlsx", 
                   sheet = "data2")
head(data)
library(reshape2)
data$pH <- data$pH*8000000
data$'Control (cells/mL)' <- data$'Control (cells/mL)'*20
data_s <- melt(data,id=c("Treatment","Day"))

head(data_s)
ggplot() +
  geom_point(data=data_s, aes(x=Day,y=value,  color=variable, shape=variable))+
  geom_line(data=data_s, aes(x=Day,y=value,  color=variable))+
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1)) +
  scale_y_continuous(name = expression("Heterotrophic (Cells/L)"), sec.axis = sec_axis(~ ./20, name = "Control (cells/mL)"))  +
  facet_grid(~Treatment)+
  theme(legend.position = "bottom")
head(data)
ggplot()+  
  geom_point(data=data, aes(x=data$Day,y=data$`Heterotrophic bacterial (cells/L)`,color=Treatment),size=2) +
  geom_line(data=data, aes(x=data$Day,y=data$`Heterotrophic bacterial (cells/L)`,color=Treatment)) +
  geom_point(data=data, aes(x=data$Day, y=data$pH*10000000, color=Treatment))+
  geom_line(data=data, aes(x=data$Day,y=data$pH*10000000,color=Treatment)) +
  scale_y_continuous(name = expression("Heterotrophic bacterial population (Cells/L)"), sec.axis = sec_axis(~ ./10000000, name = "pH"))  +
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  facet_grid(~data$Rep)

ggplot()+  
  geom_point(data=data, aes(x=data$Day,y=data$`Control (cells/mL)`,color=Treatment),size=2) +
  geom_line(data=data, aes(x=data$Day,y=data$'Control (cells/mL)',color=Treatment)) +
  geom_point(data=data, aes(x=data$Day, y=data$pH*200000, color=Treatment))+
  geom_line(data=data, aes(x=data$Day,y=data$pH*200000,color=Treatment)) +
  scale_y_continuous(name = expression("Cell density (cells/mL)"), sec.axis = sec_axis(~ ./200000, name = "pH"))  +
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  facet_grid(~data$Rep)
ggplot() +
  geom_point(data=data, aes(x=data$Day, y=data$pH*7000000),color="black",size=2.5)+
  geom_point(data=data, aes(x=data$Day, y=data$pH*7000000),color="grey",size=5,alpha=0.4)+
  geom_line(data=data, aes(x=data$Day, y=data$pH*7000000, group=1))+
  geom_bar(data=data, aes(x=data$Day-0.24, y=data$"Heterotrophic bacterial population (Cells/L)"),stat="identity" ,fill="red",color="black",width=0.45)+
  geom_bar(data=data, aes(x=data$Day+0.24, y=data$"Treatment (cells/mL)"*25),stat="identity",fill="blue",color="black" ,width=0.45) +
  scale_y_continuous(name = expression("Heterotrophic bacterial population (Cells/L)"), sec.axis = sec_axis(~ ./25, name = "Treatment (cells/mL)"))  +
  scale_x_continuous(data$Day,name="Days", breaks = seq(from = 0, to = 10, by = 1))+
  facet_wrap(~Treatment)
ggplot()+  
  geom_point(data=data, aes(x=data$Day,y=data$pH,color=Treatment),size=2) +
  geom_line(data=data, aes(x=data$Day,y=data$pH,color=Treatment))+
  facet_grid(~data$Rep)

ggplot()+  
  geom_point(data=data, aes(x=data$Day,y=data$"Cell density (cells/mL)",color=Treatment),size=2) +
  geom_line(data=data, aes(x=data$Day,y=data$"Cell density (cells/mL)",color=Treatment))+
  facet_grid(~data$Rep)
View(data)
#1. Normality Check
# Run Shapiro-Wilk test
data1 <- data[which(data$Rep == 1),]
data2 <- data[which(data$Rep == 2),]

shapiro.test(data1$pH)
shapiro.test(data1$`Control (cells/mL)`) #6.748e-06
shapiro.test(data1$`Heterotrophic (Cells/L)`) #1.98e-11

shapiro.test(data2$pH)
shapiro.test(data2$`Control (cells/mL)`) #6.748e-06
shapiro.test(data2$`Heterotrophic (Cells/L)`) #1.98e-11
##### less than 0.05, they are not normal
st <- function(p) { sqrt(p) }
shapiro.test(st(data1$pH)) 
shapiro.test(st(data1$`Control (cells/mL)`)) ##3.635e-06
shapiro.test(st(data1$`Heterotrophic (Cells/L)`)) # 2.935e-09

re_sqrt <- function(p) { 1/sqrt(p) }
shapiro.test(re_sqrt(data$pH)) ####0.02502
shapiro.test(re_sqrt(data$`Control (cells/mL)`)) #1.963e-06
shapiro.test(re_sqrt(data$`Heterotrophic (Cells/L)`))

sign_abs <- function(p) { sign(p) * abs(p)^(1/3) }
shapiro.test(sign_abs(data$pH))
shapiro.test(sign_abs(data$`Control (cells/mL)`)) #1.963e-06
shapiro.test(sign_abs(data$`Heterotrophic (Cells/L)`)) #3.997e-08

#logitTransform <- function(p) { log(p/(1-p)) }
#shapiro.test(logitTransform(data$pH))
#shapiro.test(logitTransform(data$`Cell density (cells/mL)`))
#shapiro.test(logitTransform(data$`Heterotrophic bacterial (cells/L)`))

logTransform <- function(p) { log(p) }
shapiro.test(logTransform(data$pH))
shapiro.test(logTransform(data1$`Control (cells/mL)`))
shapiro.test(logTransform(data1$`Heterotrophic (Cells/L)`))

relogTransform <- function(p) { 1/(log(p)) }
shapiro.test(relogTransform(data$pH))
shapiro.test(relogTransform(data1$`Control (cells/mL)`))
shapiro.test(relogTransform(data1$`Heterotrophic (Cells/L)`)) #3.419e-06

loglogTransform <- function(p) { log(log(p)) }
shapiro.test(loglogTransform(data$pH)) #0.02425
shapiro.test(loglogTransform(data1$`Control (cells/mL)`))
shapiro.test(loglogTransform(data1$`Heterotrophic (Cells/L)`)) #4.831e-07

reloglogTransform <- function(p) { 1/(log(log(p))) }
shapiro.test(reloglogTransform(data$pH)) # 0.05847
shapiro.test(reloglogTransform(data1$`Control (cells/mL)`))
shapiro.test(reloglogTransform(data1$`Heterotrophic (Cells/L)`)) #4.831e-07

#asinTransform <- function(p) { asin(sqrt(p)) }
#shapiro.test(asinTransform(data$pH))
#shapiro.test(asinTransform(data1$`Cell density (cells/mL)`))
#shapiro.test(asinTransform(data1$`Heterotrophic bacterial (cells/L)`))

rangeScale <- function(x) { (x-min(x)) / (max(x)-min(x)) }
shapiro.test(rangeScale(data$pH))
shapiro.test(rangeScale(data1$`Control (cells/mL)`))
shapiro.test(rangeScale(data1$`Heterotrophic (Cells/L)`))



The effect sizes
In the previous exercises you discovered that both simple effects are significant, so why is there an interaction effect?
  
  The definition of an interaction effect states that the effect of one variable changes across levels of the other variable. For example, you might expect the effect of conversation to be greater when driving conditions are difficult than when they are relatively easy.

Unfortunately, it is not quite that simple. In order to really understand the different effect sizes, you should make use of the etaSquared() function:
  
  etaSquared(anova_object, anova = TRUE)
Instructions
100 XP
Calculate ??2 for the easy driving condition with the help of etaSquared() and print the result to the console.
Calculate ??2 for the difficult driving condition with the help of etaSquared() and print the result to the console.
################################################################################################################################
#transform
shapiro.test(st(data1$pH)) 
shapiro.test(re_sqrt(data1$`Control (cells/mL)`)) #1.963e-06
shapiro.test(relogTransform(data1$`Heterotrophic (Cells/L)`)) #3.419e-06

#transform
relogTransform <- function(p) { 1/(log(p)) }

reloglogTransform <- function(p) { 1/(log(log(p))) }
shapiro.test(reloglogTransform(data$pH)) # 0.05847
re_sqrt <- function(p) { 1/sqrt(p) }


data1$`relog_Heterotrophic` <- relogTransform(data1$`Heterotrophic (Cells/L)`)
data1$reloglogpH <-st(data1$pH)
data1$"re_sqrt_Cell" <-  re_sqrt(data1$`Control (cells/mL)`)
################################################################################################################################
#homogeneity of variance
#leveneTest
#H0 is that all variances are equal

#Fisher's F test and Levene's test. Fisher's F test, which is introduced here, is restricted to comparison of two variances/groups while Levene's test can assess more than two variances/groups. 
attach(data)
library(car)
data$Treatment <- as.factor(data$Treatment)
leveneTest(reloglogpH ~ Treatment, data = data, center=mean)
leveneTest(data$`relog_Heterotrophic` ~ Treatment, data = data, center=mean)
leveneTest(data$"re_sqrt_Cell" ~ Treatment, data = data, center=mean)

leveneTest(pH ~ Treatment, data = data, center=mean)
leveneTest(data$`Cell density (cells/mL)` ~ Treatment, data = data, center=mean)
leveneTest(data$`Heterotrophic bacterial (cells/L)` ~ Treatment, data = data, center=mean)
# The test reveals a p-value greater than 0.05, indicating that 
# there is no significant difference between the group variances in location.
# mean gives the original Levene's test; the default, median, provides a more robust test called Brown-Forsythe test for homogeneity of variance.
# Compute the analysis of variance
##############################################################################################################################
pH.aov <- aov(pH ~ Treatment, data = data)
Hetero.aov <- aov(data$`Heterotrophic (Cells/L)` ~ Treatment, data = data)
Cell.aov <- aov(data$`Control (cells/mL)` ~ Treatment, data = data)
Hetero.aov <- aov(data$`relog_Heterotrophic` ~ Treatment, data = data)
Cell.aov <- aov(data$"re_sqrt_Cell" ~ Treatment, data = data)
shapiro.test(residuals(pH.aov))
shapiro.test(residuals(Cell.aov))
shapiro.test(residuals(Hetero.aov))
##############################################################################################################################
#non-parametric

#install.packages("PMCMRplus")
library(PMCMRplus)
kruskal.test(pH ~ Treatment, data = data)
kruskal.test(data$`Heterotrophic (Cells/L)` ~ Treatment, data = data)
kruskal.test(data$`Control (cells/mL)` ~ Treatment, data = data)

kruskal.test(reloglogpH ~ Treatment, data = data1) #reject the null
kruskal.test(data1$`relog_Heterotrophic` ~ Treatment, data = data1)
kruskal.test(data1$"re_sqrt_Cell" ~ Treatment, data = data1)


#Pairwise Mann-Whitney U-test
PT1 = pairwise.wilcox.test(data1$pH, data1$Treatment,p.adjust.method="none")
PT1
PT1 = pairwise.wilcox.test(data2$pH, data2$Treatment,p.adjust.method="none")
PT1
PT2 = pairwise.wilcox.test(data1$`Heterotrophic bacterial (cells/L)`, data1$Treatment,p.adjust.method="none")
PT2
PT2 = pairwise.wilcox.test(data2$`Heterotrophic bacterial (cells/L)`, data2$Treatment,p.adjust.method="none")
PT2
PT3 = pairwise.wilcox.test(data1$`relog_Heterotrophic`, data1$Treatment,p.adjust.method="BY")
PT3
PT3 = pairwise.wilcox.test(data2$`relog_Heterotrophic`, data2$Treatment,p.adjust.method="BY")
PT3
PT4 = pairwise.wilcox.test(data1$`Cell density (cells/mL)`, data1$Treatment,p.adjust.method="none")
PT4
PT4 = pairwise.wilcox.test(data2$`Cell density (cells/mL)`, data2$Treatment,p.adjust.method="none")
PT4
# Can adjust p-values;
# See ?p.adjust for options
#Pairwise comparisons using Wilcoxon rank sum test
PT
PT1 = PT1$p.value
PT2 = PT2$p.value
PT3 = PT3$p.value
PT4 = PT4$p.value

library(rcompanion)
PT11 = fullPTable(PT1)
PT22 = fullPTable(PT2)
PT33 = fullPTable(PT3)
PT44 = fullPTable(PT4)


library(multcompView)
mcT4 <- multcompLetters(PT11,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)
multcompLetters(PT22,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)
multcompLetters(PT33,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)
multcompLetters(PT44,compare="<", threshold=0.05, Letters=letters, reversed = FALSE)
head(data)
str(data)
library(multcomp)
data(recovery)
multcompBoxplot(minutes~blanket, recovery)
str(recovery)
data <- as.data.frame(data)
data$Treatment <- as.factor(data$Treatment)
multcompBoxplot(pH ~ Treatment, data)
multcompBoxplot(data$"Control (cells/mL)"~ Treatment, data=data)
multcompBoxplot(data$"Control (cells/mL)"~ Treatment, data=data,
                plotList=list(
                  boxplot=list(fig=c(0, 0.75, 0, 1), las=1,
                               cex.axis=1.5),
                  multcompTs=list(fig=c(0.7, 0.85, 0, 1),
                                  type='boxes'),
                  multcompLetters=list(
                    fig=c(0.87, 0.97, 0.03, 0.98),
                    type='boxes') ) )
##############################################################################################################################
#post-hoc tests
#1
posthoc.kruskal.nemenyi.test(x=data$`Heterotrophic bacterial (cells/L)`, g=data$Treatment, dist="Tukey")
(out <- posthoc.kruskal.nemenyi.test(x=data$Initial_weight, g=data$treatment, dist="Chisquare")) # if there are tie present in the data
print(out$statistic)

#https://cran.r-project.org/web/packages/PMCMR/vignettes/PMCMR.pdf

#2
pairwise.wilcox.test(data$Initial_weight, data$treatment,
                     p.adjust.method = "BH")

head(data)
##############################################################################################################################
library("PerformanceAnalytics")
my_data <- data[, c(1,2,3,5,6)]
my_data <- data[, c(1,2,3,4)]
res <- cor.test(my_data$pH, my_data$"Control (cells/mL)", 
                method = "pearson")

library("Hmisc")
cor_2 <- rcorr(as.matrix(my_data), type ="spearman")
cor_2

cor_2 <-round(cor(as.matrix(my_data), method = "kendall"),2) 
cor_2
str(cor_2)
M <- cor_2$r
p_mat <- cor_2$P

cor_5 <- rcorr(as.matrix(my_data), type ="spearman")
M <- cor_5$r
p_mat <- cor_5$P
corrplot(M, type = "upper", order = "hclust", 
         p.mat = p_mat, sig.level = 0.05)

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M, method = "color", col = col(200),  
         type = "upper", order = "hclust", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col = "darkblue", tl.srt = 45, #Text label color and rotation
         # Combine with significance level
         p.mat = p_mat, sig.level = 0.01,  
         # hide correlation coefficient on the principal diagonal
         diag = FALSE 
)

shapiro.test(my_data$pH)
shapiro.test(my_data$"Control (cells/mL)")
#P-value is small - smaller than 0.05, say - we can reject the null hypothesis.
Control <- data[which(data$Treatment =="Control"),]
Set_A <- data[which(data$Treatment =="Set-A"),]
Set_B <- data[which(data$Treatment =="Set-B"),]
Set_C <- data[which(data$Treatment =="Set-C"),]
Control <- Control[, c(1,2,3,5)]
Set_A <- Set_A[, c(1,2,3,5)]
Set_B <- Set_B[, c(1,2,3,5)]
Set_C <- Set_C[, c(1,2,3,5)]
chart.Correlation(Control, histogram=TRUE, pch=19)
# Insignificant correlation are crossed
library(corrplot)
library(Hmisc)
head(data1)
#data <- na.omit(data1)
res2<-rcorr(as.matrix(data1))
res2
corrplot(res2$r, type="upper", order="hclust", 
         p.mat = res2$P, sig.level = 0.05, insig = "blank")


library(dplyr)
head(data)
mean <- data %>% group_by%>% summarise(mean=mean(data$pH, data$`Cell density (cells/mL)`, data$`Heterotrophic bacterial (cells/L)`))
mean <-data %>% group_by(Treatment,Day)%>% summarise(mean=mean(data$pH))
View(mean)

