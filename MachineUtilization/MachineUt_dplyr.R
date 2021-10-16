## Machine Ulitilization 

# Project Brief:
# You have been engaged as a Data Science consultant by a coal terminal. They would
# like you to investigate one of their heavy machines - RL1
# You have been supplied one month worth of data for all of their machines. The
# dataset shows what percentage of capacity for each machine was idle (unused) in any
# given hour. 
# 
# You are required to deliver an R list with the following components:
#   
# 1. Character: Machine name
# 2. Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
# 3. Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
# 4. Vector: All hours where utilisation is unknown (NA's)
# 5. Dataframe: For this machine
# 6. Plot: For all machines

library(tidyverse)
library(lubridate)
library(scales)
library(skimr)

data = read.csv(choose.files(), na.strings = c(""))

skim(data) # Checking for missing values and character types

head(data)
tail(data)

# unique(data$Machine)

# Machines with Unknown times:
unkwnReport = data %>% 
  select(Timestamp, Machine, Percent.Idle) %>% 
  filter(!complete.cases(Percent.Idle)) %>% 
  group_by(Machine) %>% 
  summarise('Hours Unkown' = n())

idleFlage = data %>% 
  mutate(Timestamp = dmy_hm(Timestamp)) %>% 
  filter(Percent.Idle >= .10) %>% 
  group_by(Machine) %>% 
  summarise("Instances under 90%" = n())

data_clean = data %>% 
  select(Timestamp, Machine, Percent.Idle) %>% 
  drop_na()

plot_machines = ggplot(data_clean, aes(x = Timestamp, y = Percent.Idle, color = Machine )) 

plot_machines + 
  geom_point() +
  labs(title = "Percent Idle All Machines",
       xlab = "Month",
       ylab = "Percent Idle")



