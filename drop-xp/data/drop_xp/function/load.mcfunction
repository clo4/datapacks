# Load sets up all the scoreboards, declares entities and storage, does setup, and kicks off the loop.

#declare storage drop_xp:remove_xp_storage Arguments to call the set_percentage function with.

scoreboard objectives add drop_xp.config dummy
scoreboard objectives add drop_xp.tmp dummy
scoreboard objectives add drop_xp.const dummy

scoreboard objectives add drop_xp.dropped_xp dummy
scoreboard objectives add drop_xp.xp_orb_values dummy

# The deathCount type is not automatically populated with each player's previous deaths,
# which is exactly what we want. No need to reset scores after creating this scoreboard.
scoreboard objectives add drop_xp.death_count deathCount

# Used as the denominator for the equation in player_died
scoreboard players set .100 drop_xp.const 100

# XP orb values
scoreboard players set .307 drop_xp.const 307
scoreboard players set .149 drop_xp.const 149
scoreboard players set .73 drop_xp.const 73
scoreboard players set .37 drop_xp.const 37
scoreboard players set .17 drop_xp.const 17
scoreboard players set .7 drop_xp.const 7
scoreboard players set .3 drop_xp.const 3
scoreboard players set .1 drop_xp.const 1

execute unless score .has_loaded_once drop_xp.config matches 1 run function drop_xp:internal/first_load