library(tidyverse)
library(RSQLite)

# Set up RSQLite database in memory:

SW_db = dbConnect(RSQLite::SQLite(), ":memory:") # can connect to outside databases as well. 

# Prepare data: films, starships and vehicles product error because of c(""), thus I have removed these columns. 
data = starwars %>% 
  select(
    -films, -starships, -vehicles
  )


# Create a new table for the characters. Actors is shorter to type.
actors = dbWriteTable(SW_db, "actors", data )

dbListTables(SW_db)

dbReadTable(SW_db, "actors")
# help("dbReadTable,SQLiteConnection,character-method")


# Can use SQL queries now, instead of using typical dplyr/tidyverse functions to explore data.
# You can query in the terminal or assign the results to an object for later processing. 

# Query for orange eyes:
orange_eyes = dbSendQuery(SW_db, "SELECT * FROM actors WHERE eye_color = 'orange'" )

# Shows results so that we can see it a table-like format:
dbFetch(orange_eyes)

