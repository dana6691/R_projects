> mode(x)
[1] "numeric"
> mode(correctLogic)
[1] "logical"
> mode(incorrectLogic)
[1] "character" 
> mat<-matrix(c(2,3,1,5),nrow=2,ncol=2) 
> q<-c(v1,v2) #vector
#factor: make qualitative meaning
> settings<-c("High","Medium","Low")
> settings<-factor(settings) 
#list
> myList<-list(5,6,"seven", mat)
> myList
[[1]]
[1] 5
[[2]]
[1] 6
[[3]]
[1] "seven"
[[4]]
 [,1] [,2]
[1,] 2 1
[2,] 3 5 
#dataframe
> organism<-c("Human","Mouse","Fruit Fly", "Roundworm","Yeast")
> genomeSizeBP<-c(3000000000,3000000000,135600000,97000000,12100000)
> estGeneCount<-c(30000,30000,13061,19099,6034) 
> comparativeGenomeSize<-
data.frame(organism=organism,genomeSizeBP=genomeSizeBP,
+ estGeneCount=estGeneCount) 
make 3 columns

> #extracting specific elements 
> z3<-z[c(2,3)] 
> #logical extraction, note syntax
> z100<-z[z>100] 

> x<-c(1,3,2,1)
> y<-c(2,3,4,1)
> xy<-data.frame(x,y) 

> #create and bind column z to
> z<-c(2,1,4,7)
> xyz<-cbind(xy,z) 

> #create and bind new row w
> w<-c(3,4,7)
> xyz<-rbind(xyz,w)
> xyz
 x y z
1 1 2 2
2 3 3 1
3 2 4 4
4 1 1 7
5 3 4 7 

> #checking data object type
> is.vector(x) 

> y<-as.matrix(x)
> y 

> z<-as.character(x)
> z 

#list and remove
> ls()
[1] "v1" "v2" "x1" "x2" "x3" "z"
> rm(v1, z)
> ls()
[1] "v2" "x1" "x2" "x3" 


# Example 1 p. 18
set.seed(7638)
f <- factor( rep ( c(35, 40, 45 ), each = 4))
fac <- sample ( f, 12 )
eu <- 1:12
plan <- data.frame ( loaf = eu, time = fac )
write.csv( plan, file = "Plan.csv", row.names = FALSE )

# Example 2 p. 23
bread <- read.csv("Plan.csv")

# Example 3 p. 24
rm(bread)# remove bread
install.packages('gmodels')
library(daewr)#regression
mod0 <-lm( height ~ time, data = bread )
summary (mod0)

# Example 4 p. 25 (compare 35 40)
library(gmodels)
fit.contrast (mod0, "time", c(1, -1, 0) )

# Example 5 p. 27 (ANOVA)
mod1 <- aov( height ~ time, data = bread )
summary( mod1 )

# Example 6 p. 29 produces Figure 2.4
par( mfrow = c(2,2) )
plot( mod1, which = 5 )
plot( mod1, which = 1 )
plot( mod1, which = 2 )
plot( residuals(mod1) ~ loaf, main = "Residuals vs Exp. Unit", font.main = 1, data = bread)
abline( h=0, lty = 2 )

# Example 7 p. 32
library(MASS)
bc <- boxcox(mod1) # Box-Cox power transformation
lambda <- bc$x[ which.max( bc$y ) ]
lambda

# Example 8 p. 33
tbread <- transform(bread, theight = height^(-.5050505) )
mod2 <- aov( theight ~ time, data = tbread )
summary(mod2)

# Figure 2.7 p. 34
par( mfrow = c(2,2) )
plot( mod2, which = 5 )
plot( mod2, which = 1 )
plot( mod2, which = 2 )
plot( residuals(mod2) ~ loaf, main = "Residuals vs Exp. Unit", font.main = 1, data = tbread)
abline( h=0, lty = 2 )

# Example 9 p. 35
with( bread, { std <- sqrt( tapply( height, time, var) )
 weights <- rep( 1/std, each = 4 ) 
 mod3 <- lm( height ~ time, weights = weights, data = bread )
 anova( mod3 )
})

# Example 10 p. 37
library(daewr)
library(MASS)
modf <- polr( score ~ method, weight = count, data = teach )
modr <- polr( score ~ 1, weight = count, data = teach )
anova(modf, modr)

# Figure 2.8
meth <- cut(as.numeric(teach$method), c(-Inf, 1, 2, 3), labels = c('Method 1', 'Method 2', 'Method 3'))
class <- cbind(teach[ , 3:4], meth)
library(lattice)
barchart(count ~ score | meth, data = class, layout = c(1,3), horizontal = FALSE, xlab = "Score", col = "grey")

# Example 11 p. 40
library(daewr)
rmin <- 2 # smallest number of replicates
rmax <- 6 # largest number of replicates
alpha <- rep(0.05, rmax - rmin +1)
sigma <- sqrt(2.1)
nlev <- 3
nreps <- rmin:rmax
Delta <- 3
power <- Fpower1(alpha, nlev, nreps, Delta, sigma)  
power

# Example 12 p. 42 
library(daewr)
mod4 <- aov( yield ~ treat, data = sugarbeet )
con <- matrix( c(1, -1/3, -1/3, -1/3, 0, 1, -1, 0, 0, 0, 1, -1 ), 4, 3 )
L <- t(con)
rownames(L) <- c("-fertilizer effect", "-plowed vs broadcast", "-January vs April")
L


