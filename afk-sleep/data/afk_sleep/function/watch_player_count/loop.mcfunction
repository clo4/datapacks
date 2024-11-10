tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Player is sleeping, checking if playersSleepingPercentage should be recalculated"}]

# This function tries to only run the calculation if there's anything to calculate.
# Since the formula's output depends on 3 variables, check if any of them have changed.
scoreboard players operation #prevRelativePercentage afk_sleep.dummy = .relativePercentage afk_sleep.dummy
scoreboard players operation #prevNotAFK afk_sleep.dummy = .notAFK afk_sleep.dummy

execute store result score .totalPlayers afk_sleep.dummy run execute if entity @a[gamemode=!spectator]
execute store result score .notAFK afk_sleep.dummy run execute if entity @a[gamemode=!spectator,tag=!afk]

execute unless score .notAFK afk_sleep.dummy = #prevNotAFK afk_sleep.dummy run function afk_sleep:calculate
execute unless score .relativePercentage afk_sleep.dummy = #prevRelativePercentage afk_sleep.dummy run function afk_sleep:calculate

schedule function afk_sleep:watch_player_count/check 10t
