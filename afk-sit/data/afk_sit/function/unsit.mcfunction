# The player may still be on their mount, but they may have also dismounted
# since there is no way to prevent them from doing so. The best way to deal
# with this is to handle both cases.

# First, as the player, try to kill their vehicle if it's a seat.
execute on vehicle if entity @s[tag=afk_sit.seat] run kill @s

# Then, try and kill any seats that don't have players.
kill @e[type=armor_stand,tag=afk_sit.seat,predicate=!afk_sit:has_player_passenger]

# Finally, kill the unpaired gravity proxy. If there's another unpaired one when
# this executes, it will also be killed, which doesn't have any effect since it
# was already unpaired.
execute as @e[type=armor_stand,tag=afk_sit.seat_gravity_proxy] at @s unless entity @e[distance=..0.00001,type=armor_stand,tag=afk_sit.seat] run kill @s

tag @s remove afk_sit.is_sitting
