PirateAttacks_df = data_pirates # separating this as working data from the original loaded data.

pirates = PirateAttacks_df 
  
# For time series data - selecting only columns with time  
pirate_time = pirates %>% 
  filter(!is.na(time)) # I may want to consider using posix time or similar to do calculations, but may not be needed.

T1 = pirate_time %>% 
  group_by(nearest_country) %>% 
  summarise(total_attacks = n()) %>% 
  arrange(desc(total_attacks))

P1 = pirate_time %>% 
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude, radius = 1) %>% 
  print(P1)
