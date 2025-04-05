xp add @s -1 levels
scoreboard players operation @s no_free_deaths.drop_xp.levels_to_remove -= .1 no_free_deaths.drop_xp.const
execute if score @s no_free_deaths.drop_xp.levels_to_remove matches 1.. run function nfd_drop_xp:internal/remove_xp
