randomizr package

library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                             sheet = "Sheet1")

library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                   sheet = "Sheet2")

library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                   sheet = "Sheet3")

library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                   sheet = "Sheet5")
head(data)

library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                   sheet = "Sheet6")
a1 <- aov(Individual ~ Treatment, data)
summary(a1)
boxplot(Individual ~ Treatment, data=data, main="treatments")  # clear pattern is noticeable.


library(readxl)
data <- read_excel("Desktop/TankAssignment.xlsx", 
                   sheet = "Sheet1")
###################################################################


library(multcomp)
data$Treatment2 <- as.factor(data$Treatment)
init.aov <- aov(Individual ~Treatment2, data)
init.glt <- summary(glht(init.aov, linfct=mcp(Treatment2 = "Tukey")))
init.cld <- cld(init.glt)
plot(Treatment2)

table(data$Treatment, data$Location)
