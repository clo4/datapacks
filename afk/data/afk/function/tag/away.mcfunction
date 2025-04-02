tag @s add afk
scoreboard players set @s afk.left_game 0

title @s times 0 100000000d 0
title @s title ""
title @s subtitle "Move your mouse to resume"
attribute @s movement_speed modifier add afk:afk -10000 add_value

function #afk:away
