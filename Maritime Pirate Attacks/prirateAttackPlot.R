PirateAttacks_df = data_pirates # separating this as working data from the orignal loaded data.

pirates = PirateAttacks_df %>% 
  mutate(date = ymd(data)) %>% 
  mutate() 

# need to review how to handle the NA values, I would like to use a little imputation as possible. 
