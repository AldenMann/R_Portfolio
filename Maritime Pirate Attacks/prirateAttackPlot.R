PirateAttacks_df = data_pirates # separating this as working data from the original loaded data.

pirates = PirateAttacks_df 
  
# For time series data - selecting only columns with time  
pirate_time = pirates %>% 
  filter(!is.na(time)) %>%  # I may want to consider using posix time or similar to do calculations, but may not be needed.
  mutate(date = ymd(date))
  
T1 = pirate_time %>% 
  group_by(nearest_country) %>% 
  summarise(total_attacks = n()) %>% 
  arrange(desc(total_attacks))

# Map of Attacks
P1 = pirate_time %>% 
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(~longitude, ~latitude, radius = 1) %>% 
  print(P1)

# # Attacks by Hour (All 1993 - 2020)
T2 = pirate_time %>% 
  select(time, attack_type) %>% 
  mutate(time = hm(time),
         "hours" = hour(time)) %>% 
  drop_na() %>% 
  count(hours, attack_type)

P2 = ggplot(data = T2,
            aes(x = hours, y = n,
                color = attack_type)) + 
  geom_col() + 
  labs(title = "Pirate Attacks by Time of Day",
       x = "Time (24 Hour Format)",
       y = "Number of Attacks")

P2.1 = ggplotly(P2) %>% 
  print(P2.1)

#Attacks by Year
T3 = pirates %>% 
  select(date, attack_type) %>% 
  mutate(date = ymd(date),
         "Years" = year(date)) %>% 
  filter(attack_type != is.na(attack_type)) %>% 
  count(Years, attack_type) %>% 
  arrange(Years)

P3 = ggplot(data = T3,
            aes(x = Years, y = n,
                color = attack_type)) + 
  geom_col() + 
  labs(title = "Pirate Attacks by Year",
       x = "Year",
       y = "Number of Attacks")

P3_Plotly = ggplotly(P3) %>% 
  print(P3)

# Attack by Vessel Type
T4 = pirates %>% 
  filter(vessel_type != is.na(vessel_type)) %>% 
  count(vessel_type) %>% 
  arrange(desc(n)) %>% 
  head(10) %>% 
  mutate(vessel_type = fct_reorder(vessel_type, n, .desc = F))

P4 = ggplot(T4,
            aes(x=vessel_type, y=n, color = vessel_type)) + 
  geom_col() + 
  labs(title = "Vessels Targeted by Pirates",
       x = "Vessel Type",
       y = "Attacks") + 
  coord_flip() +
  scale_y_continuous(breaks = seq(0,350, by = 50))

P4_plotly = ggplotly(P4) %>% 
  print(P4_plotly)


### render flexdashboard as a PDF -- B/c linkedin won't let me share html file. 

rmarkdown::render(choose.files(), output_file = "PirateDashboard.pdf")
