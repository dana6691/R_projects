########################################################################################################
# Change to Different Data Types
########################################################################################################
# To Numeric
num_list <- c(16:18)
data[,num_list] <- sapply(data[,num_list], as.numeric)
# To Factor
factor_list <- c(1:5)
data[factor_list] <- lapply(data[factor_list], factor)
########################################################################################################
# Finding Mean and SD by group
########################################################################################################
dt <- data[,c("Application_Stage","Yield","Crop" ,"Product","Year","Treatment","Application_Style","Fertilizer", "Herbicide" , "Fungicide",  "Pesticide" )]
nrow(a)
a <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment, dt, function(x) c(mean = mean(x), sd = sd(x), n=length(x)),na.action = na.omit)
b <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment+Fertilizer+Herbicide+Fungicide+Pesticide, data = dt, function(x) c(mean=mean(x,na.rm=T), sd=sd(x,na.rm=T), n=length(x)), na.action = NULL)
write.csv(a,"C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2021/FTI_MetaAnalysis/meta.csv")
