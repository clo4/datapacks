# The formula for getting the percentage as a number between 0 and 100 is this:
# (notAFK * relativePercentage) / totalPlayers

advancement revoke @s only afk_sleep:enter_bed

# .notAFK could be stored directly into .playersSleepingPercentage, but it's useful
# for debugging to keep it separate so you can see the calculation.
execute store result score .totalPlayers afk_sleep.dummy run execute if entity @a
execute store result score .notAFK afk_sleep.dummy run execute if entity @a[tag=!afk]

scoreboard players operation .playersSleepingPercentage afk_sleep.dummy = .notAFK afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy *= .relativePercentage afk_sleep.dummy
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy /= .totalPlayers afk_sleep.dummy
execute store result storage afk_sleep:set_percentage_args percent int 1 run scoreboard players get .playersSleepingPercentage afk_sleep.dummy
function afk_sleep:set_percentage with storage afk_sleep:set_percentage_args