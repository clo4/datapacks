tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Player is in bed"}]

# This function is only called if there's at least one player in a bed.
# It triggers the percentage calculation, and checks that against the
scoreboard players operation #prevPlayersSleepingPercentage afk_sleep.dummy = .playersSleepingPercentage afk_sleep.dummy

function afk_sleep:internal/while_sleeping/calculate

execute in minecraft:overworld unless score .playersSleepingPercentage afk_sleep.dummy = #prevPlayersSleepingPercentage afk_sleep.dummy run function afk_sleep:internal/players_sleeping_percentage/set

tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Scheduling next check"}]
# 10 ticks is a 10x reduction over executing every tick, while still being fast enough that it
# feels like it properly respects the player's intent to sleep.
schedule function afk_sleep:internal/while_sleeping/check_if_sleeping 10t
