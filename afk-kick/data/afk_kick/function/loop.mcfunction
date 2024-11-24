schedule function afk_kick:loop 60s

execute as @a[gamemode=!spectator,tag=!afk_kick.ignore] if score @s afk.ticks >= .kick_after_ticks afk_kick.settings run function afk_kick:kick
