########################################################################################################
# Multiple Variables to Numeric Types
########################################################################################################
num_list <- c(16:18)
data[,num_list] <- sapply(data[,num_list], as.numeric)
########################################################################################################
# Finding Mean and SD by group
########################################################################################################
dt <- data[,c("Application_Stage","Yield","Crop" ,"Product","Year","Treatment","Application_Style","Fertilizer", "Herbicide" , "Fungicide",  "Pesticide" )]
nrow(a)
a <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment, dt, function(x) c(mean = mean(x), sd = sd(x), n=length(x)),na.action = na.omit)
b <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment+Fertilizer+Herbicide+Fungicide+Pesticide, data = dt, function(x) c(mean=mean(x,na.rm=T), sd=sd(x,na.rm=T), n=length(x)), na.action = NULL)
write.csv(a,"C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2021/FTI_MetaAnalysis/meta.csv")
