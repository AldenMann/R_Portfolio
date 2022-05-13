library(tidyverse)
library(RSQLite)

# Set up RSQLite database in memory:

SW_db = dbConnect(RSQLite::SQLite(), ":memory:")

# Prepare data: films, starships and vehicles product error because of c(""). 
data = starwars %>% 
  select(
    -films, -starships, -vehicles
  )


# Create a new table for the characters. Actors is shorter to type.
actors = dbWriteTable(SW_db, "actors", data )

dbListTables(SW_db)

dbReadTable(SW_db, "actors")
help("dbReadTable,SQLiteConnection,character-method")


