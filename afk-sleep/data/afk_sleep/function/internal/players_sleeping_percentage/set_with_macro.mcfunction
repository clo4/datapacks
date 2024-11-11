tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Setting using macro"}]
execute store result storage afk_sleep:set_percentage_args percent int 1 run scoreboard players get .playersSleepingPercentage afk_sleep.dummy
function afk_sleep:internal/players_sleeping_percentage/_macro with storage afk_sleep:set_percentage_args
