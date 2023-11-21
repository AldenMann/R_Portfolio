library(tidyverse)
library(DT)

data = read.csv(choose.files())

data_metaScore = data$meta_score %>% 
  quantile(c(0.25, 0.75), na.rm = TRUE)

data_userScore = data$user_score %>% 
  quantile(c(0.25, 0.75), na.rm = TRUE)

data %>% 
  datatable(rownames = FALSE) %>% 
  formatStyle("meta_score", background = styleColorBar(data_metaScore,"lightgreen")) %>%
  formatStyle("user_score", background = styleColorBar(data$user_score,"lightgreen"))

