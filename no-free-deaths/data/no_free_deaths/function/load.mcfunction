scoreboard objectives add no_free_deaths.death_count deathCount
scoreboard objectives add no_free_deaths.settings dummy
scoreboard objectives add no_free_deaths.tmp dummy

execute unless score .has_loaded_once no_free_deaths.settings matches 1 run function no_free_deaths:first_load

function #no_free_deaths:internal/load_mechanic

# If a mechanic has not been enabled or disabled before, it must be the first time it has
# been loaded, so call the logical first_load function for each.

execute unless score .enable_drop_xp no_free_deaths.settings matches 0.. run function no_free_deaths:mechanic/drop_xp/first_load
execute unless score .enable_curse_of_vanishing no_free_deaths.settings matches 0.. run function no_free_deaths:mechanic/curse_of_vanishing/first_load
execute unless score .enable_respawn_hunger_penalty no_free_deaths.settings matches 0.. run function no_free_deaths:mechanic/respawn_hunger_penalty/first_load
execute unless score .enable_respawn_health_penalty no_free_deaths.settings matches 0.. run function no_free_deaths:mechanic/respawn_health_penalty/first_load


# The final task is to kick off the loop respawn check. This is done as a function instead of using
# the `minecraft:tick` function tag because it gives me more places for optimisation in the future.
function no_free_deaths:internal/loop_respawn_check
