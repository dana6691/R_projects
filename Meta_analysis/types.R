# Pooling effect sizes = one overall effect size estimate of the studies
# Fixed-Effect-Model/Random-Effects-Model
# Continuous data/Binary outcome data
library(meta)
library(readxl)
madata <- read_excel("R_project/Meta_Analysis/data/Meta_Analysis_Data.xlsx")
str(madata)
#####################################################
#Data manipulation
#####################################################
# Convert to factor data
madata$RoB<-factor(madata$RoB)
madata$RoB
str(madata$RoB)
# Convert to logicals
madata$`intervention type`
intervention.type.logical<-as.logical(madata$`intervention type`=="mindfulness")
intervention.type.logical
#####################################################
#Fixed Effect Model
#####################################################
str(madata)
# Fixed Effect Model(TE column to retrieve the effect sizes for each study)
m <- metagen(TE,
             seTE,
             data=madata,
             studlab=paste(Author),
             comb.fixed = TRUE,
             comb.random = FALSE,
             prediction=TRUE,
             sm="SMD")
m
'1. individual effect sizes for each study, and their weight
 2. total number of included studies(k)
 3. overall effect, CI and p-value
 4. between study heterogeneity'
# 95% confidence interval for I^2
m$lower.I2
# save
sink("results.txt")
print(m)
sink()

# Raw Effect Size Data
library(readxl)
metacont <- read_excel("R_project/Meta_Analysis/data/metacont.xlsx")
str(metacont)
colnames(metacont)
metacont$Ne <- as.numeric(metacont$Ne)
metacont$Me <- as.numeric(metacont$Me)
metacont$Se <- as.numeric(metacont$Se)
metacont$Mc <- as.numeric(metacont$Mc)
metacont$Sc <- as.numeric(metacont$Sc)
m.raw <- metacont(Ne,
                  Me,
                  Se,
                  Nc,
                  Mc,
                  Sc,
                  data=metacont,
                  studlab=paste(Author),
                  comb.fixed = TRUE,
                  comb.random = FALSE,
                  prediction=TRUE,
                  sm="SMD")
m.raw
#####################################################
#Random Effect Model
#####################################################
library(meta)
library(metafor)
m.hksj <- metagen(TE,
                  seTE,
                  data=madata,
                  studlab=paste(Author),
                  comb.fixed = FALSE,
                  comb.random = TRUE,
                  method.tau = "SJ",
                  hakn = TRUE,
                  prediction=TRUE,
                  sm="SMD")
m.hksj
# without adjust with hakn
m.dl <- metagen(TE,
                seTE,
                data=madata,
                studlab=paste(Author),
                comb.fixed = FALSE,
                comb.random = TRUE,
                hakn = FALSE,
                prediction=TRUE,
                sm="SMD")
m.dl

# Raw effect size data
str(metacont)
m.hksj.raw <- metacont(Ne,
                       Me,
                       Se,
                       Nc,
                       Mc,
                       Sc,
                       data=metacont,
                       studlab=paste(Author),
                       comb.fixed = FALSE,
                       comb.random = TRUE,
                       method.tau = "SJ",
                       hakn = TRUE,
                       prediction=TRUE,
                       sm="SMD")
m.hksj.raw
#####################################################
#Binary Outcome
#metagen = generic inverse-variance method for pooling
#metabin(or metainc) function = Mantel-Haenszel method
#####################################################
library(readxl)
binarydata <- read_excel("R_project/Meta_Analysis/data/binarydata.xlsx")
str(binarydata)
# Raw data
m.bin <- metabin(Ee,
                 Ne,
                 Ec,
                 Nc,
                 data=binarydata,
                 studlab=paste(Author),
                 comb.fixed = FALSE,
                 comb.random = TRUE,
                 method.tau = "SJ",
                 hakn = TRUE,
                 prediction=TRUE,
                 incr=0.1,
                 sm="RR")
m.bin
# Plot data for event rate
labbe.metabin(x = m.bin,
              bg = "blue",
              studlab = TRUE,
              col.random = "red")
