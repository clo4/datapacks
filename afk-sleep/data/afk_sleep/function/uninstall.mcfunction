tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Uninstalling"}]
# Before deleting the storage and scoreboard, we need to reset the playersSleepingPercentage
# to what it was before we started messing with it.
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy = .relativePercentage afk_sleep.dummy
function afk_sleep:internal/players_sleeping_percentage/set

scoreboard objectives remove afk_sleep.dummy
data remove storage afk_sleep:set_percentage_args percent

schedule clear afk_sleep:internal/while_sleeping/check_if_sleeping
tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Uninstalled"}]
