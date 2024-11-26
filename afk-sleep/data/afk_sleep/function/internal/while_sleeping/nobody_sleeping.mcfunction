#debug tellraw @a[tag=afk_sleep.log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"No players are currently sleeping, resetting gamerule value"}]

gamerule playersSleepingPercentage -4
scoreboard players set .playersSleepingPercentage afk_sleep.dummy -4
