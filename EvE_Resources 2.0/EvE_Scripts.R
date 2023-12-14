library(tidyverse)
library(DT)
library(plotly)


data = read.csv("Planetary Production_091320.csv")

# planet by resource
# then each planets 

data %>% 
  select_if(is.atomic) %>% 
  filter(str_detect(Resource, "Base Metals")) %>% 
  group_by(System, Planet.Name) %>% 
  summarise_if(is.numeric, mean, na.rm = T)

#A1.1 Show Perfect Resource Planets  
data %>% 
  select_if(is.atomic) %>% 
  filter(str_detect(Resource, "Base Metals")) %>% 
  group_by(Richness = "Perfect")

# A1.2 Create the above as a funcion:

RsrceFinder = function(DT, FilterBy, FilterValue = "Base Metals", GroupBy){
  data %>% 
    select_if(is.atomic) %>% 
    filter(str_detect(!! rlang::sym(FilterBy), FilterValue)) %>% 
    group_by(!!! rlang::syms(GroupBy)) %>% 
    datatable()
}



