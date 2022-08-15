library(nls2)
library(proto)
library(dplyr)
library(aomisc)
all_func2 <- function(dt,Y){
  # Polynomial
  try(poly3 <- lm(Y ~ poly(Avg_Weight,3),data=dt),TRUE)
  try(poly4 <- lm(Y ~ poly(Avg_Weight,4),data=dt),TRUE)
  # logistic 
  #try(lr3_2 <- nls(Y ~ SSlogis(Avg_Weight, d, e, scal), data = dt),TRUE)
  #try(lr4_2 <- nls(Y ~ SSfpl(Avg_Weight, c, d, e, scal), data = dt,alg = "port",lower=list(c=0)),TRUE) 
  try(lr3 <- nls( Y~ NLS.L3(Avg_Weight, b, d, e), data = dt),TRUE)
  try(lr4 <- nls(Y ~ NLS.L4(Avg_Weight, b, c, d, e), data = dt,alg = "port",lower=list(c=0)),TRUE) 
  ## Gompertz
  try(G3 <- nls(Y ~ NLS.G3(Avg_Weight, b, d, e),data = dt))
  try(G4 <- nls(Y ~ NLS.G4(Avg_Weight, b, c, d, e), data = dt,alg = "port",lower=list(c=0)),TRUE) 
  try(SSgompertz <- nls(Y ~ SSgompertz(Avg_Weight, Asym, b2, b3),data = dt),TRUE)
  ## Modified Gompertz
  try(Gom.alt.3 <- nls(Y ~ NLS.E3(Avg_Weight, b, d, e), data = dt) ,TRUE)
  try(Gom.alt.4 <- nls(Y ~ NLS.E4(Avg_Weight, b, c, d, e), data = dt,alg = "port",lower=list(c=0)),TRUE )
  ## Weibull (type 1)
  nlc <- nls.control(maxiter = 4000)
  #try(wei.13   <- nls(Y ~ NLS.W1.3(Avg_Weight, b, d, e), data = dt,control = nlc),TRUE)
  try(wei.13_2 <- drm(Y ~ Avg_Weight, fct = W1.3(), data = dt),TRUE)
  #try(wei.14   <- nls(Y ~ NLS.W1.4(Avg_Weight, b, c, d, e), data = dt,control = nlc),TRUE)
  try(wei.14_2 <- drm(Y ~ Avg_Weight, fct = W2.4(), data = dtt,lowerl=c(NA,0,NA,NA)),TRUE)
  ## Weibull (type 2)
  #try(wei.23   <- nls(Y ~ NLS.W2.3(Avg_Weight, b, d, e), data = dt),TRUE)
  try(wei.23_2 <- drm(Y ~ Avg_Weight, fct = W2.3(), data = dt),TRUE)
  #try(wei.24   <- nls(Y ~ SSweibull(Avg_Weight, Asym, Drop, lrc, pwr), data = dt,alg = "port",lower=list(c=0)),TRUE)
  try(wei.24_2   <- drm(Y ~ Avg_Weight, fct = W2.4(), data = dt,lowerl=c(NA,0,NA,NA)),TRUE)
  ## log-logistic
  try(loglogi.4 <- nls(Y ~ NLS.LL4(Avg_Weight, b, c, d, e), data = dt),TRUE)
  try(loglogi.3 <- nls(Y ~ NLS.LL3(Avg_Weight, b, d, e), data = dt),TRUE)
  ## Exponential decay
  try(expd2 <- drm(Y ~ Avg_Weight, fct=EXD.2(),data = dt),TRUE)
  try(expd3 <- drm(Y ~ Avg_Weight, fct=EXD.3(),data = dt),TRUE)
  ## power
  try(power <- nls(Y ~ NLS.powerCurve(Avg_Weight, a, b),data = dt),TRUE)
  ## asymptotic
  try(asym <- nls(Y ~ NLS.asymReg(Avg_Weight, c, m, d) ,data = dt,control=nlc),TRUE)
  ## asymptotic started from zero in y: Asym*(1 - exp(-exp(lrc)*input))
  try(asym4 <-nls(Y ~ SSasympOrig(Avg_Weight, Asym, lrc), data = dt,control=nlc),TRUE)
  ## logarithmic
  #log <- drm(ADG_lb ~ Avg_Weight, fct = MM.2(), data = data2)
  try(log <- nls(Y ~ NLS.logCurve(Avg_Weight, a, b),data = dt),TRUE)
  ## rectangular hyperbola
  try(rect <- nls(Y ~ SSmicmen(Avg_Weight, Vm, K), data = dt),TRUE)
  rmse <- function(param){
    sqrt(mean(residuals(param)^2))
  }
  elements <- list(try(poly3,TRUE),try(poly4,TRUE),try(lr3,TRUE),try(lr4,TRUE),try(G3,TRUE),try(G4,TRUE),try(Gom.alt.3,TRUE),try(Gom.alt.4,TRUE),
                   try(wei.13_2,TRUE),try(wei.14_2,TRUE),try(wei.23_2,TRUE),try(wei.24_2,TRUE),
                   try(loglogi.3,TRUE),try(loglogi.4,TRUE),try(expd2,TRUE),try(expd3,TRUE),try(power,TRUE),
                   try(asym,TRUE),try(asym4,TRUE),try(log,TRUE),try(rect,TRUE))
  rmse_f <- function (x) {
    tryCatch(rmse(x), error=function(e) NULL)}
  aic_f <- function (x) {
    tryCatch(AIC(x), error=function(e) NULL)}
  bic_f <- function (x) {
    tryCatch(BIC(x), error=function(e) NULL)}
  a <- cbind(lapply(elements, rmse_f))
  b <- cbind(lapply(elements, aic_f))
  c <- cbind(lapply(elements, bic_f))
  name_m <- c("Polynomial 3","Polynomial 4","Logistic 3","Logistic 4","Gompertz 3","Gompertz 4","Modified Gompertz 3","Modified Gompertz 4",
              "Weibull 1.3(2)","Weibull 1.4(2)","Weibull 2.3(2)","Weibull 2.4(2)",
              "Log-logistic 3","Log-logistic 4","Exponential Decay 2","Exponential Decay 3","Power",
              "Asymptotes","Asymptotes 4","Logarithmatic","Rectangular")
  comb <- as.data.frame(cbind(a,b,c))
  rownames(comb) <- name_m
  print(comb)
}
all_func2(dt3, dt3$Density)
all_func2(dt4, dt4$Density)
##################################################################################
#Density vs Avg_weight - plot
##################################################################################
library("ggpubr")
ggscatter(dt3, x = "Avg_Weight", y = "Density", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Density", ylab = "Antenna Length")
library(drc)
library(ggplot2)
# gompertz 3 (HG)
dt33 <- dt3[,c("Density","Avg_Weight")]
dt33 <- na.omit(dt33)
G3 <- nls(Density~ NLS.G3(Avg_Weight, b, d, e),data = dt33)
par(bg = 'grey95')
ggplot() + geom_point(data=dt33, aes(x=Avg_Weight, y=Density),size=2,alpha=0.5) +
  geom_line(data=dt33, aes(x=sort(Avg_Weight),sort(fitted(G3))),size=1.1,color="grey30",alpha=0.5) +
  labs(title="Density Change by Average Weight with Gompertz (HG)", subtitle="Cohort 1,3,5,7,8,9,10,11",
       y="Density (Kg/M3)", x="Averge Weight (g)")+
  theme_classic()
