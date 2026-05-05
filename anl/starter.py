import configparser
import psycopg2
import polars as pl

config = configparser.ConfigParser()
config.read("database.ini")
db_con = psycopg2.connect(**dict(config["cockroach"]))

df = pl.read_database(, db_con).filter(
    pl.col("season") == "2025-26"
)
