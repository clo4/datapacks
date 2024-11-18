execute if score @s afk matches 1.. run function afk:trigger

function afk:check_activity

execute if entity @s[tag=!afk] if score @s afk.ticks >= .ticks afk.settings at @s run function afk:tag/away
execute if entity @s[tag=afk] if score @s afk.ticks < .ticks afk.settings at @s run function afk:tag/back
