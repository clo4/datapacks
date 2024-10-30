scoreboard players reset @s respawn_sickness.death_count

execute if entity @s[gamemode=!creative,gamemode=!spectator,tag=!respawn_sickness.ignore] run function respawn_sickness:internal/apply_penalties
