# This selector only targets players that are alive, unlike @a and @s
execute as @e[type=player,scores={respawn_hunger.death_count=1}] run function respawn_hunger:player_respawned
schedule function respawn_hunger:loop 10t
