xp add @s -1 levels
scoreboard players operation @s nfd_drop_xp.levels_to_remove -= .1 nfd_drop_xp.const
execute if score @s nfd_drop_xp.levels_to_remove matches 1.. run function nfd_drop_xp:internal/remove_xp