# Incident rate
load("R_project/Meta_Analysis/data/IRR.data.RData")
metainc(event.e,
        time.e,
        event.c,
        time.c,
        studlab = paste(Author),
        data = IRR.data,
        sm = "IRR",
        method.tau = "DL",
        comb.random = TRUE,
        comb.fixed = FALSE,
        hakn = TRUE)

# Pre-calculated effect sizes
library(dplyr)
library(kableExtra)
load("R_project/Meta_Analysis/data/bin.metagen.RData")
bin.metagen %>%
  kable() %>%
  kable_styling(position = "center", latex_options = c("striped")) %>%
  row_spec(0, bold = T)
# log-transform all the effect size data
bin.metagen$RR <- log(bin.metagen$RR)
bin.metagen$lower <- log(bin.metagen$lower)
bin.metagen$upper <- log(bin.metagen$upper)
# Standard Error = seTE
bin.metagen$seTE = (bin.metagen$upper - bin.metagen$lower)/3.92
# Meta Analysis
metagen(RR,
        seTE,
        studlab = Author,
        method.tau = "SJ",
        sm = "RR", #reconvert effect sizes to their original scale
        data = bin.metagen)
#####################################################
#Correlation
#####################################################
m.cor <- metacor(cor,
                 n,
                 data = cordata,
                 studlab = cordata$Author,
                 sm = "ZCOR",
                 method.tau = "SJ")
#####################################################
#Output = Forest Plot
#####################################################
forest(m.hksj.raw)
forest(m.hksj.raw,
       sortvar=TE,
       xlim = c(-1.5,0.5),
       rightlabs = c("g","95% CI","weight"),
       leftlabs = c("Author", "N","Mean","SD","N","Mean","SD"),
       lab.e = "Intervention",
       pooled.totals = FALSE,
       smlab = "",
       text.random = "Overall effect",
       print.tau2 = FALSE,
       col.diamond = "blue",
       col.diamond.lines = "black",
       col.predict = "black",
       print.I2.ci = TRUE,
       digits.sd = 2
)
#"RevMan5" layout
forest(m.hksj.raw,
       layout = "RevMan5",
       digits.sd = 2)
#Jama layout
library(grid)
forest(m.hksj.raw,
       layout = "JAMA",
       text.predict = "95% PI",
       col.predict = "black",
       colgap.forest.left = unit(15,"mm"))
#Save PDF
pdf(file='forestplot.pdf')
forest.jama<-forest(m.hksj.raw,
                    layout = "JAMA",
                    text.predict = "95% PI",
                    col.predict = "black",
                    colgap.forest.left = unit(15,"mm"))
dev.off()
#PNG
png(file='forestplot.png')
forest.jama<-forest(m.hksj.raw,
                    layout = "JAMA",
                    text.predict = "95% PI",
                    col.predict = "black",
                    colgap.forest.left = unit(15,"mm"))
dev.off()
#SVG
svg(file='forestplot.svg')
forest.jama<-forest(m.hksj.raw,
                    layout = "JAMA",
                    text.predict = "95% PI",
                    col.predict = "black",
                    colgap.forest.left = unit(15,"mm"))
dev.off()
#####################################################
#Between-study Heterogeneity = subgroups
#Heterogeneity Measures = Cochran's Q, Higgin's I^2, Tau-squared
#####################################################
# Assess the heterogeneity of your pooled effect size
print(m.hksj)
# Detecting outliers & influential cases

spot.outliers.random<-function(data){
  data<-data
  Author<-data$studlab
  lowerci<-data$lower
  upperci<-data$upper
  m.outliers<-data.frame(Author,lowerci,upperci)
  te.lower<-data$lower.random
  te.upper<-data$upper.random
  dplyr::filter(m.outliers,upperci < te.lower)
  dplyr::filter(m.outliers,lowerci > te.upper)
}

spot.outliers.random(data=m.hksj)
# Sensitivity analysis with exclude two outliers
m.hksj.outliers<-update.meta(m.hksj,
                             subset = Author != c("DanitzOrsillo",
                                                  "Shapiro et al."))
m.hksj.outliers
install.packages("HSAUR2")
library(HSAUR2)
data("smoking", package = "HSAUR2")
                     