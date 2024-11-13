schedule function afk:loop 5s

execute as @a run function afk:update_position

# Different commands have to be run based on whether or not the player has moved their head.
# This is a temporary value used for that and is reset afterwards.
execute as @a if score @s afk.rot_current = @s afk.rot_previous run scoreboard players set @s afk.is_in_same_pos 1

# increment if the player hasn't moved, or set to 0 if they have
execute as @a[scores={afk.is_in_same_pos=1}] run scoreboard players add @s afk.seconds_not_moved 5
execute as @a[scores={afk.is_in_same_pos=0}] run scoreboard players set @s afk.seconds_not_moved 0

# reset for the next loop so no players already have their score set to 1
scoreboard players set @a afk.is_in_same_pos 0

# 3600 ticks = 180 seconds = 3 minutes
execute as @a[scores={afk.seconds_not_moved=180..},tag=!afk] at @s run function afk:tag/away
execute as @a[scores={afk.seconds_not_moved=..179},tag=afk] at @s run function afk:tag/back
