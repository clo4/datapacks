summon minecraft:experience_orb ~ ~ ~ {Value:307,Motion:[0.004d,0.195d,0.089d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .307 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 307.. run function nfd_drop_xp:internal/summon_orb/307/a
