schedule clear afk:loop

scoreboard objectives remove afk
scoreboard objectives remove afk.settings

scoreboard objectives remove afk.rot_previous
scoreboard objectives remove afk.rot_current

scoreboard objectives remove afk.is_in_same_pos
scoreboard objectives remove afk.seconds_inactive

tag @a[tag=afk] remove afk
