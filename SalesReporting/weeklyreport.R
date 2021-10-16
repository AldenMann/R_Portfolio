#Libraries
library(tidyverse)
library(lubridate)

# Static Lines of code

data = read.csv(choose.files(), na.strings = c("")) # Opens file explore to choose csv file

# Check the NA's before running:

data %>% 
  filter(!complete.cases(data))


data_tidy = data %>% 
  mutate(QUOTE.DATE = mdy(QUOTE.DATE)) %>% 
  mutate(PO.DATE = mdy(PO.DATE)) %>% 
  mutate(INVOICE.DATE = mdy(INVOICE.DATE)) %>% 
  mutate(CONVERTED = PO.DATE - QUOTE.DATE) %>% # Might not be needed, should already by calculated in Excel
  mutate(CLOSED = INVOICE.DATE - PO.DATE) %>% # Might not be needed, should already by calculated in Excel
  select(-CONVERSION.RATE, -CLOSED.RATE) # May not need this since it'll only be one column. 

#---------- For Getting the average conversion and closure dates from all all data points:

converted_stats = data_tidy %>% 
  select(CONVERTED) %>% 
  drop_na %>% 
  summarise(Mean = signif(mean(CONVERTED),3), Count = length(CONVERTED))

closed_stats = data_tidy %>% 
  select(CLOSED) %>% 
  drop_na %>% 
  summarise(Mean = signif(mean(CLOSED),3), Count = length(CLOSED))


#-----------Weekly Details for the Report: Within the last 7 days:

# Quotes made in the Last 7 days
quotes_week = data_tidy %>% 
  drop_na() %>% 
  select(QUOTE.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(QUOTE.DATE >= today("GMT")-days(7)) %>% 
  count()

# PO's in the Last 7 days -- PO's received this week
po_week = data_tidy %>% 
  drop_na() %>% 
  select(PO.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(PO.DATE >= today("GMT")-days(7)) %>% 
  count()

# PO's closed in the Last 7 days -- Shipped this week
close_week = data_tidy %>% 
  drop_na() %>% 
  select(INVOICE.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(INVOICE.DATE >= today("GMT")-days(7)) %>% 
  count()

#-----------Weekly Details for the Report: Within the last 30 days:

# Quotes made in the Last 30 days
quotes_month = data_tidy %>% 
  drop_na() %>% 
  select(QUOTE.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(QUOTE.DATE >= today("GMT")-days(30)) %>% 
  count()

# PO's in the Last 30 days
po_month = data_tidy %>% 
  drop_na() %>% 
  select(PO.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(PO.DATE >= today("GMT")-days(30)) %>% 
  count()

# PO's closed in the Last 30 days
close_month = data_tidy %>% 
  drop_na() %>% 
  select(INVOICE.DATE) %>% #Might need to change range, should inlcude quote#, Client, Cat.No., and qty
  filter(INVOICE.DATE >= today("GMT")-days(30)) %>% 
  count()

# Open PO's this month:
open_po = po_month - close_month

## *** The next session will be for the year. use median not mean

#---------- Filter using a specific Date for a product: 
week_PRODUCT1 = data_tidy %>% 
  select(Cat.No., QTY, ID, CLIENT, COUNTRY, QUOTE.DATE) %>% 
  filter(QUOTE.DATE >= as.Date("2021-09-20")) %>% 
  filter(Cat.No.== "ABC")

week_PRODUCT2 = data_tidy %>% 
  select(Cat.No., QTY, ID, CLIENT, COUNTRY, QUOTE.DATE) %>% 
  filter(QUOTE.DATE >= as.Date("2021-09-20")) %>% 
  filter(Cat.No.== "DEF")


week_PRODUCT3 = data_tidy %>%
  select(Cat.No., QTY, ID, CLIENT, COUNTRY, QUOTE.DATE) %>%
  filter(QUOTE.DATE >= as.Date("2021-09-20")) %>%
  filter(Cat.No.== "GHI")

#---------- If you want to filter from the current

# Last 7 days
data_tidy %>% 
  drop_na() %>% 
  select(Cat.No.:QUOTE.DATE) %>% 
  filter(QUOTE.DATE >= today("GMT")-days(7))

#---------- 

knitr::kable(week_PRODUCT1, caption = "Product ABC This week",
             col.names = c("Product", "Quantity", "ID", "Client", "Country", "Quote Date"))

knitr::kable(week_PRODUCT2, caption = "Product DEF This week",
             col.names = c("Product", "Quantity", "ID", "Client", "Country", "Quote Date"))

knitr::kable(week_PRODUCT3, caption = "Product GHI This week",
             col.names = c("Product", "Quantity", "ID", "Client", "Country", "Quote Date"))


#Another option:
Totals = data_tidy %>% group_by(Cat.No.) %>% summarize(Total = sum(QTY), Orders = n())

knitr::kable(Totals, caption = "Total Quantities Quoted For Each Product")
