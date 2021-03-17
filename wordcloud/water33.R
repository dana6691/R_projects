#################
summary(water)
library(readxl)
water <- read_excel("water.xlsx", sheet = "Sheet2")
corr(water)
s <- water[,]
cor(water$goal,water[,2:11])
w<- water[,2:13]
cor(w,w$goal)
cor(w$goal, w[,1])
??Cor
water[,1:11]
water[,13]
water[is.na(water)] <- 0 
water[is.infinite(water[,2:13])] <- 0 
t.test(w$0,w$goal, paired=TRUE, conf.level=0.95 )
??var
plot(water[,3], water[,2])
length(water[,2])
plot(water[,1],water[,2],xlim=c(-2,2),ylim=c(-2,2))
plot(water[,c(2,13)])
#################################################################     
library(readxl)
water <- read_excel("C:/Users/daheekim/Desktop/water.xlsx")
x1 <- c(seq(0,1, by=0.01))
x2 <- seq(1,0, by=-0.01)
x <- data.frame(x1,x2)
for (i in 1:101){
  water[[paste0("needed",(i-1)/100)]] <- water$goal - water$Luverne*x1[i] - water$Lewis*x2[i]
}   

View(water)