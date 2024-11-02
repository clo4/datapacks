scoreboard objectives add no_free_deaths.drop_xp.settings dummy
scoreboard objectives add no_free_deaths.drop_xp.const dummy
scoreboard objectives add no_free_deaths.drop_xp.lost_levels dummy
scoreboard objectives add no_free_deaths.drop_xp.xp_orb_values dummy

# Used as the denominator for the equation in on_death
scoreboard players set .100 no_free_deaths.drop_xp.const 100

# XP orb values
scoreboard players set .307 no_free_deaths.drop_xp.const 307
scoreboard players set .149 no_free_deaths.drop_xp.const 149
scoreboard players set .73 no_free_deaths.drop_xp.const 73
scoreboard players set .37 no_free_deaths.drop_xp.const 37
scoreboard players set .17 no_free_deaths.drop_xp.const 17
scoreboard players set .7 no_free_deaths.drop_xp.const 7
scoreboard players set .3 no_free_deaths.drop_xp.const 3
scoreboard players set .1 no_free_deaths.drop_xp.const 1
