library(readxl)
library(ggplot2)
library(reshape2)
data <- read_excel("VScode_project/R_project/Data/RTBgraph.xlsx", sheet = "Sheet1")
data <- RTBgraph
data <- melt(data, id="variable2")
data <- na.omit(data)
head(data)
colnames(data)
data1 <-  data[ which(data$variable2=='Phytoplankton density (cells/L)'|data$variable2=='Algae'),]
#head(data1)
data11 <-  data[ -which(data$variable2=='Phytoplankton density (cells/L)'|data$variable2=='Algae'),]
#head(data11)
#str(data1)
ggplot() +
  geom_point(data=data1, aes(x=variable, y=value, color=variable2,shape=variable2),size=3) +
  geom_point(data=data1,aes(x = variable, y = value,shape=variable2),size=6, color="grey",alpha=0.3)+
  geom_line(data=data1, aes(x=variable, y=value, group=variable2,color=variable2 )) +
  geom_point(data=data11, aes(x=variable, y=value*3134142/330, color=variable2,shape=variable2),size=3) + 
  geom_point(data=data11, aes(x=variable, y=value*3134142/330,shape=variable2),size=6, color="grey",alpha=0.3)  +
  geom_line(data=data11, aes(x=variable, y=value*3134142/330, group=variable2, color=variable2 )) +
  scale_shape_manual(values=c(19,19,19,19,19,2,4,2,17,2)) +
scale_y_continuous(name = expression("Phytoplankton(cells/L) + Algae"), sec.axis = sec_axis(~ . *330/3135000 , name = "1-5, MI, Chlorphyll, pre & post change"))+
  theme(panel.background=element_rect(fill = "snow2"),
        plot.background = element_rect(fill = "snow1"),
        axis.title.x = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(color="grey84", size = 0.5),
        legend.title = element_blank(),
        axis.text.x=element_text(size=12))
######################################################################
library(readxl)
data2 <- read_excel("C:/Users/daheekim/Desktop/RTBgraph2.xlsx", 
                   sheet = "Sheet2")
data2<- RTBgraph
library(reshape2)
data2 <- melt(data2, id="variable2")
data2 <- na.omit(data2)
head(data2)

data1 <-  data2[ which(data2$variable2=='Phytoplankton density (cells/L)'),]
data11 <-  data2[ -which(data2$variable2=='Phytoplankton density (cells/L)'), ]

ggplot() +
  geom_point(data=data11, aes(x=variable, y=value*3134142/224, color=variable2,shape=variable2),size=3) + 
  geom_point(data=data11, aes(x=variable, y=value*3134142/224,shape=variable2),size=6, color="grey",alpha=0.3)  +
  geom_line(data=data11, aes(x=variable, y=value*3134142/224, group=variable2, color=variable2 )) +
  geom_point(data=data1, aes(x=variable, y=value, color=variable2,shape=variable2),size=3) +
  geom_point(data=data1,aes(x = variable, y = value,shape=variable2),size=6, color="grey",alpha=0.3,shape=2)+
  scale_shape_manual(values=c(19,4,2,19,19,19,2,19,19))+
  geom_line(data=data1, aes(x=variable, y=value, group=variable2,color=variable2 )) +
  scale_y_continuous(name = expression("Phytoplankton(cells/L)"), sec.axis = sec_axis(~ . *224/3134142 , name = "Chlorophyll, WQ, pre & post change"))+
  theme(panel.background=element_rect(fill = "snow2"),
        plot.background = element_rect(fill = "snow1"),
        axis.title.x = element_blank(),
        panel.grid.major = element_blank(),
        axis.line = element_line(color="grey84", size = 0.5),
        legend.title = element_blank(),
        axis.text.x=element_text(size=12))
###############
