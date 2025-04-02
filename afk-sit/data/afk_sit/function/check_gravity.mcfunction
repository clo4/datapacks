execute as @e[type=armor_stand,tag=afk_sit.seat] at @s unless entity @e[distance=..0.00001,type=armor_stand,tag=afk_sit.seat_gravity_proxy] run kill @s
execute as @e[type=armor_stand,tag=afk_sit.seat_gravity_proxy] at @s unless entity @e[distance=..0.00001,type=armor_stand,tag=afk_sit.seat] run kill @s

schedule function afk_sit:check_gravity 20t
