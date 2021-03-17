########################################################
# Two way anova multiple comparison graph plot

#    https://rcompanion.org/rcompanion/d_08.html

#########################################################
library(readxl)
PDI <- read_excel("C:/Users/daheekim/Desktop/Rfile/PDI Testing May 2018_update_1805_1806.xlsx")
View(PDI)

PDI <- PDI[PDI$treatment %in% c("A", "B", "C","D", "Ziegler", "Control 1","R"),]


#value label
PDI$treatment <- factor(PDI$treatment, level=c("A", "B", "C","D", "Control 1","R"),
                        labels=c("E 10%","E 20%","E 30%","E 40%","E 0%","JH1E"))
#-------------------------------------------------------#
#graph
#--------------------------------------------------------#
library(Rmisc)
sum = summarySE(PDI, 
                measurevar="PDI", 
                groupvars=c("treatment","LOS"))
sum

PDI$treatment <- factor(PDI$treatment, level=c("E 10%","E 20%","E 30%","E 40%","E 0%","JH1E"),
                        labels=c("E10","E20","E30","E40","E0","JH1E"))

pd=position_dodge(.2)
library(ggplot2)
ggplot(sum, aes(x=LOS, y=PDI, color=treatment)) +
  geom_errorbar(aes(ymin=PDI-se, ymax=PDI + se )) +
  geom_point(size=4, position=pd) 


ggplot(sum, 
       aes(x=LOS, y=PDI, fill = treatment, 
           ymax=PDI+se, ymin=PDI-se))  +
  geom_bar(stat="identity", position = "dodge", width = 0.7) +
  geom_bar(stat="identity", position = "dodge", 
           colour = "black", width = 0.7, 
           show.legend = FALSE)  +
  geom_errorbar(position=position_dodge(width=0.7), 
                width=0.0, size=0.5, color="black") +

  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
                   plot.title = element_text(size = rel(1.5), 
                                             face = "bold", vjust = 1.5),
                   axis.title = element_text(face = "bold"),
                   legend.title = element_blank(),
                   legend.key = element_rect(fill = "black"),
                   axis.title.y = element_text(vjust= 1.8),
                   axis.title.x = element_text(vjust= -0.5)) +
  scale_fill_brewer(palette="Set3")



boxplot(PDI ~ treatment:LOS, data=PDI, xlab = "treatment x LOS",
        ylab = "PDI",cex.names=0.2)


  
#-----------------------------------------------------------------------#

#multiple comparison
#install.packages('multcomp')
library(multcomp)
library(lsmeans)
lsmeans = lsmeans::lsmeans ### Uses the lsmeans function
###  from the lsmeans package,
###  not from the lmerTest package
#type 3 anova
model = lm(PDI ~ treatment + LOS + treatment:LOS,data=PDI)
library(car)
Anova(model, type="III")
anova(model)
summary(model)

hist(residuals(model), col="darkgray")

plot(fitted(model),residuals(model))
plot(model)

#------------------------------------------------------------------------#
#post-hoc comparison of lease-square means
#------------------------------------------------------------------------#
library(multcompView)
library(lsmeans)

lsmeans = lsmeans::lsmeans ### Uses the lsmeans function
###  from the lsmeans package,
###  not from the lmerTest package


leastsquare = lsmeans(model, 
                      pairwise ~ treatment:LOS,
                      adjust="tukey")

CLD <-cld(leastsquare, 
    alpha=.05,  
    Letters=letters)

plot(CLD) 
text(treatment:LOS ~ lsmean, labels = row.names(.group), data=CLD,pos = 4)
dev.off()

CLD <- x[order(x$val), ]

#best grouping plot
ggplot(CLD, aes(y=reorder(treatment:LOS,lsmean), x=lsmean)) +geom_point()  +
  geom_errorbarh(aes(xmax=upper.CL ,xmin=lower.CL), col="blue") +  
  geom_text(aes(label=.group),hjust=0, vjust=-0.2) +
  ylab("Treatment") +
  xlab("Lease Square Means") +
  ggtitle ("Letter Grouping - Tukey Test",
           subtitle = "PDI")+
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        plot.title = element_text(size = rel(1.5), 
                                  face = "bold", vjust = 1.5),
        axis.title = element_text(face = "bold")) +
  scale_x_continuous( breaks = seq(85, 105, 1))

###  Remove spaces in .group  

CLD$.group=gsub(" ", "", CLD$.group)
CLD$lsmean
CLD$LOS
CLD$treatment
CLD$.group

#---two way grouping with letter-----#
pd = position_dodge(0.4)    ### How much to jitter the points on the plot

ggplot(CLD,
       aes(x     = treatment,
           y    = lsmean,
           color = LOS,
           label = .group)) +
  
  geom_point(shape  = 15,
             size   = 1,
             position = pd) +
  geom_text(aes(label=.group),hjust=0, vjust=0) +

  ylab("PDI") +
  ggtitle ("Letter Grouping - Tukey Test",
           subtitle = "PDI") +
  scale_colour_hue()
  
#---separate graph by LOS-----#
ggplot(CLD, aes(y=treatment, x=lsmean, color=LOS,label = .group)) + 
  geom_point() +
  geom_text(aes(label=.group),hjust=0.7, vjust=0) +
  facet_wrap( ~ LOS)
  
  
  
  
  
  
  #############################
  
  ### Order the levels for printing
  
  CLD$LOS = factor(CLD$LOS,
                   levels=c("30_", "60_", "90_", "120_"))
  
  CLD$treatment = factor(CLD$treatment,
                         levels=c("S", "Control 2","J","I","R","Control 1","Zeigler","A","B","C","D"))
  ###################################
  
 