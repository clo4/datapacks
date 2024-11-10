advancement revoke @s only afk_sleep:enter_bed

tellraw @a[tag=log.debug] ["",{"text":"afk_sleep ","color":"blue"},{"text":"DEBUG ","color":"dark_purple"},{"text":"Player entered bed"}]

execute unless score .dataVersion afk_sleep.dummy matches 0.. store result score .dataVersion afk_sleep.dummy run data get entity @s DataVersion

# .notAFK could be stored directly into .playersSleepingPercentage, but it's useful
# for debugging to keep it separate so you can see the calculation. Also, because this
# function is triggered by a player sleeping in a bed, the score for both of these
# is guaranteed to be at least 1.
execute store result score .totalPlayers afk_sleep.dummy run execute if entity @a[gamemode=!spectator]
execute store result score .notAFK afk_sleep.dummy run execute if entity @a[gamemode=!spectator,tag=!afk]

function afk_sleep:calculate

# After the player *should* have woken up (assuming they were able to sleep), check if
# there's anyone still asleep. If there is, this will kick off a loop that repeatedly
# calculates the playersSleepingPercentage to handle players changing gamemode, leaving,
# and going AFK.
schedule clear afk_sleep:watch_player_count/check
schedule function afk_sleep:watch_player_count/check 102t
