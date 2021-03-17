library(readxl)
water <- read_excel("C:/Users/daheekim/Desktop/water2.xlsx")
x1 <- c(seq(0,1, by=0.01))
x2 <- seq(1,0, by=-0.01)
x <- data.frame(x1,x2)
for (i in 1:101){
  water[[paste0("needed",(i-1)/100)]] <-water$Luverne*x1[i] + water$Lewis*x2[i]
}


list <- c("Chloride",
          "Sodium",
          "Sulfate",
          "Magnesium",
          "Calcium",
          "Postassium",
          "Strontium",
          "Fluoride"
)
water <- subset(water, X__1 %in%list)

#delete LOw HIGH, LU LEwis
water[,c(1,3:6)] <- NULL


water<- as.matrix(water)
View(water)


#wilcoxon
vector6 = c()
wilcoxon <- for(i in (2:ncol(water))){
  var <- water[,1]
  var6 <- water[,i]
  wilcoxon <- t.test(var,var1, paired=TRUE,conf.level = 0.95)$p.value
  vector6 <- c(vector6, wilcoxon)
}



plot(vector6 , type="b", pch=19, col="red", xlab = "(%) percentage of Luverne",ylab="p-value",main="Paired t-test")
