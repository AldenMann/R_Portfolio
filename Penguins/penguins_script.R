# The project will likely be to graph the different physical attributes of the penguins, Usng facets and create a section for different measurements. 

# Raw looks like most fun, QUESTIONS I CAN ASK A VISUALIZE:
# data_Q1: Relationship: Body Mass ~ Sex between species.
# Body mass ~ flipper size
# 

install.packages('palmerpenguins')


library(palmerpenguins)
library(tidyverse)
# library(bslib) # This is for rmarkdown html themes for rmarkdown. 



data = palmerpenguins::penguins %>% drop_na()

head(data)
tail(data)
glimpse(data)
colnames(data)

# Flipper length ~ Body Mass by Species and Sex
plot_1 = ggplot() + 
  geom_point(data = data, 
             aes(x = body_mass_g, y = flipper_length_mm, 
                 color = sex)) +
  facet_grid(~species) +
  labs(title = "Antarctic Penguin Flipper Lengths by Body Mass", subtitle = "A multiple species analysis") + 
  xlab("Body Mass (g)") +
  ylab("Flipper Length (mm)")

#_____ Summary tabels:

table_1_M = data_penguins %>% 
  filter(sex == "male") %>% 
  group_by(species) %>% 
  summarize("No. Inviduals" = n(),
            "Average Flipper Length (mm)" = mean(flipper_length_mm))

table_1_F = data_penguins %>% 
  filter(sex == "female") %>% 
  group_by(species) %>% 
  summarize("No. Inviduals" = n(), "Average Flipper Length (mm)" = mean(flipper_length_mm))

# Bill depth ~ bill length by species and sex
plot_2 = ggplot() + 
  geom_point(data = data, 
             aes(x = bill_length_mm, y = bill_depth_mm, 
                 color = sex)) +
  facet_grid(~species) +
  labs(title = "Antarctic Penguin bill depth against bill length", subtitle = "A multiple species analysis") + 
  xlab("Bill Length (mm)") +
  ylab("Bill Depth (mm)")

#___ Summary tabe 2

table_2_M = data_penguins %>% 
  filter(sex == "male") %>% 
  group_by(species) %>% 
  summarize("No. Individuals" = n(), 
            "Average Bill Depth (mm)" = mean(bill_depth_mm), 
            "Average Bill Length (mm)" = mean(bill_length_mm))

table_2_F = data_penguins %>% 
  filter(sex == "female") %>% 
  group_by(species) %>% 
  summarize("No. Individuals" = n(), 
            "Average Bill Depth (mm)" = mean(bill_depth_mm), 
            "Average Bill Length (mm)" = mean(bill_length_mm))


# citation()
citation(package = "palmerpenguins")
citation(package = 'bslib')
citation(package = 'tidyverse')


