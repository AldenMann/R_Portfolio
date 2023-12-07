
#data:
data = drop_na(palmerpenguins::penguins) %>% #noticed that using glimpse() character values are factorized - need to make character. 
  mutate(species = as.character(species),
         island = as.character(island),
         sex = as.character(sex),
         year = as.character(year)) # Since wear not doing any time series analysis and I'd like to have it as drop down option. 
# the goal now will be to select the data in such a fashion that I will be able to adapt it to flex/shiny application.

data %>% select_if(is.atomic) %>% # select is atomic selects characters, and numbers but removes nested tables or array. 
    filter(str_detect(species,"Adelie")) %>% # This will sets us up for searching by species name later via a text box.
    group_by(island,sex) %>%  # There are two group by variables here, but still. Island and sex would be important ways to group - - as well as by species but choosing to not do that right now. 
    summarise_if(is.numeric, mean, na.rm=T) # here we summarise the data, is.numeric for only numerical values, mean is summary we're asking for, na.rm - well you know what that is.

## Once we've seen how we want to work with our date - swap out the parameters to make it a function:
SummaryData = function(dt){
data %>% select_if(is.atomic) %>% 
  filter(str_detect(species,"Adelie")) %>% 
  group_by(island,sex) %>%   
  summarise_if(is.numeric, mean, na.rm=T)
  
}

data %>%  SummaryData()

# now that we have the function setup, let's make those parameters adjustable:

SummaryData = function(dt,FilterBy, FilterValue = "",GroupBy){
  data %>% select_if(is.atomic) %>% 
    filter(str_detect(!! rlang::sym(FilterBy),FilterValue)) %>%  #!! allows us to search with a string - rlang::sym() allows us to search one column
    group_by(!!! rlang::syms(GroupBy)) %>%   #using 3 "!!!" allows us to group by multiple columns, 2 "!!" would allow for a single column.rlang syms() allows us to type and search by a character vecotr. 
    summarise_if(is.numeric, mean, na.rm=T)
}

# Test again, but set the parameters in the function:
data %>%  SummaryData(FilterBy = "species", FilterValue = "Adelie", GroupBy = "island")


