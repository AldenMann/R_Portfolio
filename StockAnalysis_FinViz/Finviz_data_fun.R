library(tidyverse)
library(readxl)

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
  geom_col(aes(x = Sector, y = `Total Tickers`))


