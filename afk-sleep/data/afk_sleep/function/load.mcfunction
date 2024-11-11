scoreboard objectives add afk_sleep.dummy dummy

#declare entity .hasLoadedOnce Controls whether the first_load function runs.
#declare entity .dataVersion The player data version, set by the first player that uses a bed
#declare entity .relativePercentage The original playersSleepingPercentage, used as the percentage of non-afk players that must sleep.
#declare entity #prevRelativePercentage Previous .relativePercentage value, checks if the value has changed since last calculation
#declare entity .totalPlayers The total number of players. Spectators are not counted.
#declare entity .notAFK The total numbers of non-afk, non-spectator players.
#declare entity #prevNotAFK Previous .notAFK value, checks if the value has changed since last calculation
#declare entity .playersSleepingPercentage The final calculated playersSleepingPercentage.
#declare storage afk_sleep:set_percentage_args Arguments to call the set_percentage function with.

execute unless score .hasLoadedOnce afk_sleep.dummy matches 1 run function afk_sleep:internal/first_load

# Resetting this on load means the first player to sleep will be the one that sets the data version
scoreboard players reset .dataVersion afk_sleep.dummy
