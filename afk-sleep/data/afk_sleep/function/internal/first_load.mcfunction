scoreboard players set .hasLoadedOnce afk_sleep.dummy 1

# We're assuming that whatever the percentage is set to when the datapack is loaded is the
# relative percentage of players that need to be sleeping in order for  
execute store result score .relativePercentage afk_sleep.dummy run gamerule playersSleepingPercentage
