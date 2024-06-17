scoreboard objectives add afk_sleep.dummy dummy

#declare entity .hasLoadedOnce Controls whether the first_load function runs.
#declare entity .relativePercentage The original playersSleepingPercentage, used as the percentage of non-afk players that must sleep.
#declare entity .totalPlayers The total number of players. Spectators are not counted.
#declare entity .notAFK The total numbers of non-afk, non-spectator players.
#declare entity .playersSleepingPercentage The final calculated playersSleepingPercentage.
#declare storage afk_sleep:set_percentage_args Arguments to call the set_percentage function with.

execute unless score .hasLoadedOnce afk_sleep.dummy matches 1 run function afk_sleep:first_load
