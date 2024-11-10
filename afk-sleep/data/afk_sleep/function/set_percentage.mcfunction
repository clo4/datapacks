tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"A player is asleep, checking if playersSleepingPercentage should be calculated"}]
execute store result storage afk_sleep:set_percentage_args percent int 1 run scoreboard players get .playersSleepingPercentage afk_sleep.dummy
function afk_sleep:set_percentage_macro with storage afk_sleep:set_percentage_args