# Example 13 p. 42 
options( digits = 3)
library(gmodels)
fit.contrast(mod4, "treat", L)



# Example 14 p. 43
contrasts(bread$time) <- contr.poly(3)
contrasts(bread$time)

# Example 15 p. 43
mod3 <- aov( height ~ time, bread )
summary.lm(mod3)

# Example 16 p. 44
mod4 <- aov( yield ~ treat, data = sugarbeet )
mod4.tukey <- TukeyHSD( mod4, ordered = T )
mod4.tukey

# Example 17 p. 45
library(agricolae)
compare <- SNK.test( mod4, "treat",  alpha = 0.05 )
print(compare)

# Example 18 p. 46
summary(sugarbeet)

# Example 19 p. 47
library(multcomp)
sugar.dun <- glht(mod4, linfct = mcp( treat = "Dunnett"),
alternative = "greater")
summary(sugar.dun)

chocolate<- data.frame(
  Sabor =
    c(5, 7, 3,
      4, 2, 6,
      5, 3, 6,
      5, 6, 0,
      7, 4, 0,
      7, 7, 0,
      6, 6, 0,
      4, 6, 1,
      6, 4, 0,
      7, 7, 0,
      2, 4, 0,
      5, 7, 4,
      7, 5, 0,
      4, 5, 0,
      6, 6, 3
    ),
  Tipo = factor(rep(c("A", "B", "C"), 15)),
  Provador = factor(rep(1:15, rep(3, 15))))
tapply(chocolate$Sabor, chocolate$Tipo, mean)
#ANOVA - differences betweem type of chocolate and tasters.
ajuste <- lm(chocolate$Sabor ~ chocolate$Tipo + chocolate$Provador)
summary(ajuste)
anova(ajuste)
#tasters no significant effect on response
#type of chocolate has significant effect, test more
a1 <- aov(chocolate$Sabor ~ chocolate$Tipo + chocolate$Provador)
posthoc <- TukeyHSD(x=a1, 'chocolate$Tipo', conf.level=0.95)
#differences of B_A is not significant. 
plot(a1)
#confident level of B-A = 0, no different

install.packages('agricolae')
library(agricolae)
HSD.test(ajuste,'chocolate$Tipo')


library(agricolae)
data("PlantGrowth")

#check main effects and interaction
anova(lm(initialweight ~ treatment*size, data=df)) #significant for size, no interaction

#mean
ini<- tapply(df$initialweight, list(df$treatment, df$size), mean)
fin <- tapply(df$finalweight, list(df$treatment, df$size), mean)
data.frame(ini, fin)

#multiple comparison
#HSD(tukey honest significant difference)
#control type I error across the multiple comparison, 
attach(df)
tx <- with(df, interaction(treatment, size))
amod <- aov(finalweight ~ tx, data=df)
model <- aov(finalweight ~ treatment, data=df)
summary(model)
library(agricolae)
TukeyHSD(model, "treatment")


install.packages("multcomp")
library(multcomp)
tuk <- glht(amod, linfct = mcp(tx = "Tukey"))
summary(tuk)          # standard display
tuk.cld <- cld(tuk)   # letter-based display
opar <- par(mai=c(1,1,1,1))
?mai
plot(tuk.cld)
par(opar)


#Bonferroni Adjustment
#type I error rate(0.05)/#of test, too conservative
pairwise.t.test(df$initialweight, df$treatment, p.adj="bonferroni")
  #significant

#holm Adjustment
#type I error rate(0.05)/#of test, too conservative
pairwise.t.test(df$initialweight, df$treatment, p.adj="holm")
#significant

interaction.plot(df$treatment, df$size, df$initialweight)
attach(df)
anova(aov(initialweight ~factor(treatment)+factor(size)))


######   ANOVA 
anova.df<-aov(ds.df$initialweight ~ ds.df$treatment) 
summary(anova.df) 
summary.lm(anova.df) 

###### post HOC 
tukey.typabunmit<-TukeyHSD(anova.typabunmit) 
tukey.typabunmit 

###### HSD 

#two-way (ANOVA)
library(readxl)
df <- read_excel("Data arrangement for SAS1.xlsx")
summary(df)
install.packages("ggplot2")
library(ggplot2)
ggplot(df, aes(x=treatment,y=initial , colour=size)) +geom_point()
a=aov(initial ~ treatment + size,data=df)
a=aov(final ~ treatment + size,data=df)
summary(a)
out <- HSD.test(a,list("size","treatment"), group=TRUE)
plot(out, main="Different treatment")
df$treatment

out <- HSD.test(a,"treatment", group=FALSE)
print(out$comparison)
  #there is no interaction, there are no differences between the treatment. there is a differences between size.
#residual diagnosis plot
df$fit = fitted(a)
df$resid = resid(a)
ggplot(df, aes(df$fit, df$resid, colour=size)) + geom_point() + xlab("Fitted value") + ylab("Residuals") +facet_wrap(~treatment)
ggplot(df, aes(df$fit, df$resid, colour=treatment)) + geom_point() + xlab("Fitted value") + ylab("Residuals") +facet_wrap(~size)
#tukeyHSD
TukeyHSD(a, which="treatment")
#plot
df.hsd = data.frame(TukeyHSD(a, which="treatment")$treatment)
df.hsd$Comparison = row.names(df.hsd)
ggplot(df.hsd, aes(Comparison, y=diff, ymin=lwr, ymax=upr)) + geom_pointrange() + ylab("Difference in Mean INitialweight by treatment") + coord_flip()

