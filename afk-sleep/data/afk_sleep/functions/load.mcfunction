scoreboard objectives add afk_sleep.dummy dummy

#declare entity .relativePercentage
#declare entity .totalPlayers
#declare entity #prevTotalPlayers
#declare entity .notAFK
#declare entity .playersSleepingPercentage
#declare storage afk_sleep:set_percentage_args Arguments to call the set_percentage function with.

# We're assuming that whatever the percentage is set to when the datapack is loaded is the
# relative percentage of players that need to be sleeping in order for  
execute store result score .relativePercentage afk_sleep.dummy run gamerule playersSleepingPercentage

function afk_sleep:loop
function afk_sleep:state_change