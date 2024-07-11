library(tidyverse)
library(readxl)
library(plotly)

data = read_excel(choose.files())

D_series1 = data %>% 
  select(Company, Ticker, Sector, Industry,`P/S`)

D_series2 = data %>% 
  select(Company, Ticker, Sector, Industry,`P/S`, `Market Cap`,`Shares Outstanding`, `Shares Float`, `Institutional Ownership`) %>% 
  mutate('Total Shares' = `Market Cap`/`P/S`)

T_series2 = D_series2 %>% 
  drop_na() %>% 
  group_by(Sector) %>% 
  summarise("Sum Total Shares" = sum(`Total Shares`)) %>% 
  arrange(desc(`Sum Total Shares`))

T_series2.1 = D_series2 %>%
  filter(`Market Cap` != is.na(`Market Cap`)) %>% 
  group_by(Sector) %>% 
  summarise("Total Tickers" = n()) %>% 
  arrange(desc(`Total Tickers`))

G_series2 = ggplot(T_series2, aes(X = Sector, Y = `Sum Total Shares`)) +
  geom_col(aes(x = Sector, y = `Sum Total Shares`))

G_series2.1 = ggplot(T_series2.1) +
  geom_col(aes(x = Sector, y = `Total Tickers`,
               color = Sector)) + 
  labs(title = "Total Tickers by Sector",
       subtitle = "Finviz Data") + 
  theme(axis.text.x = element_text(angle = 35, hjust = 1)) + 
  scale_y_continuous(breaks = seq(50,2000, by = 250))


ggplotly(G_series2.1)

# ---- Stock performance by dividend yield --- 
# Does a stock performance correlate with it's dividend? More specifically, does a higher dividend have an inverse relationship on performance. 
  
# We can likely achieve this by using the EPS. Scatter plot 

Q1_Data = data %>% filter(
  `Market Cap` != is.na(`Market Cap`),
  `Market Cap` > 50,
  `Volume` > 200000,
  `P/S` > 7
)

#Need to reread the question, to finish filtering. 
