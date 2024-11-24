tag @s add afk
scoreboard players set @s afk.left_game 0
execute as @s at @s run function #afk:away
