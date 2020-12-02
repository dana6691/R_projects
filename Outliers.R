##############################
# Univariate approach
##############################
# Method 1
impute_outliers <- function(x,removeNA = TRUE){
  quantiles <- quantile( x, c(.05, .95 ),na.rm = removeNA )
  x[ x < quantiles[1] ] <- mean(x,na.rm = removeNA )
  x[ x > quantiles[2] ] <- median(x,na.rm = removeNA )
  x
}
imputed_data <- impute_outliers(VCOMBCT$CT)
par(mfrow = c(1, 2))
boxplot(VCOMBCT$CT, main="Pressure Height having Outliers", boxwex=0.3)
boxplot(imputed_data, main="Pressure Height with imputed data", boxwex=0.3)
# Method 2 - Boxplot
VCOMBCT <- read.csv(file = 'N:/DaheeKim/Pig_Trial/VCOMBCT.csv')
out <- boxplot.stats(VCOMBCT$CT)$out
out_ind <- which(VCOMBCT$CT %in% c(out))
VCOMBCT[out_ind, ]
# Method 2 - Same
VCOMBCT <- read.csv(file = 'N:/DaheeKim/Pig_Trial/VCOMBCT.csv')
VCOMBCT %>%
  identify_outliers(CT)
# Method 2 - Same
VCOMBCT <- read.csv(file = 'N:/DaheeKim/Pig_Trial/VCOMBCT.csv')
outliers <- boxplot(VCOMBCT$CT, plot=FALSE)$out
VCOMBCT[which(VCOMBCT$CT %in% outliers),]


# Method 3 - Percentiles
VCOMBCT <- read.csv(file = 'N:/DaheeKim/Pig_Trial/VCOMBCT.csv')
lower_bound <- quantile(VCOMBCT$CT, 0.01, na.rm=TRUE)
upper_bound <- quantile(VCOMBCT$CT, 0.99, na.rm=TRUE)
outlier_ind <- which(VCOMBCT$CT < lower_bound | VCOMBCT$CT > upper_bound)
VCOMBCT[outlier_ind, ]

VCOMBCT <- read.csv(file = 'N:/DaheeKim/Pig_Trial/VCOMBCT.csv')
lower_bound <- quantile(VCOMBCT$CT, 0.05, na.rm=TRUE)
upper_bound <- quantile(VCOMBCT$CT, 0.95, na.rm=TRUE)
outlier_ind <- which(VCOMBCT$CT < lower_bound | VCOMBCT$CT > upper_bound)
VCOMBCT[outlier_ind, ]
nrow(VCOMBCT[outlier_ind, ])


# Method 4 - Hampel filter
lower_bound <- median(VCOMBCT$CT) - 3 * mad(VCOMBCT$CT)
upper_bound <- median(VCOMBCT$CT) + 3 * mad(VCOMBCT$CT)
outlier_ind <- which(VCOMBCT$CT < lower_bound | VCOMBCT$CT > upper_bound)
VCOMBCT[outlier_ind, ]
##############################
# Multivariate approach
##############################
# Method 1 - CooksD
model <- lm(COPIES ~ DAY|alival|trt, data = VCOMBCT)
cooksd <- cooks.distance(model)
plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")  # plot cook's distance
abline(h = 4*mean(cooksd, na.rm=T), col="red")
abline(h = -4*mean(cooksd, na.rm=T), col="red")
text(x=1:length(cooksd)+1, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T),names(cooksd),""), col="red")
influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))])  # influential row numbers
VCOMBCT[influential, ]
# Method 2 - Standar.Resid
model <- lm(COPIES ~ DAY|alival|trt, data = VCOMBCT)
model.metrics <- augment(model)
outlier <- model.metrics %>% 
  filter(abs(.std.resid) > 3) %>%
  as.data.frame()
VCOMBCT[outlier$.rownames,]
# Method 3 - boxplot method
VCOMBCT %>%
  group_by(DAY, alival, trt) %>%
  identify_outliers(CT)
##############################
# Multivariate approach - auto
##############################
# CooksD
magic_for(print, silent = TRUE) 
for (i in 6:7){ # dependent variable
  dt <- VCOMBCT # dataset
  model <- lm(dt[[i]] ~ DAY + trt|alival, data = dt) # Fit the model, the covariate goes first
  cooksd <- cooks.distance(model)
  influential <- as.numeric(names(cooksd)[(cooksd > 4*mean(cooksd, na.rm=T))]) 
  outliers <- dt[influential, ]
  # Colname, Outlier in your dataset, cookd
  print(colnames(dt[i]), outliers)
  #outlier plot
  plot(cooksd, pch="*", cex=2, main="Influential Obs by Cooks distance")
  abline(h = 4*mean(cooksd, na.rm=T) ,col="red")  # add cutoff line
  text(x=1:length(cooksd)+15, y=cooksd, labels=ifelse(cooksd>4*mean(cooksd, na.rm=T), names(cooksd),""), col="red")  # add labels
}
magic_result()

# Standar.Resid
library(magicfor) 
library(dplyr)
library(rstatix)
magic_for(print, silent = TRUE) 
for (i in 6:7){ # dependent variable
  dt <- VCOMBCT # dataset
  model <- lm(dt[[i]] ~ DAY + trt|alival, data = dt) # Fit the model, the covariate goes first(ANCOVA)
  limit <- 3
  std_resid <- augment(model)%>% 
    filter(abs(.std.resid) > limit) %>%
    as.data.frame()
  outlier = std_resid[order(std_resid$.std.resid,decreasing=TRUE),]
  outliers =dt[std_resid$.rownames,]
  # Colname, Outlier, Outlier in your dataset, cookd
  print(colnames(dt[i]), outlier, outliers)
  #outlier plot
  plot(augment(model)$.rownames,augment(model)$.std.resid, pch="*", cex=2, main="Influential Obs by standardized residual")
  abline(h = limit, col="red")  # add cutoff line
  abline(h = -limit, col="red")  
  text(x=as.numeric(augment(model)$.rownames)+15, y=augment(model)$.std.resid, labels=ifelse(abs(augment(model)$.std.resid)>limit, augment(model)$.rownames,""), col="red")  
}
magic_result()
