scoreboard players add .health_penalty respawn_sickness.settings 1
execute if score .health_penalty respawn_sickness.settings matches 1 run say Health penalty is now enabled.

execute if score .health_penalty respawn_sickness.settings matches 2 run scoreboard players set .health_penalty respawn_sickness.settings 0
execute if score .health_penalty respawn_sickness.settings matches 0 run say Health penalty is now disabled.
