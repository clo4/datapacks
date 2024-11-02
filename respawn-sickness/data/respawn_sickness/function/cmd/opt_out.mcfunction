execute if entity @s run tag @s add respawn_sickness.ignore
execute if entity @s run tellraw @a ["",{"text":"Disabled death penalty "},{"text":"Respawn Sickness","color":"red"},{"text":" for "},{"selector":"@s"}]
