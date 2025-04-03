# The player may still be on their mount, but they may have also dismounted
# since there is no way to prevent them from doing so. The best way to deal
# with this is to handle both cases.

# First, as the player, try to kill their vehicle if it's a seat.
execute on vehicle if entity @s[tag=afk_sit.seat] run kill @s

# Then, try and kill any seats that don't have players.
kill @e[type=armor_stand,tag=afk_sit.seat,predicate=!afk_sit:has_player_passenger]

tag @s remove afk_sit.is_sitting

# If this was the last player to be sitting, no need to check gravity.
execute unless entity @a[tag=afk_sit.is_sitting] run schedule clear afk_sit:loop

title @s clear
title @s reset
