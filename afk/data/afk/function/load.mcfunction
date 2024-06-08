scoreboard objectives add afk.rot_previous dummy
scoreboard objectives add afk.rot_current dummy

scoreboard objectives add afk.is_in_same_pos dummy
scoreboard objectives add afk.loops_not_moved dummy

execute as @a run function afk:update_position

schedule function afk:loop 5s
