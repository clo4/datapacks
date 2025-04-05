scoreboard objectives add nfd_drop_xp.settings dummy
scoreboard objectives add nfd_drop_xp.const dummy

# Stores the number of levels that still have to be removed from a player.
# This value is decremented, and a level is removed, until the value is 0.
scoreboard objectives add nfd_drop_xp.levels_to_remove dummy

# The number of levels that the player has lost by dying
scoreboard objectives add nfd_drop_xp.lost_levels dummy

# The number of points in the current level that the player has lost by dying
scoreboard objectives add nfd_drop_xp.lost_points dummy

# The total value of the XP orbs that will be spawned at the player's location of death
scoreboard objectives add nfd_drop_xp.xp_orb_values dummy

# Used as the denominator for the equation in on_death
scoreboard players set .100 nfd_drop_xp.const 100

# XP orb values
scoreboard players set .2477 nfd_drop_xp.const 2477
scoreboard players set .1237 nfd_drop_xp.const 1237
scoreboard players set .617 nfd_drop_xp.const 617
scoreboard players set .307 nfd_drop_xp.const 307
scoreboard players set .149 nfd_drop_xp.const 149
scoreboard players set .73 nfd_drop_xp.const 73
scoreboard players set .37 nfd_drop_xp.const 37
scoreboard players set .17 nfd_drop_xp.const 17
scoreboard players set .7 nfd_drop_xp.const 7
scoreboard players set .3 nfd_drop_xp.const 3
scoreboard players set .1 nfd_drop_xp.const 1

# Used for calculating the full XP loss amount
scoreboard players set .6 nfd_drop_xp.const 6
scoreboard players set .405 nfd_drop_xp.const 405
scoreboard players set .25 nfd_drop_xp.const 25
scoreboard players set .360 nfd_drop_xp.const 360
scoreboard players set .10 nfd_drop_xp.const 10
scoreboard players set .45 nfd_drop_xp.const 45
scoreboard players set .2220 nfd_drop_xp.const 2220
scoreboard players set .1625 nfd_drop_xp.const 1625

# If the mechanic is neither enabled nor disabled, this must be its first load
execute unless score .enable_drop_xp no_free_deaths.settings matches 0.. run function nfd_drop_xp:internal/first_load
