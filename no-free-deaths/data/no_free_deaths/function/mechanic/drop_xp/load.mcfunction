scoreboard objectives add no_free_deaths.drop_xp.settings dummy
scoreboard objectives add no_free_deaths.drop_xp.const dummy

# Stores the number of levels that still have to be removed from a player.
# This value is decremented, and a level is removed, until the value is 0.
scoreboard objectives add no_free_deaths.drop_xp.levels_to_remove dummy

# The number of levels that the player has lost by dying
scoreboard objectives add no_free_deaths.drop_xp.lost_levels dummy

# The number of points in the current level that the player has lost by dying
scoreboard objectives add no_free_deaths.drop_xp.lost_points dummy

# The total value of the XP orbs that will be spawned at the player's location of death
scoreboard objectives add no_free_deaths.drop_xp.xp_orb_values dummy

# Used as the denominator for the equation in on_death
scoreboard players set .100 no_free_deaths.drop_xp.const 100

# XP orb values
scoreboard players set .2477 no_free_deaths.drop_xp.const 2477
scoreboard players set .1237 no_free_deaths.drop_xp.const 1237
scoreboard players set .617 no_free_deaths.drop_xp.const 617
scoreboard players set .307 no_free_deaths.drop_xp.const 307
scoreboard players set .149 no_free_deaths.drop_xp.const 149
scoreboard players set .73 no_free_deaths.drop_xp.const 73
scoreboard players set .37 no_free_deaths.drop_xp.const 37
scoreboard players set .17 no_free_deaths.drop_xp.const 17
scoreboard players set .7 no_free_deaths.drop_xp.const 7
scoreboard players set .3 no_free_deaths.drop_xp.const 3
scoreboard players set .1 no_free_deaths.drop_xp.const 1

# Used for calculating the full XP loss amount
scoreboard players set .6 no_free_deaths.drop_xp.const 6
scoreboard players set .405 no_free_deaths.drop_xp.const 405
scoreboard players set .25 no_free_deaths.drop_xp.const 25
scoreboard players set .360 no_free_deaths.drop_xp.const 360
scoreboard players set .10 no_free_deaths.drop_xp.const 10
scoreboard players set .45 no_free_deaths.drop_xp.const 45
scoreboard players set .2220 no_free_deaths.drop_xp.const 2220
scoreboard players set .1625 no_free_deaths.drop_xp.const 1625

# If the mechanic is neither enabled nor disabled, this must be its first load
execute unless score .enable_drop_xp no_free_deaths.settings matches 0.. run function no_free_deaths:mechanic/drop_xp/internal/first_load
