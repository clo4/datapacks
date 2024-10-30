# This selector only targets players that are alive, unlike @a and @s
execute as @e[type=player,scores={respawn_sickness.death_count=1..}] run function respawn_sickness:internal/player_respawned
schedule function respawn_sickness:internal/loop 10t
