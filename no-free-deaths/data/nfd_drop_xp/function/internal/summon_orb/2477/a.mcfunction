summon minecraft:experience_orb ~ ~ ~ {Value:2477,Motion:[-0.034d,0.033d,0.079d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .2477 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 2477.. run function nfd_drop_xp:internal/summon_orb/2477/b
