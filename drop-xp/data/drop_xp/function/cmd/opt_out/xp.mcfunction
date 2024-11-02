execute if entity @s run tag @s add drop_xp.ignore
execute if entity @s run tellraw @a ["",{"text":"Disabled death penalty "},{"text":"Drop XP (levels)","color":"red"},{"text":" for "},{"selector":"@s"}]
