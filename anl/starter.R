library(tidyverse)

config <- ini::read.ini("database.ini")$cockroach
db_con <- DBI::dbConnect(
  RPostgres::Postgres(),
  host = config$host,
  port = as.integer(config$port),
  user = config$user,
  password = config$password,
  dbname = config$dbname
)

# Lazy evaluation
df <- tbl(db_con, I("nba.nba_player_box_score_vw")) |>
  filter(season == "2025-26") |>
  as_tibble() |> # Crystalise lazy query
  # id cols get read in a int64 which causes error on when manipulating...
  mutate(across(where(\(x) inherits(x, "integer64")), as.integer))
