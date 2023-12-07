library(tidyverse)
library(DT)
library(igraph)

data = palmerpenguins::penguins %>% drop_na()

data %>% 
  group_by(species) %>% 
  summarise("Average in mm" = mean(bill_length_mm))
#---
 