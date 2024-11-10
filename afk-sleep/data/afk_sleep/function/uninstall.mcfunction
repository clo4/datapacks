# Before deleting the storage and scoreboard, we need to reset the playersSleepingPercentage
# to what it was before we started messing with it.
scoreboard players operation .playersSleepingPercentage afk_sleep.dummy = .relativePercentage afk_sleep.dummy
function afk_sleep:set_percentage

scoreboard objectives remove afk_sleep.dummy
data remove storage afk_sleep:set_percentage_args percent

schedule clear afk_sleep:watch_player_count/check
