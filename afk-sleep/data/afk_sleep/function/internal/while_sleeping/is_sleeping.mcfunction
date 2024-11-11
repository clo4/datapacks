tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Player is in bed"}]

# This function is only called if there's at least one player in a bed.
# It triggers the percentage calculation, and checks that against the
scoreboard players operation #prevPlayersSleepingPercentage afk_sleep.dummy = .playersSleepingPercentage afk_sleep.dummy

# If the gamerule has been updated by a player, the .playersSleepingPercentage score won't have been.
# This is a clear signal of intent that the player wants to change the amount of players required to
# pass the night, so store the changed value as the new .relativePercentage value.
execute store result score .gameruleValue afk_sleep.dummy run gamerule playersSleepingPercentage
execute unless score .gameruleValue afk_sleep.dummy = .playersSleepingPercentage afk_sleep.dummy run scoreboard players operation .relativePercentage afk_sleep.dummy = .gameruleValue afk_sleep.dummy

# Calculates the new playersSleepingPercentage and stores it in a scoreboard value. If it hasn't changed,
# there's no reason to set the percentage (which could potentially be expensive)
function afk_sleep:internal/while_sleeping/calculate
execute in minecraft:overworld unless score .playersSleepingPercentage afk_sleep.dummy = #prevPlayersSleepingPercentage afk_sleep.dummy run function afk_sleep:internal/players_sleeping_percentage/set

tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Scheduling next check"}]

# 10 ticks is a 10x reduction over executing every tick, while still being fast enough that it
# feels like it properly respects the player's intent to sleep.
schedule function afk_sleep:internal/while_sleeping/check_if_sleeping 10t
