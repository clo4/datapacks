scoreboard players operation @s afk.rotation_prev = @s afk.rotation

# Horizontal rotation alone is used to detect activity because it's functionally
# impossible to move the mouse vertically without also moving it horizontally at
# all, hence the huge scaling factor to magnify this.
execute store result score @s afk.rotation run data get entity @s Rotation[0] 100000

# NOTE: This is detecting the trigger, not whether a player is currently AFK.
execute if score @s afk matches 1.. run function afk:trigger

# Joining the game always counts as activity, so the ticks inactive should be reset.
# There isn't a way to detect joining directly, but you can detect leaving, so players
# with a leave_game score must have joined since the last check.
execute if score @s afk.adapt matches 1 run scoreboard players set @s afk.adapt 0
execute if score @s afk.left_game matches 1.. run scoreboard players set @s afk.adapt 1
execute if score @s afk.left_game matches 1.. run function afk:player_joined
execute if score @s afk.adapt matches 1 run return 1
execute if score @s afk.adapt1 matches 1 run scoreboard players set @s afk.adapt1 0
execute if score @s afk.rotation = @s afk.rotation_prev run scoreboard players set @s afk.adapt1 1
execute if score @s afk.rotation = @s afk.rotation_prev run function afk:increment_ticks
execute if score @s afk.adapt1 matches 1 run return 1
function afk:reset_player
