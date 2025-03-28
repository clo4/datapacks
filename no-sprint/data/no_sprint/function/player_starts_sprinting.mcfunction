tag @s add no_sprint.is_sprinting
title @s actionbar {"text":"Sprinting is disabled"}

attribute @s movement_speed modifier add no_sprint:no_sprint -1000 add_value
attribute @s jump_strength modifier add no_sprint:no_jump -1000 add_value
