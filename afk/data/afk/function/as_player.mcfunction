execute if score @s afk matches 1.. run function afk:trigger

function afk:increment

execute if entity @s[tag=!afk] if score @s afk.seconds_inactive >= .seconds_inactive afk.settings at @s run function afk:tag/away
execute if entity @s[tag=afk] if score @s afk.seconds_inactive < .seconds_inactive afk.settings at @s run function afk:tag/back
