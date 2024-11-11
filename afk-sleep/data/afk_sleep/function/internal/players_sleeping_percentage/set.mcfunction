tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Setting playersSleepingPercentage"}]
execute if score .dataVersion afk_sleep.dummy matches 3567.. run function afk_sleep:internal/players_sleeping_percentage/set_with_macro
execute unless score .dataVersion afk_sleep.dummy matches 3567.. run function afk_sleep:internal/players_sleeping_percentage/set_no_macro
