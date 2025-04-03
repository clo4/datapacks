tag @s add afk_sit.is_sitting

execute at @s run summon armor_stand ~ ~ ~ {NoAI:1b,Marker:1b,Invulnerable:1b,NoGravity:1b,Invisible:1b,Tags:["afk_sit.active_armor_stand","afk_sit.seat"]}

# There isn't an easy way to summon an entity with another entity's rotation,
# but there are a few ways to set the rotation after the fact. You could use
# /data, /tp, or /rotate. Of all of these, /rotate is the only one that doesn't
# seem to introduce a weird rotation of the player's body before fixing itself.
execute rotated as @s run rotate @e[type=armor_stand,tag=afk_sit.active_armor_stand,limit=1] ~ ~

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
