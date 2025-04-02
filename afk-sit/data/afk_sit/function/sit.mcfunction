tag @s add afk_sit.is_sitting

tag @s add afk_sit.active_player
execute at @s run summon armor_stand ~ ~ ~ {NoAI:1b,Marker:1b,Invulnerable:1b,NoGravity:1b,Tags:["afk_sit.active_armor_stand","afk_sit.seat"]}
execute at @s run summon armor_stand ~ ~ ~ {NoAI:1b,Invulnerable:1b,Tags:["afk_sit.seat_gravity_proxy"]}

execute as @e[type=armor_stand,tag=afk_sit.seat] unless entity @e[type=armor_stand,tag=afk_sit.seat_gravity_proxy,distance=..0.0001] run say hi

execute as @n[type=armor_stand,tag=afk_sit.active_armor_stand] at @s rotated as @p[tag=afk_sit.active_player] run tp @s ~ ~ ~ ~ ~

ride @s mount @e[type=armor_stand,tag=afk_sit.active_armor_stand,limit=1]

tag @e[type=player,tag=afk_sit.active_player] remove afk_sit.active_player
tag @e[type=armor_stand,tag=afk_sit.active_armor_stand] remove afk_sit.active_armor_stand

# Hides the "Press <key> to dismount" text
title @s actionbar {"text":""}
