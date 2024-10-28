scoreboard players reset @s respawn_hunger.death_count
execute if score .hunger_penalty respawn_hunger.settings matches 1 if entity @s[tag=!respawn_hunger.ignore] run effect give @s hunger 2 255 true
execute if score .health_penalty respawn_hunger.settings matches 1 if entity @s[tag=!respawn_hunger.ignore] run effect give @s instant_damage 1 1 true
