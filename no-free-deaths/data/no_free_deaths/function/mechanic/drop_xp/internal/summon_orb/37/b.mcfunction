summon minecraft:experience_orb ~ ~ ~ {Value:37,Motion:[0.022d,0.173d,-0.091d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .37 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 37.. run function no_free_deaths:mechanic/drop_xp/internal/summon_orb/37/a
