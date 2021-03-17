#three way ANOVA
data1 <-na.omit(data1)
str(data1)
data1$Tank <- as.factor(data1$Tank)
#Let us first get a graphical insight of the data. 
#We want to graphically explore how the average braking distance changes given specific levels of the factors considered. 
#Thus we first plot the univariate effects.
plot.design(value ~ ., data = data1)

#Plots of two-way interaction effects of factors on Distance response variable
op <- par(mfrow = c(3, 1))
with(data1, {
  interaction.plot(Date, Tank, value)
  interaction.plot(Date, variable, value)
  interaction.plot(Tank, variable, value)
}
)
par(op)
# The weight of RTB4 and 2 seems to lighter than RTB1 as compared to Location 1,2,3. 
# There may be an interaction between 

#3way ANOVA
fm <- aov(value ~ Date*Tank*variable, data = data1)
fm  
fm <- aov(Distance ~ ABS + Tire + Tread + ABS:Tire + ABS:Tread + Tire:Tread
            + ABS:Tire:Tread, data = distance)
summary(fm)

