---
  title: "Word Cloud"
author: "Dahee Kim"
date: "`r Sys.Date()`"
output:
  prettydoc::html_pretty:
  theme: architect
  highlight: github
---

library(readxl)
library(NLP)
Q36 <- read_excel("Q36.xlsx")
Q36 <- read.csv("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/DaheeKim/Rfile/Rpubs/wordcloud/q44.csv")
dir(Q36)
Needed <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", 
            "cluster", "igraph", "fpc")
install.packages(Needed, dependencies = TRUE)
require(tm)

library(readxl)
Q36 <- read_excel("Q36.xlsx")
View(Q36)
docs <- Corpus(VectorSource(Q36))
summary(docs)       
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords('english'))
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

library(SnowballC)
docs <- tm_map(docs, stemDocument)
# Remove additional stopwords
docs <- tm_map(docs, removeWords, c('clintonemailcom', 'stategov', 'hrod'))

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

#--------------------------------------------------------------------;
#Wordcloud
#--------------------------------------------------------------------;
library(wordcloud)
library(RColorBrewer)
par(bg=grey30)
wordcloud(d$word, d$freq, col=terrain.colors(length(d$word), alpha=0.9), random.order=FALSE, rot.per=0.3)
dev.off()


#--------------------------------------------------------------------;
#sentiment
#--------------------------------------------------------------------;

install.packages("textdata")
library(syuzhet)

Q36 <- as.character(Q36)
d<-get_nrc_sentiment(Q36)
td<-data.frame(t(d))

names(td)
#The function rowSums computes column sums across rows for each level of a grouping variable.

#Transformation and cleaning
names(td)[1] <- 'count'
td_new <- cbind('sentiment' = rownames(td), td)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]
td_new2
#Visualisation
library(ggplot2)
qplot(sentiment, data=td_new2, weight=count, geom='bar',fill=sentiment)+ggtitle('Q36 sentiments')

#--------------------------------------------------------------------;
#UPDATE R:
#--------------------------------------------------------------------;
if(!require(installr)) {
  install.packages("installr"); require(installr)} #load / install+load installr

# using the package:
updateR() # this will start the updating process of your R installation. 
