# #Load Libraries
# library(tidyverse) # All the good stuff + lubridate
# # install.packages("zoo")
# library(zoo) # zoo has a nicer function for creating quarterly data thal lubridate IMO. 
# library(plotly)
# 
# 
# 
# # Load Raw Data
# data_raw = read.csv(choose.files())
# 
# # Soft Inspect the Data
# head(data_raw)
# tail(data_raw)
# 
# # Need to include a revenue column
# Rev_Data = data_raw %>% 
#   mutate(Unit.Price = as.numeric(str_remove_all(Unit.Price, ","))) %>% # - cammas, convert to numeric
#   mutate(Revenue = Order.Quantity * Unit.Price) %>% # Sale value
#   mutate(X_SalesTeamID = factor(X_SalesTeamID)) %>%  # convert IDs from num. to factors. 
#   mutate(ShipDate = dmy(ShipDate)) %>% 
#   mutate(Quarter = as.yearqtr(ShipDate)) %>% 
#   filter(Sales.Channel == "In-Store" | Sales.Channel == "Online")
# 
# # We'll need some high level overviews for the data. Sales by quarter/year.
# 
# rev_hist_data = Rev_Data %>% 
#   select(Sales.Channel, Revenue, Quarter)
# 
# Rev_graph = ggplot(data = rev_hist_data, aes(x = Quarter, y = Revenue)) +
#   geom_col(fill = "#009E73") + 
#   facet_grid(~Sales.Channel) + 
#   labs(
#     title = "Sales by Quarter",
#     subtitle = "In-Store vs Online"
#   ) + 
#   scale_y_continuous(NULL,
#                      labels = scales::label_dollar()
#   ) + 
#   theme(axis.text.x = element_text(angle = 35, hjust = 1)) + 
#   theme(axis.title.x = element_text(margin = 5.25)) + 
#   theme(axis.title.y.left = element_text(margin = 5))
# 
# Rev_graph %>% ggplotly()
#   

# Version 2.0 Below. 
# Tried to tidy it up a little more below. It's still a very busy graph, and should either be simplified or done in flexdashboard

# Load Libraries
library(tidyverse) 
library(zoo) 
library(plotly)

# Load Raw Data
data_raw = read.csv(choose.files())

# Soft Inspect the Data
head(data_raw)
tail(data_raw)

# Transform and filter data
Rev_Data = data_raw %>% 
  mutate(Unit.Price = as.numeric(str_remove_all(Unit.Price, ",")),
         Revenue = Order.Quantity * Unit.Price,
         X_SalesTeamID = factor(X_SalesTeamID),
         ShipDate = dmy(ShipDate),
         Quarter = as.yearqtr(ShipDate)) %>% 
  filter(Sales.Channel %in% c("In-Store", "Online"))

# Visualize sales data
Plot_1 = Rev_Data %>% 
  ggplot(aes(x = Quarter, y = Revenue)) +
  geom_col(fill = "#009E73") + 
  facet_grid(~Sales.Channel) + 
  labs(title = "Sales by Quarter",
       subtitle = "In-Store vs Online") + 
  scale_y_continuous(NULL, labels = scales::label_dollar()) +
  theme(axis.text.x = element_text(angle = 35, hjust = 1)) + 
  theme(axis.title.x = element_text(margin = 5.25)) + 
  theme(axis.title.y.left = element_text(margin = 5))

Graph_1 = ggplotly(Plot_1)

