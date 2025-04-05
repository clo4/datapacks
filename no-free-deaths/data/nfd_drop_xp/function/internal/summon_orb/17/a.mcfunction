summon minecraft:experience_orb ~ ~ ~ {Value:17,Motion:[-0.0681d,0.1597d,0.0552d]}
scoreboard players operation @s no_free_deaths.drop_xp.xp_orb_values -= .17 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.xp_orb_values matches 17.. run function nfd_drop_xp:internal/summon_orb/17/b
