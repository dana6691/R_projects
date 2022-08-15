library(readxl)
library(rio) # import_list
###########################################################################
# combine multiple files into one dataframe
###########################################################################
# combine multiple files into one dataframe
# set directory
setwd("address")
# retrieve a list of xlsx files
files =list.files(recursive = TRUE,pattern=".xlsx")
sheet <- NULL;
file <- NULL;
folder <- NULL;
data <- NULL;
for(j in 1:70){
  filename=files[j]
  data_list <-import_list(filename, range = "B5:D55")
  data_list2 <-import_list(filename, range = "A1:B3", col_names = FALSE)
  for(i in 1:length(data_list)){
    data <- data_list[[i]][!rowSums(is.na(data_list[[i]]))==3,]
    data$cohort <- rep(data_list2[[i]][1,2],nrow(data))
    data$tank <- rep(data_list2[[i]][2,2],nrow(data))
    data$date <- rep(data_list2[[i]][3,2],nrow(data))
    sheet <- rbind(sheet,data)
  }
  folder <- rbind(file,sheet)
  print(paste0("success: ", j))
}

###########################################################################
# combine multiple files into one dataframe (2)
###########################################################################
setwd("M:/tru Shrimp Systems/Balaton Technology Center/Performance Curves/Sampling/Graphs")
files =list.files(recursive = TRUE,pattern=".xlsx")
sheet <- NULL;
file <- NULL;
folder <- NULL;
data <- NULL;
for(j in c(1:76,78)){
  filename=files[j]
  data_list <-import_list(filename, range = "B5:D55")
  data_list2 <-import_list(filename, range = "A1:B3", col_names = FALSE)
  for(i in 1:length(data_list)){
    data_list[[i]] <- data_list[[i]][!rowSums(is.na(data_list[[i]]))==3,]
    melt <- reshape2::melt(data_list[[i]],measure.vars=c("Location 1", "Location 2", "Location 3"))
    melt <- na.omit(melt)
    mean <-  mean(melt$value, na.rm = TRUE)
    #std <-  sd(melt$value, na.rm = TRUE)
    melt$mean = rep(mean,nrow(melt))
    #melt$std = rep(std,nrow(melt))
    melt$cohort <- rep(data_list2[[i]][1,2],nrow(melt))
    melt$tank <- rep(data_list2[[i]][2,2],nrow(melt))
    melt$date <- rep(data_list2[[i]][3,2],nrow(melt))
    #melt$Date <- as.Date(as.numeric(melt$date),origin = "1899-12-30")
    sheet <- rbind(sheet,melt)
  }
  folder <- rbind(file,sheet)
  print(paste0("success: ", j))
}
nrow(folder)
head(folder)
