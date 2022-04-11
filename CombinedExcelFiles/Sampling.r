library(readxl)
library(rio) # import_list

# set directory
setwd("address")
# retrieve a list of xlsx files
files =list.files(recursive = TRUE,pattern=".xlsx")

# combine multiple files into one dataframe
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
