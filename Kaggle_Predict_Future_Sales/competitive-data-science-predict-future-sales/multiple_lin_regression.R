# Script


library(tidyverse)
library(lubridate)
library(caTools)

data_train = read.csv(choose.files())

data_test = read.csv(choose.files())


glimpse(data_train)

data_train_fmt = data_train %>% 
  select(-date_block_num) %>% 
  mutate(date = dmy(date),
         shop_id = factor(shop_id),
         item_id = factor(item_id)) %>% 
  filter(date >= "2015-01-01") # There is too much data for my dinky laptop. Selecting only 2015

glimpse(data_train_fmt)

set.seed(123)
split = sample.split(data_train_fmt, SplitRatio = 0.8)
training_set = subset(data_train_fmt, split == TRUE)
test_set = subset(data_train_fmt, split == FALSE)

regressor = lm(formula = item_cnt_day ~ .,
               data = training_set)

y_pred = predict(regressor, newdata = test_set)

head(data_train_fmt, 25)
