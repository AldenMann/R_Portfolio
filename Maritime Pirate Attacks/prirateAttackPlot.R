PirateAttacks_df = data_pirates # separating this as working data from the original loaded data.

pirates = PirateAttacks_df 
  
  
pirate_hm_impute = pirates %>% # get median time of day data to impute
  filter(!is.na(time)) %>% # only values with time data
  mutate(time = hm(time)) # convert to hour minutes with lubridate. Next step to is get median. 

pirate_hm_median = pirate_hm_impute %>% 
  select(time) %>% # selecting only the time column. 
  # need to get median time in hours and minutes
