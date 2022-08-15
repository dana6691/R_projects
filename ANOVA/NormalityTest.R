library(dplyr)
ch5 %>%
  group_by(tenure) %>%
  summarise(statistic = shapiro.test(weight)$statistic,
            p.value = shapiro.test(weight)$p.value)
