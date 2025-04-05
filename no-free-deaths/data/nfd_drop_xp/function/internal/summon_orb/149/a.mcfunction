summon minecraft:experience_orb ~ ~ ~ {Value:149,Motion:[0.0447d,0.2192d,-0.0417d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .149 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 149.. run function nfd_drop_xp:internal/summon_orb/149/b
