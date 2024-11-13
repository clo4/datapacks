schedule clear afk:loop

scoreboard objectives remove afk.rot_previous
scoreboard objectives remove afk.rot_current

scoreboard objectives remove afk.is_in_same_pos
scoreboard objectives remove afk.seconds_not_moved

execute as @a[tag=afk] run tag @s remove afk
