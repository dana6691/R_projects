########################################################################################################
# Subset Data
########################################################################################################
dt[which(dt$cohort %in% c(9)),]
dt[which(dt$cohort == 1),]
########################################################################################################
# Change Data Types
########################################################################################################
# To Numeric
num_list <- c(16:18)
data[,num_list] <- sapply(data[,num_list], as.numeric)
# To Factor
factor_list <- c(1:5)
data[factor_list] <- lapply(data[factor_list], factor)
# To Datetime
dt$date <- as.Date(as.numeric(dt$date), origin = "1899-12-30")
# Date Difference
as.numeric(ch5$date - ymd('2021-9-10')+1)

########################################################################################################
# Mean and SD by group
########################################################################################################
dt <- data[,c("Application_Stage","Yield","Crop" ,"Product","Year","Treatment","Application_Style","Fertilizer", "Herbicide" , "Fungicide",  "Pesticide" )]
nrow(a)
a <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment, dt, function(x) c(mean = mean(x), sd = sd(x), n=length(x)),na.action = na.omit)
b <- aggregate(. ~ Crop + Year + Product + Application_Style + Treatment+Fertilizer+Herbicide+Fungicide+Pesticide, data = dt, function(x) c(mean=mean(x,na.rm=T), sd=sd(x,na.rm=T), n=length(x)), na.action = NULL)
write.csv(a,"C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/Desktop/DaheeKim/2021/FTI_MetaAnalysis/meta.csv")
########################################################################################################
# Break by group
########################################################################################################
dt$meangroup <- cut(dt$mean , breaks=c(0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44))          
dt$group <- cut(dt$weight, breaks=c(0,9.5,11.28,13.54,16.93,22.57,27.08,33.85,45.13,100),
                labels = c("NA","Extra Small","Small","Medium","Large","Extra Large","Jumbo","Extra Jumbo","Colossal"))
########################################################################################################
# Percent by group
########################################################################################################
dt %>% group_by(meangroup) %>%
  count(group) %>%
  mutate(percent= n / sum(n)*100) 
reshape2::dcast(a, meangroup ~ group)
