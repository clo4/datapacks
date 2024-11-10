# This function expects that .notAFK and .totalPlayers have been set.

tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Calculating playersSleepingPercentage"}]

# The formula for getting the percentage as a number between 0 and 100 is this:
# (notAFK * relativePercentage) / totalPlayers

scoreboard players operation .playersSleepingPercentage afk_sleep.dummy = .notAFK afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy *= .relativePercentage afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy /= .totalPlayers afk_sleep.dummy

execute if score .dataVersion afk_sleep.dummy matches 3567.. run function afk_sleep:set_percentage
execute if score .dataVersion afk_sleep.dummy matches ..3566 run function afk_sleep:set_percentage_no_macro
