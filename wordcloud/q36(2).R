#--------------------------------------------------------------------;
#tidytext library - https://www.tidytextmining.com/sentiment.html
#--------------------------------------------------------------------;
library(readxl)
q36<- read_excel("Q36.xlsx")
head(q36)
q36$ID <- c(1:95)
str(q36)
names(q36)[1] <- "text"
q <- q36[c("ID","text")]

library(dplyr)
require(tidytext)
tidy_q <- q %>%
              unnest_tokens(word, text)
head(tidy_q)

library(knitr)
data(stop_words)
#custom stopwords
custom_stop_words <- bind_rows(stop_words,
                               data_frame(word = c("cooked","shrimp","seafood","cooking","iâ"),
                                          lexicon = "custom"))
tidy_ftp <- tidy_q %>% 
               anti_join(custom_stop_words) %>%  
               count(word,sort=TRUE)

bars <- tidy_ftp  %>% 
           filter(n > 1) %>%
            mutate(word = reorder(word, n))
  
ggplot(bars, aes(word, n)) +
  geom_col(stat = "identity", fill = "firebrick1",color = "firebrick1", alpha = 0.4) +
  labs(title = "Q36", subtitle = "What makes you less comfortable cooking shrimp?", x = "Word", y = "Count") +
  coord_flip() +
  theme_minimal()



filePath = read_excel("C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/DaheeKim/Rfile/Rpubs/wordcloud/q44.xlsx")
head(filePath)
write.table(filePath, file = "C:/Users/daheekim/OneDrive - Ralco Nutrition, Inc/DaheeKim/Rfile/Rpubs/wordcloud/q44.txt", sep = "\t",row.names = TRUE, col.names = NA)

