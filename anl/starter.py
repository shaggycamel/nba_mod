import configparser
import psycopg2
import polars as pl
from pyprojroot import here

# Create database connection
config = configparser.ConfigParser()
config.read('database.ini')
db_con = psycopg2.connect(**dict(config['cockroach']))

# Read into polars dataframe
df = pl.read_database(here('data/test_query.sql').read_text(), db_con)

# Example of df manipulation
# Top 20 players for avg points per game in 2025-26 season
(
    df.filter(pl.col('season') == '2025-26', pl.col('min') > 10)
    .with_columns(
        [
            (pl.col('pts') / pl.col('min')).alias('pts_per_min'),
            pl.col('player_name').str.to_titlecase(),
        ]
    )
    .group_by('player_id', 'player_name', 'team')
    .agg(
        [
            pl.col('pts').mean().alias('avg_pts'),
            pl.col('pts_per_min').mean().alias('avg_pts_per_min'),
            pl.col('game_id').count().alias('games_played'),
        ]
    )
    .filter(pl.col('games_played') >= 10)
    .sort('avg_pts', descending=True)
    .head(20)
)
