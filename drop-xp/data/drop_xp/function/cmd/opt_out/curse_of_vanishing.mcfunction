execute if entity @s run tag @s add drop_xp.ignore_curse_of_vanishing
execute if entity @s run tellraw @a ["",{"text":"Disabled death penalty "},{"text":"Drop XP (Curse of Vanishing)","color":"red"},{"text":" for "},{"selector":"@s"}]
