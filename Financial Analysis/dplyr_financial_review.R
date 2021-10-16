library(tidyverse)
library(skimr)

wd = getwd()
setwd(wd)

data = read.csv(choose.files(), na.strings = c(""))

# head(data)
# tail(data)
# str(data)

# Fix the character issues!

data2.0 = data %>% 
  mutate(Expenses = gsub("Dollars", "", Expenses), # Removed "Dollars".
         Expenses = gsub(",", "", Expenses), # Removed commas and the space.
         Expenses = str_squish(Expenses),
         Expenses = as.numeric(Expenses), # Changed to integer (hopefully. Will need to check later.).
         Revenue = gsub("\\$", "", Revenue), # used esscape sequence '\\' to remove '$'. 
         Revenue = gsub(",", "", Revenue),# Removed commas and the space.
         Revenue = as.numeric(Revenue), # Makes Revenue MATHEMATICAL MAN!
         Profit = as.numeric(Profit), # Makes Profits MATHEMAICAL MAN!
         Growth = gsub("%", "", Growth), # Removed % symbol from values. 
         Growth = as.numeric(Growth)) %>% 
  mutate(State = ifelse(City == 'San Francisco', 'CA', State),
         State = ifelse(City == 'New York', 'NY', State),
         Industry = ifelse(Name == 'Techline', 'IT Services', Industry),
         Industry = ifelse(Name == 'Cityace', 'Retail', Industry),
         Expenses = ifelse(is.na(Expenses), Revenue-Profit, Expenses),
         Inception = ifelse(Name == 'Lathotline', '2011', Inception)) %>% 
  drop_na() # two construction columns with NA values for all cash are dropped. 




head(data2.0, 25)
tail(data2.0, 25)
str(data2.0)


# Finding rows with missing or NA values for Construction Revenue

# CON_MEDIAN = data2.0 %>% 
#   select(Industry, Revenue) %>% 
#   filter(Industry == 'Construction') %>% 
#   summarise(median(Revenue, na.rm = TRUE)) %>% 
#   as.numeric()
# mutate(Revenue = ifelse(is.na(Revenue), CON_MEDIAN, Revenue)) # This is an example of how to replace NA values. But it won't be needed for this data.

data2.0 %>% 
  filter(!complete.cases(data2.0)) # I run this each time to test changes.

# data2.0 %>%  Start messing with the data:
#   mutate() 

# I wanted to see what options were available for the industry before replacing:
unique(data$Industry)

#--------- Now that the data is cleaned We'll Start Graphing!--------------'


          