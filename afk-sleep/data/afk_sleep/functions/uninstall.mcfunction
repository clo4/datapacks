# Before deleting the storage and scoreboard, we need to reset the playersSleepingPercentage
# to what it was before we started messing with it.
execute store result storage afk_sleep:set_percentage_args percent int 1 run scoreboard players get .relativePercentage afk_sleep.dummy
function afk_sleep:set_percentage with storage afk_sleep:set_percentage_args

scoreboard objectives remove afk_sleep.dummy
data remove storage afk_sleep:set_percentage_args percent