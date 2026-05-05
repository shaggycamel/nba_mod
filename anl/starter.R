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

# Lazy evaluation - just refernce object name, manipualte afterwards...
# Use as_tibble to execute the sql query on db connection
df <- tbl(db_con, I("nba.nba_player_box_score_vw")) |>
  filter(season == "2025-26") |>
  as_tibble() |> # Crystalise lazy query
  # id cols get read in a int64 which causes error on when manipulating...
  mutate(across(where(\(x) inherits(x, "integer64")), as.integer))


# Example of df manipulation
# Top 20 players for avg points per game in 2025-26 season
df |>
  filter(min > 10) |>
  mutate(
    pts_per_min = pts / min,
    player_name = str_to_title(player_name)
  ) |>
  summarise(
    avg_pts = mean(pts),
    avg_pts_per_min = mean(pts_per_min),
    games_played = n(),
    .by = c(player_id, player_name, team)
  ) |>
  filter(games_played >= 10) |>
  slice_max(avg_pts, n = 20)
