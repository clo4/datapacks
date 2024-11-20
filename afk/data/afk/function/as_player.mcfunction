function afk:update_rotation

execute if entity @s[scores={afk=1..}] run function afk:trigger

execute if score @s afk.rotation = @s afk.rotation_prev run function afk:increment_ticks
execute unless score @s afk.rotation = @s afk.rotation_prev run function afk:reset_player
