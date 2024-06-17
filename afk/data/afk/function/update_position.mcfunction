# Move the "current" rotation to the (now) previous rotation objectives in preparation to update the new scores
scoreboard players operation @s afk.rot_previous = @s afk.rot_current

# Horizontal rotation alone is used because it's functionally impossible to move the mouse vertically without
# also moving it horizontally at all (hence the huge scaling factor). It also won't change based on external
# factors such as water or entity collisions, which makes it more reliable to detect whether someone is
# *actually* AFK. Realistically you could do the same with Pos[0] because it's also functionally impossible
# to be exactly aligned with the block grid, and you may want to change this locally to Pos[0] if you want
# to allow anti-AFK machines (eg. water loops).
execute store result score @s afk.rot_current run data get entity @s Rotation[0] 100000
