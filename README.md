# nba_mod

Database credentials are stored in `./database.ini` file.

User: kobe_public has read only access to all views on the nba database, they are:

1. nba.nba_injuries_vw
1. nba.nba_player_box_score_vw
1. nba.nba_player_info_vw
1. nba.nba_schedule_vw
1. nba.nba_season_segments_vw
1. nba.nba_team_box_score_vw
1. nba.nba_team_roster_vw
1. nba.nba_teams_vw

There are more views within the database, but they are relevant to other things. 
kobe_public does not have acess to tables, or write access anywhere.

# Package mgmt Python

Ensure uv is installed.

1. Install on Mac with `brew install uv` - unsure windows.
1. Create an environment `uv venv`
1. Activate virtual environment ` source .venv/bin/activate`
1. Scaffold new project `uv init`
1. Install deps from lock file `uv sync`
1. Install new package `uv pip install <pkg>`
1. Add package to lock file `uv add <pkg>`

# Package mgmt R

Ensure renv is installed

1. Install system wide with `install.packages("renv")`
1. Create an environment `renv::init()`
1. Environment activated automatically if project set properly in IDE
1. Install deps from lock file `renv::hydrate()`
1. Install new package `renv::install("<pkg>")`
1. Add package to lock file `renv::snapshot()`

# Code formatting

1. Python defaults to configuration in ruff.toml file
    1. Ensure ruff extension is installed
1. R defaults to configuration in air.toml file
    1. Ensure air extension is installed

Formatting will happen automatically on file save.