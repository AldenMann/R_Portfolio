library(tidyverse)
library(skimr)
library(scales)

wd = getwd()
setwd(wd)

data = read.csv(choose.files(), na.strings = c(""))

# head(data)
# tail(data)
# str(data)

# Fix the character issues!

data2.0 = data %>% 
      mutate(Expenses = as.numeric(gsub("[\\$, Dollars]", "", Expenses)),  # Remove '$', ',', and " Dollars"
             Revenue = as.numeric(gsub("[\\$,]", "", Revenue)),    # Remove '$' and ','
             Profit = as.numeric(Profit), 
             Growth = as.numeric(gsub("%", "", Growth))
  ) %>% 
  mutate(State = case_when(City == 'San Francisco' ~ 'CA', 
                           City == 'New York' ~ 'NY', 
                           TRUE ~ State),  # Keep original State if no match
         Industry = case_when(Name == 'Techline' ~ 'IT Services', 
                              Name == 'Cityace' ~ 'Retail', 
                              TRUE ~ Industry),  # Keep original Industry if no match
         Expenses = ifelse(is.na(Expenses), Revenue - Profit, Expenses),
         Inception = ifelse(Name == 'Lathotline', '2011', Inception)) %>% 
  drop_na()


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

#Data - scatter plot classified by industry showing revenue, expenses and profit :
p = ggplot(data = data2.0)

p + geom_point(aes(x = Revenue, y = Expenses,
                          color = Industry, size = Profit))    

#Industry trends for expenses: 

p_2 = ggplot(data = data2.0, aes(x = Revenue, y = Expenses, color=Industry))

# Smooth helps us see the trends a little better. This is still a little messy for me personally. 
p_2 + geom_point() + 
  geom_smooth(fill = NA, size = 1.2)


#Boxplot: This is a much better way of displaying that data. 

p_3 = ggplot(data = data2.0, aes( x = Industry, y = Growth, 
                            color=Industry))

p_3 + geom_jitter() + 
  geom_boxplot(size = 1, alpha = 0.5, outlier.colour = NA)





