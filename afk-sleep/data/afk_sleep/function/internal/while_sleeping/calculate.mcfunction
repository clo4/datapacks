# The formula for getting the percentage as a number between 0 and 100 is this:
# (notAFK * relativePercentage) / totalPlayers
tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Calculating .playersSleepingPercentage"}]

execute store result score .totalPlayers afk_sleep.dummy run execute if entity @a[predicate=afk_sleep:in_overworld,gamemode=!spectator]
execute store result score .notAFK afk_sleep.dummy run execute if entity @a[predicate=afk_sleep:in_overworld,gamemode=!spectator,tag=!afk]

scoreboard players operation .playersSleepingPercentage afk_sleep.dummy = .notAFK afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy *= .relativePercentage afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy /= .totalPlayers afk_sleep.dummy
