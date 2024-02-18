PirateAttacks_df = data_pirates # separating this as working data from the orignal loaded data.

pirates = PirateAttacks_df %>% 
  mutate(date = ymd(date)) %>% # might try an imputation for missing dates. 
  mutate(time = hm(time)) # some values are NA so we'll need to impute for time.

# need to review how to handle the NA values, I would like to use a little imputation as possible. 


str(PirateAttacks_df)
