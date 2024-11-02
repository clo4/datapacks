execute as @e[type=minecraft:player,scores={no_free_deaths.death_count=1..}] run function no_free_deaths:internal/player_respawned
schedule function no_free_deaths:internal/loop_respawn_check 1t
