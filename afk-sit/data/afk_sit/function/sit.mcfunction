tag @s add afk_sit.is_sitting

execute at @s run summon armor_stand ~ ~ ~ {NoAI:1b,Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["afk_sit.active_armor_stand","afk_sit.seat"]}

execute rotated as @s run data modify entity @e[type=armor_stand,tag=afk_sit.active_armor_stand,limit=1] Rotation set from entity @s Rotation

ride @s mount @e[type=armor_stand,tag=afk_sit.active_armor_stand,limit=1]

tag @e[type=armor_stand,tag=afk_sit.active_armor_stand,limit=1] remove afk_sit.active_armor_stand

title @s times 0 10000000d 0
title @s title {"text":""}
title @s subtitle [{"text":"Press "},{"keybind":"key.sneak"},{"text":" to Stand"}]

schedule function afk_sit:loop 20t

# In 1.21.5 onwards, you can run `title @s actionbar ...` in the same
# file to suppress the default message. This change wasn't documented
# anywhere. For previous versions, you have to run the function later.
title @s actionbar {"text":""}
tag @s add afk_sit.hide_actionbar_message
schedule function afk_sit:hide_actionbar_message 1t
