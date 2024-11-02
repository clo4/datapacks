summon minecraft:experience_orb ~ ~ ~ {Value:1,Motion:[0.0609d,0.1278d,0.0376d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .1 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 1.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/1/b
