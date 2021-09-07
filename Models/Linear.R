###############################
# ANOVA Model
dat <- read.csv("https://raw.githubusercontent.com/ucdavis-bioinformatics-training/2018-September-Bioinformatics-Prerequisites/master/friday/lm_example_data.csv")
head(dat)
###############################
# One-way ANOVA
oneway.model <- lm(expression ~ treatment, data = dat)
summary(oneway.model)
coef(oneway.model) # coefficients
treatmentmeans <- tapply(dat$expression, dat$treatment, mean) # Get means in each treatment
treatmentmeans["A"] 
# One-way ANOVA without intercept
no.intercept.model <- lm(expression ~ 0 + treatment, data = dat) # '0' means 'no intercept' here
summary(no.intercept.model)
coef(no.intercept.model)
# One-way ANOVA + one covariate
batch.model <- lm(expression ~ treatment + batch, data = dat)
summary(batch.model)
coef(batch.model)
# Two-way ANOVA
twoway.model <- lm(expression ~ treatment*time, data = dat)
summary(twoway.model)
interaction.plot(x.factor = dat$time, trace.factor = dat$treatment, response = dat$expression)
# Two-way ANOVA Contract
dat$tx.time <- interaction(dat$treatment, dat$time)
dat$tx.time
table(dat$tx.time, dat$treatment)
table(dat$treatment, dat$tx.time)
other.2way.model <- lm(expression ~ 0 + tx.time, data = dat)
summary(other.2way.model)
###############################
# Linear Regression
###############################
library("faraway")
data(gala)
lmod <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, data=gala)
summary(lmod)
# Coefficients (1)
coef(lmod) 
# Coefficients (2) = QR Decomposition, good to use for collinearity
x <- model.matrix(~ Area + Elevation + Nearest + Scruz + Adjacent, data=gala)
y <- gala$Species
dim(qr.Q(qr(x)))
f <- t(qr(Q(qr(x))) %*% y)
# Residual Standard Error
names(lmod)
names(summary(lmod))
summary(lmod)$sigma
# Standard Error of Coefficients
summary(lmod)$coef[,2]
###############################
# Linear Regression (2)
###############################
library(VarReg)
lm_mod <- lm(accel ~ times, data = mcycle)
# Visualize the model
termplot(lm_mod, partial.resid = TRUE, se = TRUE)
