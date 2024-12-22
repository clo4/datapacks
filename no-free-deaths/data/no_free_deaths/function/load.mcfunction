scoreboard objectives add no_free_deaths.death_count deathCount
scoreboard objectives add no_free_deaths.settings dummy
# The tmp scoreboard is used for calculating values. It MUST only be used within
# the scope of a single function.
scoreboard objectives add no_free_deaths.tmp dummy

execute unless score .has_loaded_once no_free_deaths.settings matches 1 run function no_free_deaths:internal/first_load
