summon minecraft:experience_orb ~ ~ ~ {Value:37,Motion:[0.0973d,0.1606d,0.0295d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .37 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 37.. run function nfd_drop_xp:internal/summon_orb/37/b
