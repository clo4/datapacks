scoreboard players set @s afk 0
execute if score @s afk.ticks < .ticks afk.settings run scoreboard players operation @s afk.ticks = .ticks afk.settings

# By guaranteeing that the current and previous rotations are the same, and with the ticks set to the threshold,
# this will trigger the condition to mark the player as AFK if they currently aren't.
scoreboard players operation @s afk.rotation_prev = @s afk.rotation
scoreboard players enable @s afk
