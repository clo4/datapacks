schedule function afk_kick:loop 60s

execute as @a[scores={afk.ticks=18000..},gamemode=!spectator,tag=!afk_kick.ignore] run function afk_kick:kick
